s.options.sampleRate = 44100;
s.options.numBuffers = 1024*4;
s.options.numRGens=64*1;
s.options.numWireBufs=64*1;
s.options.numInputBusChannels=0;
s.options.outputStreamsEnabled.postln
s.options.device_("USB Sound Device");
s.record(numChannels:6) ;
s.record(bus:2,numChannels:1))

s.options.numWireBufs = 1024*32;

s.options.numOutputBusChannels=2;
TempoClock.default.tempo_(120/60);
s.options.memSize = 8192*16;
s.waitForBoot
s.reboot;


~a= Buffer.read(s,path:"/Users/petrostatsiopoulos/Desktop/SC_230222_020917.wav");
~a.play
~a.numFrames;
~a.numChannels;
~a.duration;
numSamples = numFrames * numChannels
~a.numFrames * ~a.numChannels
~a.sampleRate
s.sampleRate
~a.query


(
SynthDef.new(\a, {
	arg note1,time1,time2,presence1=2, presence2=2;
	var osc1,osc2;
	var env1,env2;
	var note2;
	var a;

	a= (~a.numFrames - note1).wrap(1,~a.numFrames+1);
	note2= (~a.numFrames)/(note1+a).wrap(1,~a.numFrames);

	env1 = EnvGen.ar(Env.perc(0.02,time1,presence1), doneAction: 0);
	env2 = EnvGen.ar(Env.perc(0.02,time2,presence2), doneAction: 2);

	osc1 = LeakDC.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:note1));

	osc2 = LeakDC.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:note2));

	Out.ar(0,osc1*env1);
	Out.ar(0,osc2*env2);
}).add;
)

(
Pdef(\3, Pbind(\instrument, \a, \dur,8,
	\time1,Pexprand(2,4,inf),
	\time2,Pexprand(4,8,inf),
	\note1,Prand(Array.series(~a.numFrames, 1, 1),inf),
	//\presence1,Pexprand(0.1,1,inf),
	//\presence1,Pexprand(0.1,1,inf);
)).play(quant:1););
///
Array.series(~a.numFrames, 1, 496)
(
Pdef(\3, Pbind(\instrument, \a, \dur,Pexprand(1/8,1/4,inf),
	\time1,Prand([2,4],inf),
	\time2,Prand([4,8],inf),
	\note1,Prand(Array.fill(~a.numFrames, { arg i; i * 10 }),inf),
	//\presence1,Pexprand(0.1,1,inf),
	//\presence1,Pexprand(0.1,1,inf);
)).play(quant:1););
///
Array.fib(~a.numFrames,~a.numFrames/2,1)
((4*128)-1)*((4*128)/2);


(~a.numFrames - 670796679679).abs.wrap(1,~a.numFrames);
////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\/////////////////\\\\\\\\\\\\\\\/////////////////
