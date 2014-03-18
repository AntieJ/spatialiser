#include "testApp.h"
#include "speaker.h"

list<speaker> speakerList;

//--------------------------------------------------------------
void testApp::setup()
{
    speaker::addSpeakersToList(&speakerList, 4);
}

//--------------------------------------------------------------
void testApp::update(){}

//--------------------------------------------------------------
void testApp::draw()
{
    speaker::drawAllSpeakers(speakerList);
}

//--------------------------------------------------------------
void testApp::exit(){}

//--------------------------------------------------------------
void testApp::touchDown(ofTouchEventArgs & touch)
{
    speaker::resolveTouchDownForAllSpeakers(&speakerList, touch);
}

//--------------------------------------------------------------
void testApp::touchMoved(ofTouchEventArgs & touch)
{
    speaker::resolveTouchMovedForAllSpeakers(&speakerList, touch);
}

//--------------------------------------------------------------
void testApp::touchUp(ofTouchEventArgs & touch)
{
    speaker::resolveTouchUpForAllSpeakers(&speakerList, touch);
}

//--------------------------------------------------------------
void testApp::touchDoubleTap(ofTouchEventArgs & touch){}

//--------------------------------------------------------------
void testApp::touchCancelled(ofTouchEventArgs & touch){}

//--------------------------------------------------------------
void testApp::lostFocus(){}

//--------------------------------------------------------------
void testApp::gotFocus(){}

//--------------------------------------------------------------
void testApp::gotMemoryWarning(){}

//--------------------------------------------------------------
void testApp::deviceOrientationChanged(int newOrientation){}

