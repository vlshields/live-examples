// Forest Temple - Percussion Module
// Rim/clap-like percussive element

// Tempo setup
.6::second => dur beat;
beat - (now % beat) => now;

0.25::beat => dur sixteenth;

beat * 4 => dur bar;

// Sync to beat grid
beat => dur T;
T - (now % T) => now;

// Percussion pattern
// [0, 0, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0] @=> int percPattern[];

// Percussion synthesis
Noise perc => BPF percFilter => ADSR percEnv => JCRev j => Gain g => dac;
2000 => percFilter.freq;
5.0 => percFilter.Q;
0.06 => j.mix;
percEnv.set(0.5::ms, 30::ms, 0.0, 1::ms);


// Main loop
while(true) {
     if( Math.randomf() > .25 )
    {
        // set play position to 'where'
        percEnv.keyOn();
        // advance time
        1::beat => now;
        percEnv.keyOff();
    }
    else
    {

        percEnv.keyOn();
        .5::beat => now;
        percEnv.keyOff();

        percEnv.keyOn();
        .5::beat => now;
        percEnv.keyOff();
    }
}
