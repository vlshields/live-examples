

// Tempo setup
0.46875::second => dur beat;
beat - (now % beat) => now;
// Three-layer kick drum
SinOsc body => ADSR bodyEnv => Gain bodyGain => dac;
bodyEnv.set(3::ms, 460::ms, 0.0, 19::ms);
0.9 => bodyGain.gain;

TriOsc punch => LPF punchFilter => ADSR punchEnv => Gain punchGain => dac;
punchEnv.set(2::ms, 190::ms, 0.0, 3.9::ms);
0.14 => punchGain.gain;

Noise click => HPF clickFilter => ADSR clickEnv => Gain clickGain => dac;
9000 => clickFilter.freq;
clickEnv.set(0.3::ms, 3::ms, 0.0, 0.1::ms);
0.05 => clickGain.gain;

// Record 8 beats
while (true) {
    50 => body.freq;
    bodyEnv.keyOn();
    
    100 => punch.freq;
    800 => punchFilter.freq;
    punchEnv.keyOn();
    
    clickEnv.keyOn();
    
    1::beat => now;
    
    clickEnv.keyOff();
    punchEnv.keyOff();
    bodyEnv.keyOff();
}

