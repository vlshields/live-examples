0.47::second => dur beat;
beat - (now % beat) => now;

SqrOsc click => HPF clickFilter => ADSR clickEnv => Gain clickGain => dac;
7000 => clickFilter.freq;
clickEnv.set(0::ms,15::ms, 0.0, 3.1::ms);
0.05 => clickGain.gain;


while(true) {


        11000 => click.freq;
        clickEnv.keyOn();
        1::beat => now;
        clickEnv.keyOff();

    }

