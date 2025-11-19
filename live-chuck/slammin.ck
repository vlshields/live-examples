// Use SndBuf / SndBuf2 (stereo) for playing wav files

SndBuf2 buf => Gain g => dac;
buf.read("./atmospheric-abduction.wav"); // Read in our wav file
0.15 => g.gain;
1 => buf.loop; // Set our track to loop

<<< "Looping this slammin beat for 1 week" >>>;
1::week => now;