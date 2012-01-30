#pragma once
#import <ofxCocoaPlugins/Plugin.h>
#import "ofxCvMain.h"

@interface Tracker : ofPlugin {
    ofVec2f controlMouse;
}

-(int) numberTrackers;
-(ofVec2f) trackerCentroid:(int)n;
-(vector<ofVec2f>) trackerCentroidVector;

-(vector<ofVec2f>) trackerBlob:(int)n;
-(vector< vector<ofVec2f> >) trackerBlobVector;

-(ofxCvGrayscaleImage) trackerImageWithResolution:(int)res;

@end
