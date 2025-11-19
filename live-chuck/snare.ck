
// this synchronizes to period
.462::second => dur beat;
beat - (now % beat) => now;

// one period offset
beat => now;

// construct the patch
SndBuf2 buf => Gain g => Pan2 p => dac;
// read in from file
me.dir() + "010_hcsnare1.wav" => buf.read;
// set the gain
.6 => g.gain;

// where we actually want to start (in # of sample frames)
100 => int where;

// time loop
while( true )
{
    // randomize the gain a bit
    Math.random2f(.8,.9) => buf.gain;

    // note: Math.randomf() returns value between 0 and 1
    if( Math.randomf() > .25 )
    {
        // set play position to 'where'
        where => buf.pos;
        1 => p.pan;
        // advance time
        2::beat => now;
    }
    else
    {
        -1 => p.pan;
        where => buf.pos;
        .75::beat => now;

        .8 => buf.gain;
        where => buf.pos;
        1.25::beat => now;
    }
}
