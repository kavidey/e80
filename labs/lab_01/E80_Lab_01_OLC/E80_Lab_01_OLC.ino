/********
Default E80 Code
Current Author:
    Wilson Ives (wives@g.hmc.edu) '20 (contributed in 2018)
Previous Contributors:
    Christopher McElroy (cmcelroy@g.hmc.edu) '19 (contributed in 2017)  
    Josephine Wong (jowong@hmc.edu) '18 (contributed in 2016)
    Apoorva Sharma (asharma@hmc.edu) '17 (contributed in 2016)                    
*/

/* Libraries */

// general
#include <Arduino.h>
#include <Wire.h>
#include <Pinouts.h>

// E80-specific
#include <SensorIMU.h>
#include <MotorDriver.h>
#include <Logger.h>
#include <Printer.h>


/* Global Variables */

// speed variables
float vertSpeed = 500; // 500 mm/s
float horizSpeed = 500; // 500 mm/s

// path variables
float ft2mm = 304.8;
float vertDist = 2.5 * ft2mm;
float horizDist = 6 * ft2mm;

// path times
float vertTime = vertDist / vertSpeed;
float horizTime = horizDist / horizTime;
float pauseTime = 4000


// period in ms of logger and printer
#define LOOP_PERIOD 100

// Motors
MotorDriver motorDriver;

// IMU
SensorIMU imu;

// Logger
Logger logger;
bool keepLogging = true;

// Printer
Printer printer;

// loop start recorder
int loopStartTime;

void setup() {
  printer.init();

  /* Initialize the Logger */
  logger.include(&imu);
  logger.include(&motorDriver);
  logger.init();

  /* Initialise the sensors */
  imu.init();

  /* Initialize motor pins */
  motorDriver.init();

  /* Keep track of time */
  printer.printMessage("Starting main loop",10);
  loopStartTime = millis();
}


void loop() {

  int currentTime = millis() - loopStartTime;
  
  ///////////  Don't change code above here! ////////////////////
  // write code here to make the robot fire its motors in the sequence specified in the lab manual 
  // the currentTime variable contains the number of ms since the robot was turned on 
  // The motorDriver.drive function takes in 3 inputs arguments motorA_power, motorB_power, motorC_power: 
  //       void motorDriver.drive(int motorA_power,int motorB_power,int motorC_power); 
  // the value of motorX_power can range from -255 to 255, and sets the PWM applied to the motor 
  // The following example will turn on motor B for four seconds between seconds 4 and 8 
  // speed ~ 0.5 m/s,v keep motor drive ~120 that should be fine
  // MAKE THIS PART AS SHORT AS POSSIBLE TIME-WISE; prefer if over wait
  if (currentTime > pauseTime && currentTime < (pauseTime + vertTime)) {
    driveUp(-0.5);
    // motorDriver.drive(0,-120,0); // move down
  } else if (currentTime < (pauseTime + vertTime + horizTime){
    driveForward(0.5);
    // motorDrive.drive(120,0,120) // move left
  } else if (currentTime < (pauseTime + 2*vertTime + horizTime)){
    driveUp(0.5);
    // motorDrive.drive(0,120,0); // move up
  } else {
    motorDriver.drive(0,0,0);
  }

  // DONT CHANGE CODE BELOW THIS LINE 
  // --------------------------------------------------------------------------

  
  if ( currentTime-printer.lastExecutionTime > LOOP_PERIOD ) {
    printer.lastExecutionTime = currentTime;
    printer.printValue(0,imu.printAccels());
    printer.printValue(1,imu.printRollPitchHeading());
    printer.printValue(2,motorDriver.printState());
    printer.printToSerial();  // To stop printing, just comment this line out
  }

  if ( currentTime-imu.lastExecutionTime > LOOP_PERIOD ) {
    imu.lastExecutionTime = currentTime;
    imu.read(); // this is a sequence of blocking I2C read calls
  }

  if ( currentTime-logger.lastExecutionTime > LOOP_PERIOD && logger.keepLogging) {
    logger.lastExecutionTime = currentTime;
    logger.log();
  }

}

void driveForward(float magnitude) {
  float drive = magnitude * 255
  motorDrive.drive(drive, 0, drive)
}

void driveUp(float magnitude){
  float drive = magnitude * 255
  motorDrive.drive(0, drive, 0)
}

