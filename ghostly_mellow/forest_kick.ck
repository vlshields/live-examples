// Forest Temple - Kick Drum Module
// Tech-house four-on-the-floor kick pattern

// Tempo setup
.6::second => dur beat;
beat - (now % beat) => now;
// Three-layer kick drum
SinOsc body => ADSR bodyEnv => Gain bodyGain => dac;
bodyEnv.set(20::ms, 150::ms, 0.0, 20::ms);
0.9 => bodyGain.gain;

TriOsc punch => LPF punchFilter => ADSR punchEnv => Gain punchGain => dac;
punchEnv.set(1::ms, 80::ms, 0.0, 10::ms);
0.04 => punchGain.gain;

Noise click => HPF clickFilter => ADSR clickEnv => Gain clickGain => dac;
10000 => clickFilter.freq;
clickEnv.set(0.3::ms, 3::ms, 0.0, 1::ms);
0.1 => clickGain.gain;

// Main loop
while(true) {
    45 => body.freq;
        bodyEnv.keyOn();

        // Pitch sweep on body

           


        // Punch layer - starts higher
        150 => punch.freq;
        800 => punchFilter.freq;
        punchEnv.keyOn();
       


        // Click layer
        0.08 => clickGain.gain;
        clickEnv.keyOn();
        2::beat => now;
        clickEnv.keyOff();
        punchEnv.keyOff();
        bodyEnv.keyOn();
    }

