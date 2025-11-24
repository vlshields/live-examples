SinOsc sub => LPF subFilter => ADSR subEnv => Gain subGain => dac;
subEnv.set(4::ms, 460::ms, 0.0, 50::ms);
80 => subFilter.freq;
0.4 => subGain.gain;

0.47::second => dur beat;
beat - (now % beat) => now;

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

while(true) {
    120 => sub.freq;
    subEnv.keyOn();
    spork ~ pitchDrop();
    1::beat => now;
}