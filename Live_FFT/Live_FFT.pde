/**
 * This sketch demonstrates how to use an FFT to analyze
 * the audio being generated by an AudioInput.
 * <p>
 * FFT stands for Fast Fourier Transform, which is a 
 * method of analyzing audio that allows you to visualize 
 * the frequency content of a signal. You've seen 
 * visualizations like this before in music players 
 * and car stereos.
 * <p>
 * For more information about Minim and additional features, 
 * visit http://code.compartmental.net/minim/
 * http://code.compartmental.net/minim/javadoc/
 */

import ddf.minim.analysis.*;
import ddf.minim.*;

Minim       minim;
//AudioPlayer jingle;
FFT         fft;
AudioInput in;

void setup()
{
  size(512, 200, P3D);

  minim = new Minim(this);

  // specify that we want the audio buffers of the AudioPlayer
  // to be 1024 samples long because our FFT needs to have 
  // a power-of-two buffer size and this is a good size.

  in = minim.getLineIn();
  // create an FFT object that has a time-domain buffer 
  // the same size as the input's sample buffer
  // note that this needs to be a power of two 
  // and that it means the size of the spectrum will be half as large.
  fft = new FFT( in.bufferSize(), in.sampleRate() );
}

void draw()
{
  background(0);
  stroke(255);

  // perform a forward FFT on the samples in input's mix buffer,
  // which contains the mix of both the left and right channels of the file
  fft.forward( in.mix );
  
  float biggest = 0;
  float freq = 0;

  for (int i = 0; i < fft.specSize(); i++)
  {
    // draw the line for frequency band i, scaling it up a bit so we can see it
    line( i, height, i, height - fft.getBand(i)*8 );
    if(fft.getBand(i) > biggest)
    {
      biggest = fft.getBand(i);
      freq = fft.indexToFreq(i);
    }
    
  }
  text((int)freq, 10, 10);
}

