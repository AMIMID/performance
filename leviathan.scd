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
/*~b= Buffer.read(s,path:);
~c= Buffer.read(s,path:);
~d= Buffer.read(s,path:);
~e= Buffer.read(s,path:);
~f= Buffer.read(s,path:);
~g= Buffer.read(s,path:);
~k= Buffer.read(s,path:);
~l= Buffer.read(s,path:);
~m= Buffer.read(s,path:);*/
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
~o=(
SynthDef.new(\o1, {arg note1,time1,time2,presence1, presence2;
	var osc1,osc2, env1,env2, note2, a;

	a= (~a.numFrames - note1).wrap(1,~a.numFrames); note2= (~a.numFrames/(note1+a)).wrap(1,~a.numFrames);
	env1 = EnvGen.ar(Env.perc(0.02,time1,presence1), doneAction: 0); env2 = EnvGen.ar(Env.perc(0.02,time2,presence2), doneAction: 2);
	osc1 = PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:note1); osc2 = PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:note2);
	Out.ar(0,osc1*env1); Out.ar(0,osc2*env2);
}).add;
);

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
	Slider2D(c[1], Rect(10+(180*0),10,185,185)).background_(Color.rand)
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

	Slider(c[1], Rect(10+(180*1),10,20,185)).background_(Color.rand)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linexp(0,1,20,286).postln;
		if(
		~o.isPlaying,
		{n.set(\freq1, cf)}
	);
		c[0].children[34].value_(obj.value.linexp(0,1,20,286));
	}),
);
///////////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\



Array.with(

		//////////////////////////////////////////////////////////////////on/of
		Button(c[0], Rect(20,10,35,35)).background_(Color.rand).states_([
	["OFF",Color.rand,Color.rand],
	["ON",Color.rand,Color.rand]])
.action_({
	arg obj;
	if(
		obj.value == 1,
		{
		~o = Synth.new(\o1,[\lpf, c[0].children[12].value.linexp(0,1,20,286),\presence, c[0].children[13].value.linexp(0,1,0.5,7),\note, c[0].children[0].value.linexp(0,1,0.1,10)]).register;

		},
		{~o.free;}
	);
}),
		///////////////////////////////////////////////////////buffer gain1
	Slider(c[0], Rect(120+(180*0),40,40,80)).background_(Color.rand)
	.action_({
	arg obj;
	var qual;
	qual = obj.value.linexp(0,1,0.1,10);
	if(
		~o.isPlaying,
		{~o.set(\time1,qual)}
	);
		c[0].children[32].value_(obj.value.linexp(0,1,0.1,10));
}),

	///////////////////////////////////////////////////////slider1
	Slider(c[0], Rect(100+(180*0),150,120,20)).background_(Color.rand)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linexp(0,1,20,286).postln;
		if(
		~o.isPlaying,
		{~o.set(\freq1, cf)}
	);
		c[0].children[34].value_(obj.value.linexp(0,1,20,286));
	}),


StaticText(c[0],Rect(100+(180*0),130,40,20)).string_("LPF1"),
StaticText(c[0],Rect(60+(180*0),90,40,20)).string_("gain1"),
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

~o=(
SynthDef.new(\o1, {arg note1,time1=4,time2=8,presence1, presence2;
	var osc1,osc2, env1,env2, note2, a;

	a= (~a.numFrames - note1).wrap(1,~a.numFrames); note2= (~a.numFrames/(note1+a)).wrap(1,~a.numFrames);
	env1 = EnvGen.ar(Env.perc(0.02,time1,presence1), doneAction: 0); env2 = EnvGen.ar(Env.perc(0.02,time2,presence2), doneAction: 2);
	osc1 = PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:note1); osc2 = PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:note2);
	Out.ar(0,osc1*env1); Out.ar(0,osc2*env2);
}).add;
);
/////

MIDIdef.noteOn(\synhtone,{|val,num,chan,src|[val,num,chan,src].postln;
	~note[num]=a=Synth.new(\o1,[\note1,num.midicps, ,\velosity,val.linlin(1,127,0.2,0.9),\bend,
		~bend.linlin(0,16383,-5,6,cutoff,
		~data.linlin(1,127,10,10000),\pha,
		~modul.linlin(1,127,0.03,3),\amp,~modul.linlin(0,127,0.03,3)]);
});

MIDIdef.noteOff(\synthone,{|val,num|~note[num].set(\gate,0);~note[num]=nil;
});
MIDIdef.bend(\synthbent,{|val,chan,src|[val,chan,src].postln;~bend=val;~note.do{|synth|synth.set(\bend,val.linlin(0,16383,-2.3,2.3))};
});


MIDIdef.cc(\dataentry,{|val,chan,src|[val,chan,src].postln;~data=val;~note.do{|synth|synth.set(\cutoff,val.linlin(1,127,10,10000))}},7);
MIDIdef.cc(\modulatio,{|val,chan,src|[val,chan,src].postln;~modul=val;~note.do{|synth|synth.set(\pha,val.linexp(1,127,0.1,10),\amp,val.linexp(1,127,0.1,10))}},1);

s.quit;