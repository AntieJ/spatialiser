#include "speaker.h"

void speaker::drawSpeaker()
{
    ofSetColor(this->colour);
    ofRectRounded(this->dimensions, 10);
}

void speaker::resolveTouchDown(list<speaker> speakerList, ofTouchEventArgs touch)
{
    if (touch.x>this->dimensions.x && touch.x < (this->dimensions.x+this->dimensions.width) &&
        touch.y>this->dimensions.y && touch.y  < (this->dimensions.y + this->dimensions.height) &&
        this -> beingMoved == false)
    {
        this -> beingMoved = true;
        this -> colour.set(255,0,255);
        this -> touchId = touch.id;
        this -> touchPositionRelativeToSpeaker.set((touch.x - this->dimensions.x), (touch.y - this->dimensions.y));
    }
}

void speaker::resolveTouchMoved(list<speaker> speakerList, ofTouchEventArgs touch)
{
    if (this -> beingMoved == true && this -> touchId == touch.id)
    {
        ofRectangle futureSpeakerRectangle;
        futureSpeakerRectangle.set(touch.x - this->touchPositionRelativeToSpeaker.x, touch.y - this->touchPositionRelativeToSpeaker.y, this -> dimensions.height, this -> dimensions.width);
        
        if(!willSpeakerOverlap(speakerList, this -> speakerId, futureSpeakerRectangle))
        {
            this -> dimensions.set(futureSpeakerRectangle);
        }
        else
        {
            //set speaker to closest position to other speaker
            this -> dimensions.set(lastPositionBeforeSpeakerOverlap(speakerList, this -> speakerId, futureSpeakerRectangle));
        }
    }
}

void speaker::resolveTouchUp(list<speaker> speakerList, ofTouchEventArgs touch)
{
    if (this -> beingMoved == true &&
        this -> touchId==touch.id)
    {
        this -> beingMoved=false;
        this -> colour.set(0,0,255);
    }
}
////////////////////////////////////////////////////////
//Static Methods
void speaker::drawAllSpeakers(list<speaker> speakerList)
{
    for (auto speak = speakerList.begin(); speak != speakerList.end() ; speak++)
    {
        speak->drawSpeaker();
    }
}

void speaker::resolveTouchDownForAllSpeakers(list<speaker> *speakerList, ofTouchEventArgs touch)
{
    for (auto speak = speakerList->begin(); speak != speakerList->end() ; speak++)
    {
        speak->resolveTouchDown(*speakerList, touch);
    }
}

void speaker::resolveTouchMovedForAllSpeakers(list<speaker> *speakerList, ofTouchEventArgs touch)
{
    for (auto speak = speakerList->begin(); speak != speakerList->end() ; speak++)
    {
        speak->resolveTouchMoved(*speakerList, touch);
    }
}

void speaker::resolveTouchUpForAllSpeakers(list<speaker> *speakerList, ofTouchEventArgs touch)
{
    for (auto speak = speakerList->begin(); speak != speakerList->end() ; speak++)
    {
        speak->resolveTouchUp(*speakerList, touch);
    }
}

void speaker::addSpeakersToList(list<speaker> *speakerList, int quantity)
{
    for(int i=0; i<quantity; i++)
    {
        speaker speakerForList;
        ofPoint initalPosition;
        initalPosition.set(i*201,201);
        
        speakerForList.speakerId = i;
        speakerForList.dimensions.set(initalPosition, 100, 100);
        speakerForList.colour.set(0,0,255);
        speakerForList.beingMoved = false;
        speakerList->push_back(speakerForList);
    }
}
////////////////////////////////////////////////////////
//Private Methods

bool speaker::willSpeakerOverlap(list<speaker> speakerList, int speakerId, ofRectangle speakerToCheck)
{
    //THIS NEEDS WORK - or how it is used
    
    for (auto speak = speakerList.begin(); speak != speakerList.end() ; speak++)
    {
        if(speak -> speakerId != speakerId &&
           !(((speakerToCheck.x > speak -> dimensions.x + speak -> dimensions.width &&
           speakerToCheck.x + speakerToCheck.width > speak -> dimensions.x + speak -> dimensions.width)
           ||
           (speakerToCheck.x + speakerToCheck.width < speak -> dimensions.x &&
           speakerToCheck.x < speak -> dimensions.x))
           ||
           ((speakerToCheck.y > speak -> dimensions.y + speak -> dimensions.height &&
            speakerToCheck.y + speakerToCheck.height > speak -> dimensions.y + speak -> dimensions.height)
           ||
           (speakerToCheck.y + speakerToCheck.height < speak -> dimensions.y &&
            speakerToCheck.y < speak -> dimensions.y))))
        {
            return true;
            //return id of speaker that is in collision
            //use it to work out required position            
        }        
    }
    return false;
}

ofRectangle speaker::lastPositionBeforeSpeakerOverlap(list<speaker> speakerList, int speakerId, ofRectangle speakerToCheck)
{
    ofRectangle returnRectangle;
    returnRectangle.set(speakerToCheck);
    
    for (auto speak = speakerList.begin(); speak != speakerList.end() ; speak++)
    {
        if(speak -> speakerId != speakerId)
        {
            if(!(speakerToCheck.x > speak -> dimensions.x + speak -> dimensions.width &&
                 speakerToCheck.x + speakerToCheck.width > speak -> dimensions.x + speak -> dimensions.width))
            {
                returnRectangle.set(speak -> dimensions.x + speak -> dimensions.width, speakerToCheck.y, speakerToCheck.width, speakerToCheck.height);
            }
            else if(!(speakerToCheck.x + speakerToCheck.width < speak -> dimensions.x &&
                 speakerToCheck.x < speak -> dimensions.x))
            {
                returnRectangle.set(speak -> dimensions.x, speakerToCheck.y, speakerToCheck.width, speakerToCheck.height);
            }
            
            if(!(speakerToCheck.y > speak -> dimensions.y + speak -> dimensions.height &&
                 speakerToCheck.y + speakerToCheck.height > speak -> dimensions.y + speak -> dimensions.height))
            {
                returnRectangle.set(speakerToCheck.x, speak -> dimensions.y + speak -> dimensions.height, speakerToCheck.width, speakerToCheck.height);
            }
            else if(!(speakerToCheck.y + speakerToCheck.height < speak -> dimensions.y &&
                 speakerToCheck.y < speak -> dimensions.y))
            {
                returnRectangle.set(speakerToCheck.x, speak -> dimensions.y, speakerToCheck.width, speakerToCheck.height);
            }
        }
    }
    return returnRectangle;
}