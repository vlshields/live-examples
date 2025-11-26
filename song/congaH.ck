

// Tempo setup
0.46875::second => dur beat;
beat - (now % beat) => now;

0.25::beat => dur sixteenth;

beat * 4 => dur bar;

// Sync to beat grid
beat => dur T;
T - (now % T) => now;

// Percussion pattern
// [0, 0, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0] @=> int percPattern[];

// Percussion synthesis
SndBuf2 perc =>  JCRev j => Gain g => dac;
"./rolandtr626-perc/Conga H.wav" => perc.read;

0.06 => j.mix;
0.33 => g.gain;


// Main loop
while(true) {
    
     if( Math.randomf() > .25 )
    {
        // set play position to 'where'
        0 => perc.pos;
        // advance time
        1::beat => now;
    }
    else
    {
        0 => perc.pos;
        .5::beat => now;
        
        0 => perc.pos;
        .5::beat => now;
    }
}
