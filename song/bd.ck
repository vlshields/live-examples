// Tempo setup
0.46875::second => dur beat;
beat - (now % beat) => now;

// construct the patch
SndBuf2 buf => Gain g => dac;
// read in the file
"Bassdrum-01.wav" => buf.read;
// set the gain
.5 => g.gain;

// time loop
while( true )
{
    // set the play position to beginning
    0 => buf.pos;
    // randomize gain a bit
    Math.random2f(.8,.9) => buf.gain;

    // advance time
    1::beat => now;
}