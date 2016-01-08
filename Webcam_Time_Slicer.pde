import processing.video.*;
import fullscreen.*;

FullScreen fs; 
VideoBuffer vb; //video buffer class
Capture cam;

int w = 640;
int h = 377;
int offset = 99;

void setup() 
{
frameRate(24);
size(800, 600, P3D);
fs = new FullScreen(this);

// enter fullscreen mode
//fs.enter();
background(0);
vb = new VideoBuffer(100, 40, h);
cam = new Capture(this, w, h);
}

void captureEvent(Capture cam) 
{
cam.read();
cam.updatePixels();
PImage blog = cam.get(310, 0, 40, h);
vb.addFrame( blog );

offset++;
if(offset >= 100)
offset = 0;
}

void draw() 
{

int xPos = 0;
for(int i = 0; i < 20; i++)
{
image( vb.getFrame( 100 - (i * 5) + offset), i*40, 110);
}

}

class VideoBuffer 
{
PImage[] buffer;

int inputFrame = 0;

int frameWidth = 0;
int frameHeight = 0;

/*
parameters:

frames - the number of frames in the buffer (fps * duration)
width - the width of the video
height - the height of the video
*/

VideoBuffer( int frames, int width, int height ) 
{
buffer = new PImage[frames];
for(int i = 0; i < frames; i++) 
{
buffer[i] = new PImage(width, height);
}

inputFrame = 0;

frameWidth = width;
frameHeight = height;
}

// return the current "playback" frame.
PImage getFrame( int frame ) 
{
int f = frame;

while(f >= buffer.length)
{
f -= buffer.length;
}

return buffer[f];
}

// Add a new frame to the buffer.
void addFrame( PImage frame ) 
{
// copy the new frame into the buffer.
arraycopy(frame.pixels, 0, buffer[inputFrame].pixels, 0, frameWidth * frameHeight);

// advance the input and output indexes
inputFrame++;

// wrap the values..
if(inputFrame >= buffer.length) 
{
inputFrame = 0;
}
}
}
