// Forest Temple - Kick Drum Module
// Tech-house four-on-the-floor kick pattern

// Tempo setup
0.47::second => dur beat;
beat - (now % beat) => now;

TriOsc punch => LPF punchFilter => ADSR punchEnv => Gain punchGain => dac;
punchEnv.set(3::ms, 200::ms, 0.0, 39::ms);
0.24 => punchGain.gain;


    
// Main loop
while(true) {
    

        // Pitch sweep on body

           


        // Punch layer - starts higher
        90 => punch.freq;
        900 => punchFilter.freq;
        punchEnv.keyOn();
       
        1::beat => now;
    
        
    }

