// Forest Temple - High Melody Module
// Haunting high register melody with delay

// Tempo setup
.6::second => dur beat;
beat - (now % beat) => now;

0.25::beat => dur sixteenth;

beat * 4 => dur bar;

// Sync to beat grid
beat => dur T;
T - (now % T) => now;

// High melody pattern (haunting main theme)
[76, 80, 76, 80, 78, 76, 74, 76, 80, 78, 74, 76, 78, 80, 78, 76] @=> int melodyHigh[];

// High melody synthesis
SinOsc high1 => ADSR highEnv => Delay highDelay => NRev highRev => Pan2 highPan => dac;
TriOsc high2 => highEnv;
high2.freq(0.5);  // Octave below

0.2 => high1.gain;
0.1 => high2.gain;
highEnv.set(50::ms, 150::ms, 0.5, 300::ms);

beat * 0.75 => highDelay.delay;
0.3 => highDelay.gain;
highDelay => highRev;
0.25 => highRev.mix;
0.5 => highPan.pan;

// Function to play high melody
fun void playHighMelody(int pattern[]) {
    for(0 => int i; i < pattern.cap(); i++) {
        Std.mtof(pattern[i]) => float freq;
        freq => high1.freq;
        freq * 0.5 => high2.freq;

        highEnv.keyOn();
        beat => now;
        highEnv.keyOff();
        beat * 0.5 => now;
    }
}

// Main loop
while(true) {
    playHighMelody(melodyHigh);
}
