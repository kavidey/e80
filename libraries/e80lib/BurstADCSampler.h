#ifndef __BURSTADCSAMPLER_h__
#define __BURSTADCSAMPLER_h__

#include "Pinouts.h"
#include <Arduino.h>
#include <SD.h>
#include <SPI.h>
#include <stdio.h>

#define NUM_BURST_PINS 2

// should be no more than 1000 samples
// which samples for around .1 seconds
#define NUM_SAMPLES 1000

struct node {
  int data;
  struct node *next;
} typedef node;

class BurstADCSampler {
public:
  void sample(void);
  void print(void);
  void init(void);

  int lastExecutionTime = -1;

private:
  node *headarray[NUM_BURST_PINS + 1] = {NULL};

  // helper func
  void update(void);
  void timestamp(void);
  void save(void);
  void cleanup(void);
  void namefile(void);

  String basename = "datalog_salinity_";
  String filename = "";
  const int TIME_INDEX = 0;
  // const int pinMap[NUM_BURST_PINS] = {14, 15}; // SONAR
  const int pinMap[NUM_BURST_PINS] = {15, 16}; // Salinity
};

#endif
