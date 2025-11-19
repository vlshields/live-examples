.462::second => dur beat;
beat - (now % beat) => now;

// construct the patch
SndBuf2 buf => Gain g => Pan2 p => dac;
// read in the file
"009_hcride.wav" => buf.read;
// set the gain
.5 => g.gain;

// time loop
while( true )
{
    // set the play position to beginning
    0 => buf.pos;
    Math.random2f(-1,1) => p.pan;
    // randomize gain a bit
 

    // advance time
    1.5::beat => now;
}