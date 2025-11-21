// Forest Temple - Hi-Hat Module
// Closed and open hi-hat patterns

// Tempo setup
.6::second => dur beat;
beat - (now % beat) => now;

0.25::beat => dur sixteenth;

beat * 4 => dur bar;

// Sync to beat grid
beat => dur T;
T - (now % T) => now;

// Hi-hat patterns
[1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0] @=> int hihatClosed[];
[0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0] @=> int hihatOpen[];

// Hi-hat synthesis
Noise hat => BPF hatFilter => ADSR hatClosedEnv => Pan2 hatPan => dac;
Noise hatO => HPF hatOpenFilter => ADSR hatOpenEnv => hatPan;

8000 => hatFilter.freq;
3.0 => hatFilter.Q;
10000 => hatOpenFilter.freq;

hatClosedEnv.set(1::ms, 20::ms, 0.0, 10::ms);
hatOpenEnv.set(1::ms, 50::ms, 0.1, 100::ms);
-0.7 => hatPan.pan;

// Main loop
while(true) {
    for(0 => int i; i < hihatClosed.cap(); i++) {
        if(hihatClosed[i] == 1) {
            0.15 => hat.gain;
            hatClosedEnv.keyOn();
            10::ms => now;
            hatClosedEnv.keyOff();
        }
        if(hihatOpen[i] == 1) {
            0.1 => hatO.gain;
            hatOpenEnv.keyOn();
            50::ms => now;
            hatOpenEnv.keyOff();
        }
        sixteenth - 10::ms => now;
    }
}
