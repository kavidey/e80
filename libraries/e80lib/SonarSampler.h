#ifndef __SONARSAMPLER_h__
#define __SONARSAMPLER_h__

#include "Pinouts.h"
#include <Arduino.h>
#include "BurstADCSampler.h"
#include <SD.h>
#include <SPI.h>
#include <stdio.h>

#define SR_NUM_BURST_PINS 2

#define SR_NUM_SAMPLES 10000

class SonarSampler {
public:
  void sample(void);
  void print(void);
  void init(void);

  int lastExecutionTime = -1;

private:
  node *headarray[SR_NUM_BURST_PINS + 1] = {NULL};

  // helper func
  void update(void);
  void timestamp(void);
  void save(void);
  void cleanup(void);
  void namefile(void);

  String basename = "sonar_0";
  String filename = "";
  const int TIME_INDEX = 0;
  const int pinMap[SR_NUM_BURST_PINS] = {17, 24};
};

#endif
