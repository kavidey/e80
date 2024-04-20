#ifndef __SALINITYSAMPLER_h__
#define __SALINITYSAMPLER_h__

#include "Pinouts.h"
#include <Arduino.h>
#include "BurstADCSampler.h"
#include <SD.h>
#include <SPI.h>
#include <stdio.h>

#define SL_NUM_BURST_PINS 3

// should be no more than 1000 samples
// which samples for around .1 seconds
#define SL_NUM_SAMPLES 100

class SalinitySampler {
public:
  void sample(void);
  void print(void);
  void init(void);

  int lastExecutionTime = -1;

private:
  node *headarray[SL_NUM_BURST_PINS + 1] = {NULL};

  // helper func
  void update(void);
  void timestamp(void);
  void save(void);
  void cleanup(void);
  void namefile(void);

  String basename = "salinity_0";
  String filename = "";
  const int TIME_INDEX = 0;
  // const int pinMap[NUM_BURST_PINS] = {14, 15}; // SONAR
  const int pinMap[SL_NUM_BURST_PINS] = {15, 16, 17}; // Salinity
};

#endif
