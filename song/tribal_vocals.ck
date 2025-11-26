 SndBuf2 voc => GVerb gverb => Bitcrusher bc => Pan2 pan => dac;
"tribal_vocals1.wav" => voc.read;


100 => gverb.roomsize;
0.46::second => gverb.revtime;
0.6 => gverb.dry;
0.2 => gverb.early;
0.3 => gverb.tail;
15 => bc.bits;
8 => bc.downsampleFactor;



float targetPan;
float currentPan;

while (true)
{
    0 => voc.pos;

    while (voc.pos() < voc.samples())
    {
        // Occasionally pick new random pan target
        if (Math.random2(0, 10) == 0)
            Math.random2f(-0.9, 0.9) => targetPan;

        // Smooth interpolation toward target
        currentPan + (targetPan - currentPan) * 0.05 => currentPan;
        currentPan => pan.pan;

        10::ms => now;
    }
}
