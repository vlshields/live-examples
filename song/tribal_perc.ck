// Forest Temple - Hi-Hat Module
// Closed and open hi-hat patterns with samples

// Tempo setup
0.46875::second => dur beat;
beat - (now % beat) => now;

0.25::beat => dur sixteenth;
beat * 4 => dur bar;



// Load samples
SndBuf2 hatClosed =>  Pan2 hatPan => dac;
SndBuf2 hatOpen =>  Pan2 hatPano => dac;

// Load your sample files (adjust paths as needed)
"./rolandtr626-sh/Shaker.wav" => hatClosed.read;
"/home/pots/sounds/song/rolandtr626-perc/Clave.wav" => hatOpen.read;

// Set samples to not play automatically
0 => hatClosed.pos;
0 => hatOpen.pos;


// Set gains
0.34 => hatClosed.gain;
0.41 => hatOpen.gain;

// Main loop
while(true) {
 
    // Randomize panning for each hit
    
    Math.random2f(-0.8, 0.8) => hatPano.pan;
    
    if( maybe ) {
        repeat (4) {
            0 => hatClosed.pos;  // Reset playhead to start
            Math.random2f(-0.7, 0.7) => hatPan.pan;
            .5::beat => now;
        }

    }
    else {
        0 => hatOpen.pos;    // Reset playhead to start
        .5::beat => now;
    }
    


        
    // Advance time by one sixteenth note for the pattern
    
    
}
