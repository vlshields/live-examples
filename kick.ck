// Forest Temple - Kick Drum Module
// Tech-house four-on-the-floor kick pattern

// Tempo setup
0.47::second => dur beat;
beat - (now % beat) => now;
// Three-layer kick drum
SinOsc body => ADSR bodyEnv => Gain bodyGain => dac;
bodyEnv.set(0::ms, 460::ms, 0.0, 190::ms);
0.9 => bodyGain.gain;

TriOsc punch => LPF punchFilter => ADSR punchEnv => Gain punchGain => dac;
punchEnv.set(0::ms, 190::ms, 0.0, 3.9::ms);
0.14 => punchGain.gain;

Noise click => HPF clickFilter => ADSR clickEnv => Gain clickGain => dac;
10000 => clickFilter.freq;
clickEnv.set(0.3::ms, 3::ms, 0.0, 0.1::ms);
0.1 => clickGain.gain;

// Main loop
while(true) {
    50 => body.freq;
        bodyEnv.keyOn();

        // Pitch sweep on body

           


        // Punch layer - starts higher
        100 => punch.freq;
        800 => punchFilter.freq;
        punchEnv.keyOn();
       


        // Click layer
        0.08 => clickGain.gain;
        clickEnv.keyOn();
        1::beat => now;
        clickEnv.keyOff();
        punchEnv.keyOff();
        bodyEnv.keyOn();
    }

