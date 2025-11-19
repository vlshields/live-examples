.462::second => dur beat;
beat - (now % beat) => now;

// construct the patch
SndBuf2 buf => Gain g => dac;
// read in the file
"006_hcopenhh.wav" => buf.read;
// set the gain
.4=> g.gain;


// time loop
while( true )
{
    // set the play position to beginning
    0 => buf.pos;

    // randomize gain a bit
 

    // advance time
    1::beat => now;
}