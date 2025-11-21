// Forest Temple - Lead Melody Module
// Main melodic voice with dual oscillators

// Tempo setup
125 => float BPM;
60.0/(BPM * 4) => float beatSec;
beatSec::second => dur sixteenth;
sixteenth * 4 => dur beat;
beat * 4 => dur bar;

// Sync to beat grid
beat => dur T;
T - (now % T) => now;

// Melody patterns
[64, 68, 64, 68, 71, 64, 65, 69, 64, 68, 64, 68, 71, 64, 65, 69] @=> int melodyPattern1[];
[64, 65, 69, 74, 69, 65, 64, 65, 64, 60, 64, 68, 71, 68, 64, 60] @=> int melodyPattern2[];

// Lead synthesis - dual oscillator
SawOsc lead1 => HPF leadHP => LPF leadFilter => ADSR leadEnv => NRev leadRev => Pan2 leadPan => dac;
TriOsc lead2 => leadHP;
lead2.freq(1.01);  // Slight detune

0.3 => lead1.gain;
0.2 => lead2.gain;
200 => leadHP.freq;
2000 => leadFilter.freq;
2.0 => leadFilter.Q;
leadEnv.set(10::ms, 100::ms, 0.6, 200::ms);
0.15 => leadRev.mix;
0.3 => leadPan.pan;

// Function to play melody pattern
fun void playMelody(int pattern[], int transpose) {
    for(0 => int i; i < pattern.cap(); i++) {
        Std.mtof(pattern[i] + transpose) => float freq;
        freq => lead1.freq;
        freq * 1.01 => lead2.freq;

        // Filter sweep for expression
        2000 + Math.sin(now/second * 3.0) * 500 => leadFilter.freq;

        leadEnv.keyOn();

        // Note length variation
        if(i % 4 == 3) {
            beat * 1.5 => now;
        } else {
            beat * 0.75 => now;
        }

        leadEnv.keyOff();
        beat * 0.25 => now;
    }
}

// Main loop - alternate between patterns
while(true) {
    // Play pattern 1 twice (normal)
    for(0 => int i; i < 2; i++) {
        playMelody(melodyPattern1, 0);
    }

    // Play pattern 2 twice (normal)
    for(0 => int i; i < 2; i++) {
        playMelody(melodyPattern2, 0);
    }

    // Play pattern 1 twice (octave up for variation)
    for(0 => int i; i < 2; i++) {
        playMelody(melodyPattern1, 12);
    }
}
