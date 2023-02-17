s.options.sampleRate = 44100;
s.options.numBuffers = 1024*4;
s.options.numRGens=64*1;
s.options.numWireBufs=64*1;
s.options.numInputBusChannels=0;
s.options.outputStreamsEnabled.postln
s.options.device_("USB Sound Device");
s.record(numChannels:6) ;
s.record(bus:2,numChannels:1))

s.options.numWireBufs = 1024*4;

s.options.numOutputBusChannels=2;
TempoClock.default.tempo_(120/29);
s.options.memSize = 8192*8;
s.waitForBoot
s.reboot;

/////buffers
~a= Buffer.read(s,path:);
~b= Buffer.read(s,path:);
~c= Buffer.read(s,path:);
~d= Buffer.read(s,path:);
~e= Buffer.read(s,path:);
~f= Buffer.read(s,path:);
~g= Buffer.read(s,path:);
~k= Buffer.read(s,path:);
~l= Buffer.read(s,path:);
~m= Buffer.read(s,path:);
///quaery
~a.play
~a.numFrames;
~a.numChannels;
~a.duration;
//numSamples
~a.numFrames * ~a.numChannels
~a.sampleRate
s.sampleRate
~a.query

///sampler
(
~o1=(
SynthDef.new(\o1, {arg note1,time1,time2,presence1, presence2;
	var osc1,osc2, env1,env2, note2, a;

	a= (~a.numFrames - note1).wrap(1,~a.numFrames); note2= (~a.numFrames/(note1+a)).wrap(1,~a.numFrames);
	env1 = EnvGen.ar(Env.perc(0.02,time1,presence1), doneAction: 0); env2 = EnvGen.ar(Env.perc(0.02,time2,presence2), doneAction: 2);
	osc1 = PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:note1); osc2 = PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:note2);
	Out.ar(0,osc1*env1); Out.ar(0,osc2*env2);
}).add;
);
~o2=(
SynthDef.new(\o1, {arg note1,time1,time2,presence1, presence2;
	var osc1,osc2, env1,env2, note2, a;

	a= (~b.numFrames - note1).wrap(1,~b.numFrames); note2= (~b.numFrames/(note1+a)).wrap(1,~b.numFrames);
	env1 = EnvGen.ar(Env.perc(0.02,time1,presence1), doneAction: 0); env2 = EnvGen.ar(Env.perc(0.02,time2,presence2), doneAction: 2);
	osc1 = PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:note1); osc2 = PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:note2);
	Out.ar(0,osc1*env1); Out.ar(0,osc2*env2);
}).add;
);
~o3=(
SynthDef.new(\o1, {arg note1,time1,time2,presence1, presence2;
	var osc1,osc2, env1,env2, note2, a;

	a= (~c.numFrames - note1).wrap(1,~c.numFrames); note2= (~c.numFrames/(note1+a)).wrap(1,~c.numFrames);
	env1 = EnvGen.ar(Env.perc(0.02,time1,presence1), doneAction: 0); env2 = EnvGen.ar(Env.perc(0.02,time2,presence2), doneAction: 2);
	osc1 = PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:note1); osc2 = PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:note2);
	Out.ar(0,osc1*env1); Out.ar(0,osc2*env2);
}).add;
);
~o4=(
SynthDef.new(\o1, {arg note1,time1,time2,presence1, presence2;
	var osc1,osc2, env1,env2, note2, a;

	a= (~d.numFrames - note1).wrap(1,~d.numFrames); note2= (~d.numFrames/(note1+a)).wrap(1,~d.numFrames);
	env1 = EnvGen.ar(Env.perc(0.02,time1,presence1), doneAction: 0); env2 = EnvGen.ar(Env.perc(0.02,time2,presence2), doneAction: 2);
	osc1 = PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:note1); osc2 = PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:note2);
	Out.ar(0,osc1*env1); Out.ar(0,osc2*env2);
}).add;
);
~o5=(
SynthDef.new(\o1, {arg note1,time1,time2,presence1, presence2;
	var osc1,osc2, env1,env2, note2, a;

	a= (~e.numFrames - note1).wrap(1,~e.numFrames); note2= (~e.numFrames/(note1+a)).wrap(1,~e.numFrames);
	env1 = EnvGen.ar(Env.perc(0.02,time1,presence1), doneAction: 0); env2 = EnvGen.ar(Env.perc(0.02,time2,presence2), doneAction: 2);
	osc1 = PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:note1); osc2 = PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:note2);
	Out.ar(0,osc1*env1); Out.ar(0,osc2*env2);
}).add;
);
~o6=(
SynthDef.new(\o1, {arg note1,time1,time2,presence1, presence2;
	var osc1,osc2, env1,env2, note2, a;

	a= (~f.numFrames - note1).wrap(1,~f.numFrames); note2= (~f.numFrames/(note1+a)).wrap(1,~f.numFrames);
	env1 = EnvGen.ar(Env.perc(0.02,time1,presence1), doneAction: 0); env2 = EnvGen.ar(Env.perc(0.02,time2,presence2), doneAction: 2);
	osc1 = PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:note1); osc2 = PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:note2);
	Out.ar(0,osc1*env1); Out.ar(0,osc2*env2);
}).add;
);
~o7=(
SynthDef.new(\o1, {arg note1,time1,time2,presence1, presence2;
	var osc1,osc2, env1,env2, note2, a;

	a= (~g.numFrames - note1).wrap(1,~g.numFrames); note2= (~g.numFrames/(note1+a)).wrap(1,~g.numFrames);
	env1 = EnvGen.ar(Env.perc(0.02,time1,presence1), doneAction: 0); env2 = EnvGen.ar(Env.perc(0.02,time2,presence2), doneAction: 2);
	osc1 = PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:note1); osc2 = PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:note2);
	Out.ar(0,osc1*env1); Out.ar(0,osc2*env2);
}).add;
);
~o8=(
SynthDef.new(\o1, {arg note1,time1,time2,presence1, presence2;
	var osc1,osc2, env1,env2, note2, a;

	a= (~k.numFrames - note1).wrap(1,~k.numFrames); note2= (~k.numFrames/(note1+a)).wrap(1,~k.numFrames);
	env1 = EnvGen.ar(Env.perc(0.02,time1,presence1), doneAction: 0); env2 = EnvGen.ar(Env.perc(0.02,time2,presence2), doneAction: 2);
	osc1 = PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:note1); osc2 = PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:note2);
	Out.ar(0,osc1*env1); Out.ar(0,osc2*env2);
}).add;
);
~o9=(
SynthDef.new(\o1, {arg note1,time1,time2,presence1, presence2;
	var osc1,osc2, env1,env2, note2, a;

	a= (~l.numFrames - note1).wrap(1,~l.numFrames); note2= (~l.numFrames/(note1+a)).wrap(1,~l.numFrames);
	env1 = EnvGen.ar(Env.perc(0.02,time1,presence1), doneAction: 0); env2 = EnvGen.ar(Env.perc(0.02,time2,presence2), doneAction: 2);
	osc1 = PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:note1); osc2 = PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:note2);
	Out.ar(0,osc1*env1); Out.ar(0,osc2*env2);
}).add;
);
~o0=(
SynthDef.new(\o1, {arg note1,time1,time2,presence1, presence2;
	var osc1,osc2, env1,env2, note2, a;

	a= (~m.numFrames - note1).wrap(1,~m.numFrames); note2= (~m.numFrames/(note1+a)).wrap(1,~m.numFrames);
	env1 = EnvGen.ar(Env.perc(0.02,time1,presence1), doneAction: 0); env2 = EnvGen.ar(Env.perc(0.02,time2,presence2), doneAction: 2);
	osc1 = PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:note1); osc2 = PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:note2);
	Out.ar(0,osc1*env1); Out.ar(0,osc2*env2);
}).add;
);
)

/*(
Pdef(\1, Pbind(\instrument, \a, \dur,Pexprand(1,4,inf),
	\time1,Prand([2,4],inf),
	\time2,Prand([4,8],inf),
	\note1,Prand(Array.series(~a.numFrames, 1, 1),inf),
	\presence1,Pexprand(0.1,1,inf),
	\presence1,Pexprand(0.1,1,inf);
)).play(quant:1););*/

(
Window.closeAll;
////////////////////////////////////////////////////////////////////////////////////////////////window
w = Window("Nest", Rect(100,10,1000,800))
.front
.alwaysOnTop_(true);

StaticText(w,Rect(20,2,200,20))
.string_("NIL");


w.view.decorator_(FlowLayout(w.bounds,20@20,20@20));

c = Array.with(

	 CompositeView(w, 950@500)
	.background_(Color.rand),
	 CompositeView(w, 950@200)
	.background_(Color.rand),
);

///////////////////////////////////////////////////////////////////////////////////////////hui
Array.with(
	///////////////////////////////////////////////////////ae
	Slider2D(c[1], Rect(10+(180*0),10,185,185))
				.background_(Color.rand)
	.x_(0)
	.y_(0)
	.action_({
		arg obj;
		var gg, cg, ff;

		cg = obj.y.linexp(0,1,20,286);
		ff = obj.x.linexp(0,1,1,5);
		gg = [cg, ff];
		gg.postln;
		if(
			n.isPlaying,
			{n.set(\phase1,cg,\decay1,ff)});
	}),
	Slider(c[1], Rect(10+(180*1),10,20,185))
				.background_(Color.rand)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linexp(0,1,20,286).postln;
		if(
		n.isPlaying,
		{n.set(\freq1, cf)}
	);
		c[0].children[34].value_(obj.value.linexp(0,1,20,286));
	}),
);
///////////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\



Array.with(

		//////////////////////////////////////////////////////////////////on/of
		Button(c[0], Rect(20,10,35,35))
		.background_(Color.rand)
	.states_([
	["OFF",Color.rand,Color.rand],
	["ON",Color.rand,Color.rand]])
.action_({
	arg obj;
	if(
		obj.value == 1,
		{
		~o1 = Synth.new(\o1,[\lpf, c[0].children[12].value.linexp(0,1,20,286),\presence, c[0].children[13].value.linexp(0,1,0.5,7),\note, c[0].children[0].value.linexp(0,1,0.1,10)]).register;
		~o2 = Synth.new(\o1,[\lpf, c[0].children[12].value.linexp(0,1,20,286),\presence, c[0].children[13].value.linexp(0,1,0.5,7),\note, c[0].children[0].value.linexp(0,1,0.1,10)]).register;
		~o3 = Synth.new(\o1,[\lpf, c[0].children[12].value.linexp(0,1,20,286),\presence, c[0].children[13].value.linexp(0,1,0.5,7),\note, c[0].children[0].value.linexp(0,1,0.1,10)]).register;
		~o4 = Synth.new(\o1,[\lpf, c[0].children[12].value.linexp(0,1,20,286),\presence, c[0].children[13].value.linexp(0,1,0.5,7),\note, c[0].children[0].value.linexp(0,1,0.1,10)]).register;
		~o5 = Synth.new(\o1,[\lpf, c[0].children[12].value.linexp(0,1,20,286),\presence, c[0].children[13].value.linexp(0,1,0.5,7),\note, c[0].children[0].value.linexp(0,1,0.1,10)]).register;
		~o6 = Synth.new(\o1,[\lpf, c[0].children[12].value.linexp(0,1,20,286),\presence, c[0].children[13].value.linexp(0,1,0.5,7),\note, c[0].children[0].value.linexp(0,1,0.1,10)]).register;
		~o7 = Synth.new(\o1,[\lpf, c[0].children[12].value.linexp(0,1,20,286),\presence, c[0].children[13].value.linexp(0,1,0.5,7),\note, c[0].children[0].value.linexp(0,1,0.1,10)]).register;
		~o8 = Synth.new(\o1,[\lpf, c[0].children[12].value.linexp(0,1,20,286),\presence, c[0].children[13].value.linexp(0,1,0.5,7),\note, c[0].children[0].value.linexp(0,1,0.1,10)]).register;
		~o9 = Synth.new(\o1,[\lpf, c[0].children[12].value.linexp(0,1,20,286),\presence, c[0].children[13].value.linexp(0,1,0.5,7),\note, c[0].children[0].value.linexp(0,1,0.1,10)]).register;
		~o0 = Synth.new(\o1,[\lpf, c[0].children[12].value.linexp(0,1,20,286),\presence, c[0].children[13].value.linexp(0,1,0.5,7),\note, c[0].children[0].value.linexp(0,1,0.1,10)]).register;

		},
		{~o1.free;~o2.free;~o3.free;~o4.free;~o5.free;~o6.free;~o7.free;~o8.free;~o9.free;~o10.free;}
	);
}),
		///////////////////////////////////////////////////////buffer gain1
	Slider(c[0], Rect(120+(180*0),40,40,80)).background_(Color.rand)
	.action_({
	arg obj;
	var qual;
	qual = obj.value.linexp(0,1,0.1,10);
	if(
		~o1.isPlaying,
		{~o1.set(\time1,qual)}
	);
		c[0].children[32].value_(obj.value.linexp(0,1,0.1,10));
}),
		///////////////////////////////////////////////////////buffer gain2
	Slider(c[0], Rect(120+(180*1),40,40,80)).background_(Color.rand)
	.action_({
	arg obj;
	var qual;
	qual = obj.value.linexp(0,1,0.1,10);
	if(
		~o2.isPlaying,
		{~o2.set(\time2,qual)}
	);
		c[0].children[36].value_(obj.value.linexp(0,1,0.1,10));
}),
		///////////////////////////////////////////////////////buffer gain3
	Slider(c[0], Rect(120+(180*2),40,40,80)).background_(Color.rand)
	.action_({
	arg obj;
	var qual;
	qual = obj.value.linexp(0,1,0.1,10);
	if(
		~o3.isPlaying,
		{~o3.set(\time3,qual)}
	);
		c[0].children[39].value_(obj.value.linexp(0,1,0.1,10));
}),
	///////////////////////////////////////////////////////buffer gain4
	Slider(c[0], Rect(120+(180*3),40,40,80)).background_(Color.rand)
	.action_({
	arg obj;
	var qual;
	qual = obj.value.linexp(0,1,0.1,10);
	if(
		~o4.isPlaying,
		{~o4.set(\time4,qual)}
	);
		c[0].children[42].value_(obj.value.linexp(0,1,0.1,10));
}),
///////////////////////////////////////////////////////buffer gain5
	Slider(c[0], Rect(120+(180*4),40,40,80)).background_(Color.rand)
	.action_({
	arg obj;
	var qual;
	qual = obj.value.linexp(0,1,0.1,10);
	if(
		~o5.isPlaying,
		{~o5.set(\time1,qual)}
	);
		c[0].children[32].value_(obj.value.linexp(0,1,0.1,10));
}),
		///////////////////////////////////////////////////////buffer gain6
	Slider(c[0], Rect(120+(180*0),210,40,80)).background_(Color.rand)
	.action_({
	arg obj;
	var qual;
	qual = obj.value.linexp(0,1,0.1,10);
	if(
		~o6.isPlaying,
		{~o6.set(\time2,qual)}
	);
		c[0].children[36].value_(obj.value.linexp(0,1,0.1,10));
}),
		///////////////////////////////////////////////////////buffer gain7
	Slider(c[0], Rect(120+(180*1),210,40,80)).background_(Color.rand)
	.action_({
	arg obj;
	var qual;
	qual = obj.value.linexp(0,1,0.1,10);
	if(
		~o7.isPlaying,
		{~o7.set(\time3,qual)}
	);
		c[0].children[39].value_(obj.value.linexp(0,1,0.1,10));
}),
	///////////////////////////////////////////////////////buffer gain8
	Slider(c[0], Rect(120+(180*2),210,40,80)).background_(Color.rand)
	.action_({
	arg obj;
	var qual;
	qual = obj.value.linexp(0,1,0.1,10);
	if(
		~o8.isPlaying,
		{~o8.set(\time4,qual)}
	);
		c[0].children[42].value_(obj.value.linexp(0,1,0.1,10));
}),
		///////////////////////////////////////////////////////buffer gain9
	Slider(c[0], Rect(120+(180*3),210,40,80)).background_(Color.rand)
	.action_({
	arg obj;
	var qual;
	qual = obj.value.linexp(0,1,0.1,10);
	if(
		~o9.isPlaying,
		{~o9.set(\time4,qual)}
	);
		c[0].children[42].value_(obj.value.linexp(0,1,0.1,10));
}),
		///////////////////////////////////////////////////////buffer gain10
	Slider(c[0], Rect(120+(180*4),215,40,80)).background_(Color.rand)
	.action_({
	arg obj;
	var qual;
	qual = obj.value.linexp(0,1,0.1,10);
	if(
		~o0.isPlaying,
		{~o0.set(\time4,qual)}
	);
		c[0].children[42].value_(obj.value.linexp(0,1,0.1,10));
}),

	///////////////////////////////////////////////////////slider1
	Slider(c[0], Rect(100+(180*0),150,120,20)).background_(Color.rand)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linexp(0,1,20,286).postln;
		if(
		~o1.isPlaying,
		{~o1.set(\freq1, cf)}
	);
		c[0].children[34].value_(obj.value.linexp(0,1,20,286));
	}),
///////////////////////////////////////////////////////slider2
	Slider(c[0], Rect(100+(180*1),150,120,20)).background_(Color.rand)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linexp(0,1,0.5,7).postln;
	if(
		~o2.isPlaying,
		{~o2.set(\out1, cf)}
	);
		c[0].children[35].value_(obj.value.linexp(0,1,0.5,7));
}),///////////////////////////////////////////////////////slider3
  Slider(c[0], Rect(100+(180*2),150,120,20)).background_(Color.rand)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linexp(0,1,20,286).postln;
	if(
		~o3.isPlaying,
		{~o3.set(\freq2, cf)}
	);
		c[0].children[37].value_(obj.value.linexp(0,1,20,286));
}),///////////////////////////////////////////////////////slider4
	Slider(c[0], Rect(100+(180*3),150,120,20)).background_(Color.rand)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linexp(0,1,0.5,7).postln;
	if(
		~o4.isPlaying,
		{~o4.set(\out2, cf)}
	);
		c[0].children[38].value_(obj.value.linexp(0,1,0.5,7));
}),
///////////////////////////////////////////////////////slider5
	Slider(c[0], Rect(100+(180*4),150,120,20)).background_(Color.rand)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linexp(0,1,20,286).postln;
	if(
		~o5.isPlaying,
		{~o5.set(\freq3, cf)}
	);
		c[0].children[40].value_(obj.value.linexp(0,1,20,286));
}),
	///////////////////////////////////////////////////////slider6
	Slider(c[0], Rect(100+(180*0),315,120,20))
				.background_(Color.rand)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linexp(0,1,0.5,7).postln;
	if(
		~o6.isPlaying,
		{~o6.set(\out3, cf)}
	);
		c[0].children[41].value_(obj.value.linexp(0,1,0.5,7));
}),

		/////////////////////////////////////////////////////////////////////slider7
	Slider(c[0], Rect(100+(180*1),315,120,20)).background_(Color.rand)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linexp(0,1,20,286).postln;
	if(
		~o7.isPlaying,
		{~o7.set(\freq4, cf)}
	);
		c[0].children[43].value_(obj.value.linexp(0,1,20,286));
}),	/////////////////////////////////////////////////////////////////////slider8
	Slider(c[0], Rect(100+(180*2),315,120,20)).background_(Color.rand)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linexp(0,1,0.5,7).postln;
	if(
		~o8.isPlaying,
		{~o8.set(\out4, cf)}
	);
		c[0].children[44].value_(obj.value.linexp(0,1,0.5,7));

}),
	/////////////////////////////////////////////////////////////////////////9
	Slider(c[0], Rect(100+(180*3),315,120,20)).background_(Color.rand)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linexp(0,1,0.5,7).postln;
	if(
		~o9.isPlaying,
		{~o9.set(\out4, cf)}
	);
		c[0].children[44].value_(obj.value.linexp(0,1,0.5,7));
}),

	////////////////////////////////////////////////////////////////10
	Slider(c[0], Rect(100+(180*4),315,120,20)).background_(Color.rand)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linexp(0,1,0.5,7).postln;
	if(
		~o0.isPlaying,
		{~o0.set(\out4, cf)}

	);
		c[0].children[44].value_(obj.value.linexp(0,1,0.5,7));
}),

StaticText(c[0],Rect(100+(180*0),130,40,20)).string_("LPF1"),
StaticText(c[0],Rect(100+(180*1),130,40,20)).string_("LPF2"),
StaticText(c[0],Rect(100+(180*2),130,40,20)).string_("LPF3"),
StaticText(c[0],Rect(100+(180*3),130,40,20)).string_("LPF4"),
StaticText(c[0],Rect(100+(180*4),130,40,20)).string_("LPF5"),
StaticText(c[0],Rect(100+(180*0),350,40,20)).string_("LPF6"),
StaticText(c[0],Rect(100+(180*1),350,40,20)).string_("LPF7"),
StaticText(c[0],Rect(100+(180*2),350,40,20)).string_("LPF8"),
StaticText(c[0],Rect(100+(180*3),350,40,20)).string_("LPF9"),
StaticText(c[0],Rect(100+(180*4),350,40,20)).string_("LPF10"),
StaticText(c[0],Rect(60+(180*0),90,40,20)).string_("gain1"),
StaticText(c[0],Rect(60+(180*1),90,40,20)).string_("gain2"),
StaticText(c[0],Rect(60+(180*2),90,40,20)).string_("gain3"),
StaticText(c[0],Rect(60+(180*3),90,40,20)).string_("gain4"),
StaticText(c[0],Rect(60+(180*4),280,40,20)).string_("gain5"),
StaticText(c[0],Rect(50+(180*0),280,40,20)).string_("gain6"),
StaticText(c[0],Rect(60+(180*1),280,40,20)).string_("gain7"),
StaticText(c[0],Rect(60+(180*2),280,40,20)).string_("gain8"),
StaticText(c[0],Rect(60+(180*3),280,40,20)).string_("gain9"),
StaticText(c[0],Rect(60+(180*4),280,40,20)).string_("gain10"),
);
)

////////////////////////////////midi

MIDIClient.init;
MIDIIn.connectAll;
MIDIClient.init;
MIDIClient.destinations
m = MIDIOut(1);
m.noteOn(1,10)

///

MIDIClient.init;
MIDIIn.connectAll;
~note=Array.newClear(128);
~bend=8192;
~data=127;
~modul=127;

/////

MIDIdef.noteOn(\synhtone,{|val,num,chan,src|[val,num,chan,src].postln;
	~note[num]=a=Synth.new(\synth,[\gate,1,\fre,num.midicps,
		\velosity,val.linlin(1,127,0.2,0.9),\bend, ~bend.linlin(0,16383,-5,6),\cutoff,~data.linlin(1,127,10,10000),\pha,~modul.linlin(1,127,0.03,3),\amp,~modul.linlin(0,127,0.03,3)]);
});

MIDIdef.noteOff(\synthone,{|val,num|~note[num].set(\gate,0);~note[num]=nil;
});
MIDIdef.bend(\synthbent,{|val,chan,src|[val,chan,src].postln;~bend=val;~note.do{|synth|synth.set(\bend,val.linlin(0,16383,-2.3,2.3))};
});


MIDIdef.cc(\dataentry,{|val,chan,src|[val,chan,src].postln;~data=val;~note.do{|synth|synth.set(\cutoff,val.linlin(1,127,10,10000))}},7);
MIDIdef.cc(\modulatio,{|val,chan,src|[val,chan,src].postln;~modul=val;~note.do{|synth|synth.set(\pha,val.linexp(1,127,0.1,10),\amp,val.linexp(1,127,0.1,10))}},1);

s.quit;