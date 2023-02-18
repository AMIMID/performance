s.options.sampleRate = 44100;
s.options.numBuffers = 1024*4;
s.options.numRGens=64*1;
s.options.numWireBufs=64*1;
s.options.numInputBusChannels=0;
s.options.outputStreamsEnabled.postln
s.options.device_("USB Sound Device");
s.record(numChannels:4) ;

({Out.ar(2,SoundIn.ar(0))}.play;
s.record(bus:2,numChannels:1))

s.options.numWireBufs = 1024*4;

s.options.numOutputBusChannels=4;
TempoClock.default.tempo_(120/60);
s.options.memSize = 8192*8;
s.waitForBoot
s.reboot;


(
SynthDef.new(\t, {

	var env,level,duration,face1,face2,face3,face4;
	var edge1a,edge1b,edge1c,edge2a,edge2b,edge2c;
	var edge3a,edge3b,edge3c,edge4a,edge4b,edge4c;

	env = EnvGen.ar(Env.sine(duration,level), doneAction: 2);

	face1 = Out.ar(4,PanAz.ar(3,InFeedback.ar(3),LFSaw.ar(),level:env,width:2));
	face2 = Out.ar(7,PanAz.ar(3,InFeedback.ar(3),LFSaw.ar(),level:env,width:2));
	face3 = Out.ar(10,PanAz.ar(3,InFeedback.ar(3),LFSaw.ar(),level:env,width:2));
	face4 = Out.ar(13,PanAz.ar(3,InFeedback.ar(3),LFSaw.ar(),level:env,width:2));

	edge1a = Out.ar(16,Pan2.ar(InFeedback.ar(4),LFSaw.ar(),level:env));
	edge1b = Out.ar(18,Pan2.ar(InFeedback.ar(5),LFSaw.ar(),level:env));
	edge1c = Out.ar(20,Pan2.ar(InFeedback.ar(6),LFSaw.ar(),level:env));
	edge2a = Out.ar(22,Pan2.ar(InFeedback.ar(7),LFSaw.ar(),level:env));
	edge2b = Out.ar(24,Pan2.ar(InFeedback.ar(8),LFSaw.ar(),level:env));
	edge2c = Out.ar(26,Pan2.ar(InFeedback.ar(9),LFSaw.ar(),level:env));
	edge3a = Out.ar(27,Pan2.ar(InFeedback.ar(10),LFSaw.ar(),level:env));
	edge3b = Out.ar(29,Pan2.ar(InFeedback.ar(11),LFSaw.ar(),level:env));
	edge3c = Out.ar(30,Pan2.ar(InFeedback.ar(12),LFSaw.ar(),level:env));
	edge4a = Out.ar(32,Pan2.ar(InFeedback.ar(13),LFSaw.ar(),level:env));
	edge4b = Out.ar(34,Pan2.ar(InFeedback.ar(14),LFSaw.ar(),level:env));
	edge4c = Out.ar(36,Pan2.ar(InFeedback.ar(15),LFSaw.ar(),level:env));


}).add;
)

Synth.new(\t);

