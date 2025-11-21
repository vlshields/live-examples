// Forest Temple - Maraca Shaker Module
// 16th note shaker pattern with 13 objects

// Tempo setup (matches forest_kick.ck)
.6::second => dur beat;
beat - (now % beat) => now;

0.25::beat => dur sixteenth;

beat * 4 => dur bar;

// Sync to beat grid
beat => dur T;
T - (now % T) => now;

// Maraca shaker with 13 objects
Shakers shaker => HPF hpf => Gain g => dac;
1 => shaker.which;  // 22 = Maraca
13 => shaker.objects;  // 13 objects as requested
0.4 => g.gain;
200 => hpf.freq;  // High-pass filter to remove low rumble

// Shaker pattern (16th notes with accents)
// 1 = hit, 0 = rest
// Accents on beats 1 and 3 (positions 0, 8)
[1, 0, 1, 1, 1, 0, 1, 1, 1, 0, 1, 0, 1, 0, 1, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1, 0, 1, 0, 1, 0, 1, 1] @=> int shakerPattern[];
[0.9, 0.3, 0.4, 0.3, 0.5, 0.3, 0.4, 0.3, 0.9, 0.3, 0.4, 0.3, 0.5, 0.3, 0.4, 0.3, 0.5, 0.3, 0.4, 0.3, 0.5, 0.3, 0.4, 0.3, 0.5, 0.3, 0.4, 0.3, 0.5, 0.3, 0.4, 0.3] @=> float velocities[];

// Main loop
while(true) {
    for(0 => int i; i < shakerPattern.cap(); i++) {
        if(shakerPattern[i] == 1) {
            // Add slight random variation for human feel
            velocities[i] * (1.0 + Math.random2f(-0.1, 0.1)) => float energy;
            energy => shaker.noteOn;
            sixteenth => now;
        } else {
            sixteenth => now;
        }
    }
}
