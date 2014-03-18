//#pragma once

#include "ofMain.h"
//#include "ofxiOS.h"
//#include "ofxiOSExtras.h"

class speaker{
    public:
    
    int speakerId;
    ofRectangle dimensions;
    ofColor colour;
    bool beingMoved;
    int touchId;
    ofPoint touchPositionRelativeToSpeaker;
    
    //Methods
    void createSpeaker();
    void drawSpeaker();
    void updateDimensions();
    void SetColour();
    
    void resolveTouchDown(list<speaker> speakerList, ofTouchEventArgs touch);
    void resolveTouchMoved(list<speaker> speakerList, ofTouchEventArgs touch);
    void resolveTouchUp(list<speaker> speakerList, ofTouchEventArgs touch);
    
    //Static Methods - Is this the best way?
    static void drawAllSpeakers(list<speaker> speakerList);
    static void resolveTouchDownForAllSpeakers(list<speaker> *speakerList, ofTouchEventArgs touch);
    static void resolveTouchMovedForAllSpeakers(list<speaker> *speakerList, ofTouchEventArgs touch);
    static void resolveTouchUpForAllSpeakers(list<speaker> *speakerList, ofTouchEventArgs touch);
    static void addSpeakersToList(list<speaker> *speakerList, int quantity);
    
private:
    bool willSpeakerOverlap(list<speaker> speakerList, int speakerId, ofRectangle speakerToCheck);
    ofRectangle lastPositionBeforeSpeakerOverlap(list<speaker> speakerList, int speakerId, ofRectangle speakerToCheck);
};