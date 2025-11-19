.462::second => dur beat;
beat - (now % beat) => now;

// construct the patch
SndBuf2 buf => Gain g => dac;
// read in the file
"008_hcperc2.wav" => buf.read;
// set the gain
.5 => g.gain;

100 => int where;

// time loop
while( true )
{


    // note: Math.randomf() returns value between 0 and 1
    if( Math.randomf() > .25 )
    {
        // set play position to 'where'
        where => buf.pos;
        // advance time
        1::beat => now;
    }
    else
    {

        where => buf.pos;
        .5::beat => now;

        where => buf.pos;
        .5::beat => now;
    }
}