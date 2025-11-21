// Forest Temple - Atmospheric Pad Module
// Lush pad with chord progressions

// Tempo setup
.6::second => dur beat;
beat - (now % beat) => now;

0.25::beat => dur sixteenth;

beat * 4 => dur bar;

// Sync to beat grid
beat => dur T;
T - (now % T) => now;

// Chord progressions for pad
[[64, 68, 71], [65, 69, 72], [62, 65, 69], [60, 64, 67]] @=> int chords[][];

// Pad synthesis - 3 oscillators for richness
SawOsc pad[3];
LPF padFilter => ADSR padEnv => NRev padRev => dac;

padEnv.set(500::ms, 200::ms, 0.8, 800::ms);
0.35 => padRev.mix;

600 => padFilter.freq;
1.5 => padFilter.Q;

// Connect oscillators
for(0 => int i; i < 3; i++) {
    pad[i] => padFilter;
    0.08 => pad[i].gain;
}

// Function to play a chord
fun void playPad(int chord[], int duration) {
    for(0 => int i; i < 3; i++) {
        Std.mtof(chord[i] - 12) => pad[i].freq;
    }
    padEnv.keyOn();
    duration * bar => now;
    padEnv.keyOff();
    bar => now;
}

// Main loop - cycle through chord progression
while(true) {
    // Alternate between chords with varying durations
    playPad(chords[0], 2);
    playPad(chords[2], 2);
    playPad(chords[1], 4);
    playPad(chords[3], 2);
}
