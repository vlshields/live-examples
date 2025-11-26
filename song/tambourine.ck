// Tempo setup
0.46875::second => dur beat;
beat - (now % beat) => now;

0.25::beat => dur sixteenth;
beat * 4 => dur bar;

beat * 4 => dur bar;

// Bell synthesis
SndBuf2 bell1 =>  JCRev bellRev => Pan2 bellPan => dac;

"./rolandtr626-tb/Tambourine.wav" => bell1.read;
0.85 => bell1.gain;
0.15 => bellRev.mix;



// Main loop - very sparse, appears every few bars
while(true) {
    0 => bell1.pos;
    // Wait a random amount of time (8-16 bars)
    Math.random2(8, 16) => int waitBars;
    

    // Play a bell cluster
    

    // Random panning
    Math.random2f(-0.5, 0.5) => bellPan.pan;

   waitBars::beat => now;
}
