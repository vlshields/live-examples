

// this synchronizes to period
0.46875::second => dur beat;
beat - (now % beat) => now;

0.25::beat => dur sixteenth;
beat * 4 => dur bar;

// construct the patch
SndBuf2 buf => Gain g => dac;
// read in the file
"./rolandtr626-perc/Conga L.wav" => buf.read;
// set the gain
.55 => g.gain;

// time loop
while( true )
{
    // set the play position to beginning
    0 => buf.pos;
    // randomize gain a bit
    Math.random2f(.8,.9) => buf.gain;

    // advance time
    4::beat => now;
}