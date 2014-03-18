#include "ofMain.h"
#include "testApp.h"

int main(){
	ofSetupOpenGL(1024,768, OF_FULLSCREEN);			// <-------- setup the GL context
//2048, 1536
    //1024,768
	ofRunApp(new testApp);
}
