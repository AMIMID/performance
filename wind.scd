s.options.sampleRate = 44gain;
s.options.numBuffers = 1024*8;
s.options.numRGens=64*1;
s.options.numWireBufs=64*1;
s.options.numInputBusChannels=0;
s.options.outputStreamsEnabled.postln
s.options.device_("USB Sound Device");
s.record(numChannels:4) ;

({Out.ar(2,SoundIn.ar(0))}.play;
s.record(bus:2,numChannels:1))

s.options.numWireBufs = 1024*16;

s.options.numOutputBusChannels=2;
TempoClock.default.tempo_(120/30);
s.options.memSize = 8192*16;

~e.play
~e.numFrames;
e.numChannels;
e.duration;
numSamples = numFrames * numChannels
~e.numFrames * e.numChannels
e.sampleRate
s.sampleRate
e.query

~e = Buffer.read(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/k/seqwind gran.wav")
);

(
(SynthDef.new(\wind0, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=1;a=1;fund=220;pass=0.001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.01,4,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\wind1, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=2;a=1;fund=220;pass=0.001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.01,4,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\wind2, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=3;a=1;fund=220;pass=0.001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.01,4,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);

(SynthDef.new(\wind3, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=1;a=2;fund=220;pass=0.001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.01,4,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\wind4, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=2;a=2;fund=220;pass=0.001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.01,4,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\wind5, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=3;a=2;fund=220;pass=0.001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.01,4,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\wind6, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=4;a=2;fund=220;pass=0.001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.01,4,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\wind7, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=5;a=2;fund=220;pass=0.001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.01,4,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\wind8, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=6;a=2;fund=220;pass=0.001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.01,4,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);

(SynthDef.new(\wind9, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=1;a=3;fund=220;pass=0.001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.01,4,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\wind10, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=2;a=3;fund=220;pass=0.001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.01,4,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\wind11, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=3;a=3;fund=220;pass=0.001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.01,4,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\wind12, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=4;a=3;fund=220;pass=0.001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.01,4,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\wind13, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=5;a=3;fund=220;pass=0.001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.01,4,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\wind14, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=6;a=3;fund=220;pass=0.001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.01,4,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\wind15, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=7;a=3;fund=220;pass=0.001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.01,4,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\wind16, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=8;a=3;fund=220;pass=0.001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.01,4,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\wind17, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=9;a=3;fund=220;pass=0.001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.01,4,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
)

(
Tdef.new(\h,{loop({
Synth.new(\wind0);3.999999.rand.wait;
Synth.new(\wind1);3.999999.rand.wait;
Synth.new(\wind2);3.999999.rand.wait;
Synth.new(\wind3);3.999999.rand.wait;
//Synth.new(\wind4);3.999999.rand.wait;
Synth.new(\wind5);3.999999.rand.wait;
//Synth.new(\wind6);3.999999.rand.wait;
Synth.new(\wind7);3.999999.rand.wait;
//Synth.new(\wind8);3.999999.rand.wait;
Synth.new(\wind9);3.999999.rand.wait;
Synth.new(\wind10);3.999999.rand.wait;
Synth.new(\wind11);3.999999.rand.wait;
//Synth.new(\wind12);3.999999.rand.wait;
Synth.new(\wind13);3.999999.rand.wait;
Synth.new(\wind14);3.999999.rand.wait;
//Synth.new(\wind15);3.999999.rand.wait;
Synth.new(\wind16);3.999999.rand.wait;
Synth.new(\wind17);3.999999.rand.wait;
}
)})
)

Tdef(\h).stop;
Tdef(\h).play;
Tdef(\h).clear;

Tdef(\x, { loop { 0.0125.wait; "aazz".scramble.postln } });

Synth.new(\wind0);
Synth.new(\wind1);
Synth.new(\wind2);
Synth.new(\wind3);
//Synth.new(\wind4);
Synth.new(\wind5);
//Synth.new(\wind6);
Synth.new(\wind7);
//Synth.new(\wind8);
Synth.new(\wind9);
Synth.new(\wind10);
Synth.new(\wind11);
//Synth.new(\wind12);
Synth.new(\wind13);
Synth.new(\wind14);
//Synth.new(\wind15);
Synth.new(\wind16);
Synth.new(\wind17);


MIDIClient.init;
MIDIIn.connectAll;
~note=Array.newClear(128);
~bend=8192;
~data=127;
~modul=127;

/////
(
MIDIdef.noteOn(\synhtone,{|val,num,chan,src|[val,num,chan,src].postln;
	if( num==48,{Synth.new(\wind0)});
	if( num==49,{Synth.new(\wind1)});
	if( num==50,{Synth.new(\wind2)});
	if( num==51,{Synth.new(\wind3)});
	if( num==52,{Synth.new(\wind5)});
	if( num==53,{Synth.new(\wind7)});
	if( num==54,{Synth.new(\wind9)});
	if( num==55,{Synth.new(\wind10)});
	if( num==56,{Synth.new(\wind11)});
	if( num==57,{Synth.new(\wind13)});
	if( num==58,{Synth.new(\wind14)});
	if( num==59,{Synth.new(\wind16)});
	if( num==60,{Synth.new(\wind17)});
})
)