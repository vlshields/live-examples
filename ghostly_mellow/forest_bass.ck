// Forest Temple - Bass Module
// Deep bass synth with two alternating patterns

// Tempo setup
.6::second => dur beat;
beat - (now % beat) => now;

0.25::beat => dur sixteenth;

beat * 4 => dur bar;

// Sync to beat grid
beat => dur T;
T - (now % T) => now;

// Bass patterns
[59, 59, 59, 59, 52, 52, 52, 52, 57, 57, 57, 57, 56, 56, 56, 56] @=> int bassPattern1[];
[40, 40, 52, 52, 45, 45, 57, 57, 47, 47, 59, 59, 48, 48, 52, 52] @=> int bassPattern2[];

// Bass synthesis - dual oscillator for thickness
SqrOsc bass1 => LPF bassFilter => ADSR bassEnv => Pan2 bassPan => dac;
SinOsc bass2 => bassFilter;
bass2.freq(0.99);  // Slight detune for thickness

0.4 => bass1.gain;
0.2 => bass2.gain;

2.0 => bassFilter.Q;
bassEnv.set(20::ms, 200::ms, 0.4, 60::ms);


// Function to play a bass pattern
fun void playBass(int pattern[]) {
    for(0 => int i; i < pattern.cap(); i++) {
        Math.random2f(-1,1) => bassPan.pan;
        Std.mtof(pattern[i] - 12) => float freq;
        freq => bass1.freq;
        freq * 0.8 => bass2.freq;

        // Filter modulation for movement
        200 + (Math.sin(now/(beat)) + 1) / 2 * 600 => bassFilter.freq;

        bassEnv.keyOn();
        0.8::beat => now;
        bassEnv.keyOff();
        0.2::beat => now;
    }
}

// Main loop - alternate between patterns
while(true) {
    // Play pattern 1 four times
    for(0 => int i; i < 4; i++) {
        playBass(bassPattern1);
    }

    // Play pattern 2 twice
    for(0 => int i; i < 2; i++) {
        playBass(bassPattern2);
    }
}
