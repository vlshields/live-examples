// Simple Techno Melody in ChucK

// Tempo setup
.462::second => dur beat;
beat - (now % beat) => now;

// Setup audio chain for bass
SawOsc bass => LPF filter => ADSR env => ABSaturator dist => Gain g =>  dac;


// Configure filter
200 => filter.freq;
8 => filter.Q;
0 => global float f;

11 => dist.drive;

// Configure envelope
env.set(2::ms, 150::ms, 0.0, 20::ms); 
[36, 38, 39, 41, 43, 45, 46, 48] @=> int notes[];  // C, Eb, F, Gb, G, Bb

// Rhythm pattern: 1 = play note, 0 = rest/silence
[1, 1, 0, 1, 0, 1, 1, 0] @=> int pattern[];

while(true) {
    f => g.gain;
    for(0 => int j; j < pattern.cap(); j++) {
        // Modulate filter cutoff for that acid sound
        200 + (Math.sin(now/(beat)) + 1) / 2 * 600 => filter.freq;

        // Only play note if pattern says so
        if(pattern[j] == 1) {
            // Pick a random note each iteration
            Math.random2(0, notes.cap() - 1) => int i;
            Std.mtof(notes[i]) => bass.freq;

            // Trigger note
            env.keyOn();
            .25::beat => now;
            env.keyOff();
        }
        else {
            // Rest - just advance time
            .25::beat => now;
        }
    }
}
