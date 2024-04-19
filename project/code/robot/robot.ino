/********
E80 Lab 7 Surface Activity Code
Authors:
    Omar Aleman (oaleman@g.hmc.edu) '21 (contributed 2019)
    Wilson Ives (wives@g.hmc.edu) '20 (contributed in 2018)
    Christopher McElroy (cmcelroy@g.hmc.edu) '19 (contributed in 2017)
    Josephine Wong (jowong@hmc.edu) '18 (contributed in 2016)
    Apoorva Sharma (asharma@hmc.edu) '17 (contributed in 2016)
*/

#include <Arduino.h>
#include <Wire.h>
#include <avr/interrupt.h>
#include <avr/io.h>

#include <ADCSampler.h>
#include <ErrorFlagSampler.h>
#include <Logger.h>
#include <MotorDriver.h>
#include <Pinouts.h>
#include <Printer.h>
#include <SensorGPS.h>
#include <SensorIMU.h>
#include <SurfaceControl.h>
#include <TimingOffsets.h>
#include <XYStateEstimator.h>
#define UartSerial Serial1
#include <GPSLockLED.h>
#include <SalinitySampler.h>
#include <SonarSampler.h>

/////////////////////////* Global Variables *////////////////////////

MotorDriver motor_driver;
XYStateEstimator xy_state_estimator;
SurfaceControl surface_control;
SensorGPS gps;
Adafruit_GPS GPS(&UartSerial);
ADCSampler adc;
ErrorFlagSampler ef;
SensorIMU imu;
Logger logger;
Printer printer;
GPSLockLED led;

SalinitySampler salinity_sampler;
SonarSampler sonar_sampler;

// loop start recorder
int loopStartTime;
int currentTime;
volatile bool EF_States[NUM_FLAGS] = {1, 1, 1};

int lastSonarTime = millis();

////////////////////////* Setup *////////////////////////////////

void setup() {
  analogReadAveraging(0);

  logger.include(&imu);
  logger.include(&gps);
  logger.include(&xy_state_estimator);
  logger.include(&surface_control);
  logger.include(&motor_driver);
  logger.include(&adc);
  logger.include(&ef);
  logger.init();

  printer.init();
  ef.init();
  imu.init();
  UartSerial.begin(9600);
  gps.init(&GPS);
  motor_driver.init();
  led.init();
  salinity_sampler.init();
  sonar_sampler.init();

  int navigateDelay =
      0; // how long robot will stay at surface waypoint before continuing (ms)

  const int num_surface_waypoints = 2; // Set to 0 if only doing depth control
  double surface_waypoints[] = {0, -10, 0, 0}; // out and back
  // double surface_waypoints[] = {2, -2, 2, -4, 0, -4, 0, -2, 0, 0}; // square
  // double surface_waypoints[] = {0, -3, 1, -3, 2, -3, 3, -3, 3, -2, 2, -2, 1,
  // -2, 1, -1, 2, -1, 3, -1, 3, 0, 2, 0, 1, 0}; // grid used to be {125, -40,
  // 150, -40, 125, -40}; // listed as x0,y0,x1,y1, ... etc.
  surface_control.init(num_surface_waypoints * 2, surface_waypoints,
                       navigateDelay);

  xy_state_estimator.init();

  // Sonar Setup
  pinMode(TRIGGER_PIN, OUTPUT);
  pinMode(MODE_PIN, OUTPUT);

  digitalWrite(TRIGGER_PIN, HIGH);
  digitalWrite(MODE_PIN, HIGH);

  sampleSonar();

  // Salinity Setup
  salinity_sampler.sample();

  printer.printMessage("Starting main loop", 10);
  loopStartTime = millis();
  printer.lastExecutionTime = loopStartTime - LOOP_PERIOD + PRINTER_LOOP_OFFSET;
  imu.lastExecutionTime = loopStartTime - LOOP_PERIOD + IMU_LOOP_OFFSET;
  adc.lastExecutionTime = loopStartTime - LOOP_PERIOD + ADC_LOOP_OFFSET;
  ef.lastExecutionTime = loopStartTime - LOOP_PERIOD + ERROR_FLAG_LOOP_OFFSET;
  xy_state_estimator.lastExecutionTime =
      loopStartTime - LOOP_PERIOD + XY_STATE_ESTIMATOR_LOOP_OFFSET;
  surface_control.lastExecutionTime =
      loopStartTime - LOOP_PERIOD + SURFACE_CONTROL_LOOP_OFFSET;
  logger.lastExecutionTime = loopStartTime - LOOP_PERIOD + LOGGER_LOOP_OFFSET;
}

//////////////////////////////* Loop */////////////////////////

void loop() {
  currentTime = millis();

  if (currentTime - printer.lastExecutionTime > LOOP_PERIOD) {
    printer.lastExecutionTime = currentTime;
    printer.printValue(0, adc.printSample());
    printer.printValue(1, ef.printStates());
    printer.printValue(2, logger.printState());
    printer.printValue(3, gps.printState());
    printer.printValue(4, xy_state_estimator.printState());
    printer.printValue(5, surface_control.printWaypointUpdate());
    printer.printValue(6, surface_control.printString());
    printer.printValue(7, motor_driver.printState());
    printer.printValue(8, imu.printRollPitchHeading());
    printer.printValue(9, imu.printAccels());
    printer.printToSerial(); // To stop printing, just comment this line out
  }

  /// SURFACE CONTROL FINITE STATE MACHINE///
  if (currentTime - surface_control.lastExecutionTime > LOOP_PERIOD) {
    surface_control.lastExecutionTime = currentTime;
    if (surface_control.navigateState) { // NAVIGATE STATE //
      if (!surface_control.atPoint) {
        surface_control.navigate(&xy_state_estimator.state, &gps.state,
                                 currentTime);
      } else if (surface_control.complete) {
        delete[] surface_control
            .wayPoints; // destroy surface waypoint array from the Heap
      } else {
        surface_control.atPoint = false; // get ready to go to the next point
      }
      motor_driver.drive(surface_control.uL, surface_control.uR, 0);
    }
  }

  if (currentTime - adc.lastExecutionTime > LOOP_PERIOD) {
    adc.lastExecutionTime = currentTime;
    adc.updateSample();
  }

  if (currentTime - ef.lastExecutionTime > LOOP_PERIOD) {
    ef.lastExecutionTime = currentTime;
    attachInterrupt(digitalPinToInterrupt(ERROR_FLAG_A), EFA_Detected, LOW);
    attachInterrupt(digitalPinToInterrupt(ERROR_FLAG_B), EFB_Detected, LOW);
    attachInterrupt(digitalPinToInterrupt(ERROR_FLAG_C), EFC_Detected, LOW);
    delay(5);
    detachInterrupt(digitalPinToInterrupt(ERROR_FLAG_A));
    detachInterrupt(digitalPinToInterrupt(ERROR_FLAG_B));
    detachInterrupt(digitalPinToInterrupt(ERROR_FLAG_C));
    ef.updateStates(EF_States[0], EF_States[1], EF_States[2]);
    EF_States[0] = 1;
    EF_States[1] = 1;
    EF_States[2] = 1;
  }

  if (currentTime - imu.lastExecutionTime > LOOP_PERIOD) {
    imu.lastExecutionTime = currentTime;
    imu.read(); // blocking I2C calls
  }

  gps.read(
      &GPS); // blocking UART calls, need to check for UART data every cycle

  if (currentTime - lastSonarTime > 1000 * 5) {
    lastSonarTime = millis();
    sampleSonar();
  }

  if (currentTime - xy_state_estimator.lastExecutionTime > LOOP_PERIOD) {
    xy_state_estimator.lastExecutionTime = currentTime;
    xy_state_estimator.updateState(&imu.state, &gps.state);
  }

  if (currentTime - led.lastExecutionTime > LOOP_PERIOD) {
    led.lastExecutionTime = currentTime;
    led.flashLED(&gps.state);
    salinity_sampler.sample();
  }

  if (currentTime - logger.lastExecutionTime > LOOP_PERIOD &&
      logger.keepLogging) {
    logger.lastExecutionTime = currentTime;
    logger.log();
  }
}

void EFA_Detected(void) { EF_States[0] = 0; }

void EFB_Detected(void) { EF_States[1] = 0; }

void EFC_Detected(void) { EF_States[2] = 0; }

void sampleSonar(void) {
  digitalWrite(TRIGGER_PIN, LOW);
  sonar_sampler.sample();
  digitalWrite(MODE_PIN, LOW);
  sonar_sampler.sample();

  digitalWrite(TRIGGER_PIN, HIGH);
  digitalWrite(MODE_PIN, HIGH);
}