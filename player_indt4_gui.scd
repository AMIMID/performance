
////server setup
(
s.options.numWireBufs = 1024*4;
s.options.numOutputBusChannels=4;
s.options.numInputBusChannels=0;
s.options.memSize = 8192*8;
//s.options.blockSize = 64/4;
s.options.maxNodes = 1024 * 4;
s.waitForBoot
)

/////wavetables
Buffer.freeAll

(
~c1 = Buffer.read(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/inst-4/piknotites6/SC_241022_083125.wav");
~c2 = Buffer.read(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/inst-4/piknotites6/SC_241022_083125.wav");
)

(
SynthDef.new(\inst4,
{
		arg lowpass1=440,highpass1=440,pass1=440,pass2=440,gain1=1,gain2=1,mix1=1,mix2=1,width1=1,width2=1;
		var sig1,sig2;

sig1=FreeVerb.ar(BPF.ar
			(PlayBuf.ar(4, ~c1.bufnum, BufRateScale.kr(~c1.bufnum), loop: 0, doneAction:0),
				freq:pass1.lag(0.333),rq:width1.lag(0.333),mul:gain1.lag(0.333)),
			mix:mix1.lag(0.333),room:1,mul:1/width1.sqrt);

sig2=FreeVerb.ar(BPF.ar
			(PlayBuf.ar(4, ~c2.bufnum, BufRateScale.kr(~c2.bufnum), loop: 0, doneAction:0),
				freq:pass2.lag(0.333),rq:width2.lag(0.333),mul:gain2.lag(0.333)),
			mix:mix2.lag(0.333),room:1,mul:1/width2.sqrt);

	Out.ar(0,sig1);Out.ar(0,sig2);

}).add;
(
Window.closeAll;
w=Window.new("gui",Rect.new(750,100,500,420)).front.alwaysOnTop_(true);

~gain1 = Slider.new(w.view,Rect.new(20,20,160,30));

~gain2 = Slider.new(w.view,Rect.new(20,60,160,30));

~filter1 = Slider2D.new(w.view,Rect.new(20,100,200,200));

~filter2 = Slider2D.new(w.view,Rect.new(240,100,200,200));

~reverb1 = Slider.new(w.view,Rect.new(250,20,160,30));

~reverb2 = Slider.new(w.view,Rect.new(250,60,160,30));

~on = Button(w,Rect(80,350,40,40)).states_([
	["off",Color.black],Color.gray,["on",Color.white,Color.gray]]).action_({
	arg obj;
	if(
		obj.value==1,{~synth=Synth.new(\inst4,[
\gain1,~gain1.value,\gain2,~gain2.value,\mix1,~reverb1.value,\mix2,~reverb2.value,
\pass1,~filter1.y.linexp(0,1,20,20000),\width1,~filter1.x.linexp(0,1,0.0001,1),
	\pass2,~filter2.y.linexp(0,1,20,20000),\width2,~filter2.x.linexp(0,1,0.0001,1)]).register;},
		{~synth.free}
)});
(
a = StaticText(w, Rect(190,20,100, 20));
a.string = "gain1";
b = StaticText(w, Rect(190,60,100, 20));
b.string = "gain2";
c = StaticText(w, Rect(20,300,200, 20));
c.string = "lowpass1 X highpass1";
d = StaticText(w, Rect(240,300,200, 20));
d.string = "lowpass2 X highpass2";
e = StaticText(w, Rect(420,20,200, 20));
e.string = "reverb1";
f = StaticText(w, Rect(420,60,200, 20));
f.string = "reverb2";
)
);

(
~gain1.action_({
	arg obj;
	var gain;
	obj.value.postln;
	gain=obj.value;
	if(~synth.isPlaying,{~synth.set(\gain1,gain)});
});
);
(
~gain2.action_({
	arg obj;
	var gain;
	obj.value.postln;
	gain=obj.value;
	if(~synth.isPlaying,{~synth.set(\gain2,gain)});
});
);
(
~reverb1.action_({
	arg obj;
	var mix;
	obj.value.postln;
	mix=obj.value;
	if(~synth.isPlaying,{~synth.set(\mix1,mix)});
});
);
(
~reverb2.action_({
	arg obj;
	var mix;
	obj.value.postln;
	mix=obj.value;
	if(~synth.isPlaying,{~synth.set(\mix2,mix)});
});
);
(
~filter1.x_(0).y_(0).action_({
	arg obj;
	var pass,width;
	pass=obj.y.linexp(0,1,20,20000);
	width=obj.x.linexp(0,1,0.0001,1);
	["pass2","widht2"].postln;
	[pass.value,width.value].postln;
	if(~synth.isPlaying,{~synth.set(\pass1,pass,\width1,width)});
});
);
(
~filter2.x_(0).y_(0).action_({
	arg obj;
	var pass,width;
	pass=obj.y.linexp(0,1,20,20000);
	width=obj.x.linexp(0,1,0.0001,1);
	["pass2","widht2"].postln;
	[pass.value,width.value].postln;
	if(~synth.isPlaying,{~synth.set(\pass2,pass,\width2,width)});
});
);

)
s.record(numChannels:4)

/////use joysticks for slider 2d and slider pots or normal pots for gain and reverb, a tact switch can be the on/off button
(
MIDIClient.init;
MIDIIn.connectAll;

MIDIdef.cc(\midi,{ |val, num, chan, src|
	[val, num, chan, src].postln;

});
)
	