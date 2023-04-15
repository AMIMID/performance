////////////audio and buffer settings

s.options.numOutputBusChannels=4;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(120/240)
);
s.options.memSize = 8192*16;

~e.play
~e2.numFrames;
e.numChannels;
e.duration;
numSamples = numFrames * numChannels
~e.numFrames * e.numChannels
e.sampleRate
s.sampleRate
e.query

////////////buffer from
~e = Buffer.read(s,"/Users/petrostatsiopoulos/Dokuments/PROJECT  FILES/Suco/lam/audio files/CARRIER 4 OCTAVE -2.wav")

//////////individual Synth Definitions which apply band pass filters in 30 individual tones to the noise recording from Granulator file, in stereo)
(

/////////////1st Lamdoma "octave" a=1 from y=(x+a)x where y is the interface tone (final audio)

(SynthDef.new(\1, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=4000;x=1;a=0;fund=256;pass=0.0001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);

(SynthDef.new(\2, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=4000;x=2;a=1;fund=256;pass=0.0001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\3, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=4000;x=3;a=1;fund=256;pass=0.0001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\4, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=4000;x=4;a=1;fund=256;pass=0.0001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);

(SynthDef.new(\5, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=4000;x=5;a=2;fund=256;pass=0.0001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\6, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=4000;x=5;a=2;fund=256;pass=0.0001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\7, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=4000;x=6;a=2;fund=256;pass=0.0001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\8, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=4000;x=7;a=2;fund=256;pass=0.0001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\9, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=4000;x=8;a=2;fund=256;pass=0.0001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\10, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=4000;x=9;a=2;fund=256;pass=0.0001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);

(SynthDef.new(\11, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=4000;x=10;a=3;fund=256;pass=0.0001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\12, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=4000;x=11;a=3;fund=256;pass=0.0001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);

////


(SynthDef.new(\13, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=4000;x=13;a=0;fund=256;pass=0.0001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);

(SynthDef.new(\14, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=4000;x=14;a=1;fund=256;pass=0.0001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\15, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=4000;x=15;a=1;fund=256;pass=0.0001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\16, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=4000;x=16;a=1;fund=256;pass=0.0001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);

(SynthDef.new(\17, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=4000;x=17;a=2;fund=256;pass=0.0001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\18, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=4000;x=18;a=2;fund=256;pass=0.0001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\19, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=4000;x=19;a=2;fund=256;pass=0.0001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\20, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=4000;x=20;a=2;fund=256;pass=0.0001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\21, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=4000;x=21;a=2;fund=256;pass=0.0001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\22, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=4000;x=22;a=2;fund=256;pass=0.0001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);

(SynthDef.new(\23, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=4000;x=23;a=3;fund=256;pass=0.0001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\24, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=4000;x=24;a=3;fund=256;pass=0.0001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
)


s.record(numChannels:4) ;



//////////////////////////////midi interface osc (OpenSoundControl) where keys are a matrix pad, knob/slider1 is gain, knob/slider2 and knob/slider3 are Attack/Decay envelopes for the indiviual or grouped tones. Output is in stereo i.g. synth outputs spatialized audio.
////Extra knobs/sliders can be filters like low pass or high pass. The Lamdoma can be tuned to different fundamental frequences 256-256 Hz, this could be basic knob/slider4
(
MIDIClient.init;
MIDIIn.connectAll;
~note=Array.newClear(128);
)
~bend=8192;
~data=127;
~modul=127;

/////
(

MIDIdef.noteOn(\synhtone,{|val,num,chan,src|[val,num,chan,src].postln;
	if( num==49,{(SynthDef.new(\1, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=4000;x=1;a=0;fund=256;pass=0.0001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);Synth.new(\1)});
	if( num==50,{(SynthDef.new(\2, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=4000;x=2;a=1;fund=256;pass=0.0001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);Synth.new(\2)});
	if( num==51,{(SynthDef.new(\3, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=4000;x=3;a=1;fund=256;pass=0.0001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);Synth.new(\3)});
	if( num==52,{(SynthDef.new(\4, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=4000;x=4;a=1;fund=256;pass=0.0001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);Synth.new(\4)});
	if( num==53,{(SynthDef.new(\5, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=4000;x=5;a=2;fund=256;pass=0.0001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);Synth.new(\5)});
	if( num==54,{(SynthDef.new(\6, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=4000;x=5;a=2;fund=256;pass=0.0001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);Synth.new(\6)});
	if( num==55,{(SynthDef.new(\7, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=4000;x=6;a=2;fund=256;pass=0.0001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);Synth.new(\7)});
	if( num==56,{(SynthDef.new(\8, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=4000;x=7;a=2;fund=256;pass=0.0001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);Synth.new(\8)});
	if( num==57,{(SynthDef.new(\9, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=4000;x=8;a=2;fund=256;pass=0.0001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);Synth.new(\9)});
	if( num==58,{(SynthDef.new(\11, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=4000;x=10;a=3;fund=256;pass=0.0001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);Synth.new(\10)});
	if( num==59,{(SynthDef.new(\12, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=4000;x=11;a=3;fund=256;pass=0.0001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);Synth.new(\11)});
	if( num==60,{(SynthDef.new(\12, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=4000;x=11;a=3;fund=256;pass=0.0001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);Synth.new(\12)});
	if( num==61,{(SynthDef.new(\13, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=4000;x=13;a=0;fund=256;pass=0.0001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);Synth.new(\13)});
	if( num==62,{(SynthDef.new(\14, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=4000;x=14;a=1;fund=256;pass=0.0001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);Synth.new(\14)});
	if( num==63,{(SynthDef.new(\15, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=4000;x=15;a=1;fund=256;pass=0.0001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);Synth.new(\15)});
	if( num==64,{(SynthDef.new(\16, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=4000;x=16;a=1;fund=256;pass=0.0001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);Synth.new(\16)});
	if( num==65,{(SynthDef.new(\17, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=4000;x=17;a=2;fund=256;pass=0.0001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);Synth.new(\17)});
	if( num==66,{(SynthDef.new(\18, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=4000;x=18;a=2;fund=256;pass=0.0001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);Synth.new(\18)});
	if( num==67,{(SynthDef.new(\19, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=4000;x=19;a=2;fund=256;pass=0.0001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);Synth.new(\19)});
	if( num==68,{(SynthDef.new(\20, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=4000;x=20;a=2;fund=256;pass=0.0001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);Synth.new(\20)});
	if( num==69,{(SynthDef.new(\21, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=4000;x=21;a=2;fund=256;pass=0.0001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);Synth.new(\21)});
	if( num==70,{(SynthDef.new(\22, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=4000;x=22;a=2;fund=256;pass=0.0001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);Synth.new(\22)});
	if( num==71,{(SynthDef.new(\23, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=4000;x=23;a=3;fund=256;pass=0.0001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);Synth.new(\23)});
	if( num==72,{(SynthDef.new(\24, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=4000;x=24;a=3;fund=256;pass=0.0001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);Synth.new(\24)});
})
)

