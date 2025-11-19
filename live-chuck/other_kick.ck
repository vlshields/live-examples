.462::second => dur beat;
beat - (now % beat) => now;

// construct the patch
// SndBuf2 buf => Gain g => dac;
SndBuf2 buf => Gain g => dac;
// read in the file
// "Linn Kick 1.wav" => buf.read;
"004_hckick1.wav" => buf.read;
// set the gain
.8 => g.gain;
// .75 => g2.gain;
// time loop
while( true )
{
    // set the play position to beginning
    0 => buf.pos;
    // 0 => buf2.pos;
    // randomize gain a bit
    
    // advance time
    1::beat => now;
}