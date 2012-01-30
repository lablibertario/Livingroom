#pragma once
#import <ofxCocoaPlugins/Plugin.h>
#include "ParticleSystem.h"
#import "ofxShader.h"
#include "ofxCvMain.h"


#define NUM_PARTICLE_SYSTEMS 48
#define NUM_K_PARTICLES 5
//#define NUM_PARTICLES NUM_K_PARTICLES*1024
#define NUM_PARTICLES 1024*NUM_K_PARTICLES
#define NUMP NUM_PARTICLE_SYSTEMS*NUM_PARTICLES

#define GRID_SIZE 1024/2

@interface AshParticles : ofPlugin {
   	int kParticles;
    Particle particles[NUM_PARTICLE_SYSTEMS][NUM_PARTICLES];
    
    ofImage * ashTexture;
    
    float dead;
    float alive;
    float livingUp;
    float dying;
    
    //float grid[GRID_SIZE][GRID_SIZE];
    ofxCvGrayscaleImage grid; 
    ofxCvGrayscaleImage diff; 
    ofxCvGrayscaleImage fade; 
    ofxCvContourFinder contourFinder;
    ofxCvFloatImage distanceImage;
    
    GLuint particleVBO[3];
    ofPoint  pos[NUMP]; 
    ofVec4f color[NUMP];

}

@end
