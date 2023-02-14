s.options.sampleRate = 44100;
s.options.numBuffers = 1024*4;
s.options.numRGens=64*1;
s.options.numWireBufs=64*1;
s.options.numInputBusChannels=0;
s.options.outputStreamsEnabled.postln
s.options.device_("USB Sound Device");
s.record(numChannels:6) ;


~a= Buffer.read(s,path:"/Users/petrostatsiopoulos/Desktop/SC_230214_233839.wav");
~a.play
~a.numFrames;
~a.numChannels;
~a.duration;
numSamples = numFrames * numChannels
~a.sampleRate
s.sampleRate
~a.query
(
SynthDef.new(\o, {
	arg note;
	var osc;
	var env;

	env = EnvGen.ar(Env.perc(0.01,8,1), doneAction: 2);

	osc = Pan2.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:note,),pos:0);

	Out.ar(0,osc*env);
}).add;
)


Synth.new(\o,[\note,~a.numFrames.rand]);

///

((4*128)-1)*((4*128)/2);
////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\/////////////////\\\\\\\\\\\\\\\/////////////////
