SndBuf2 buf => Gain g => dac;
buf.read("nature-birds-singing-217212.wav");

0 => buf.pos;
// Read in our wav file
1.3 =>  g.gain;

buf.length() => now; 
