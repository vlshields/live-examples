// Forest Temple - Layered Kick Drum
// Sub + Punch + Click

// Tempo setup
0.47::second => dur beat;
beat - (now % beat) => now;

// Master output
Gain master => dac;
0.8 => master.gain;

// === SUB LAYER ===
SinOsc sub => LPF subFilter => ADSR subEnv => Gain subGain => master;
subEnv.set(4::ms, 460::ms, 0.0, 50::ms);
80 => subFilter.freq;
0.8=> subGain.gain;

// === PUNCH LAYER ===
TriOsc punch => LPF punchFilter => ADSR punchEnv => Gain punchGain => master;
punchEnv.set(3::ms, 200::ms, 0.0, 39::ms);
0.24 => punchGain.gain;
900 => punchFilter.freq;

// === CLICK LAYER ===
SqrOsc click => HPF clickFilter => ADSR clickEnv => Gain clickGain => master;
7000 => clickFilter.freq;
clickEnv.set(0::ms, 15::ms, 0.0, 3.1::ms);
0.014 => clickGain.gain;

// Pitch drop function for sub
fun void pitchDrop() {
    120 => float startFreq;
    45 => float endFreq;
    15::ms => dur dropTime;
    
    now => time start;
    while(now < start + dropTime) {
        startFreq - ((startFreq - endFreq) * ((now - start) / dropTime)) => sub.freq;
        1::samp => now;
    }
    endFreq => sub.freq;
}

// Main loop
while(true) {
    // Sub
    120 => sub.freq;
    subEnv.keyOn();
    spork ~ pitchDrop();
    
    // Punch
    90 => punch.freq;
    punchEnv.keyOn();
    
    // Click
    11000 => click.freq;
    clickEnv.keyOn();
    
    1::beat => now;
}
