
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
~c1 = Buffer.read(s,"/Users/petrostatsiopoulos/Desktop/PROJECT  FILES/uni/ksyme/askhsh1/stereo 3d buf_voices_ksyme.wav");
~c2 = Buffer.read(s,"/Users/petrostatsiopoulos/Desktop/PROJECT  FILES/uni/ksyme/askhsh1/askhsh1.wav");
)

(
(
SynthDef.new(\inst4,
{
		arg band1=0,band2=0,cutt1=0,cutt2=0,gain1=1,gain2=1,mix1=1,mix2=1;
		var sig1,sig2,sig3,sig4,sig5,sig6;
		var pass1,pass2,pass3,pass4,pass5,pass6;
		var width1,width2,width3,width4,width5,width6;
		var angle_cuttfreq1=0, angle_bandwidth1=0,angle_cuttfreq2=0, angle_bandwidth2=0;
		var cuttfreq1,bandwidth1,cuttfreq2,bandwidth2;
		var az1,az2,az3,az4,el1,el2,el3,el4;

		angle_cuttfreq1 = cutt1.lag(0.333).degrad; angle_bandwidth1 = band1.lag(0.333).degrad;
		angle_cuttfreq2 = cutt2.lag(0.333).degrad; angle_bandwidth2 = band2.lag(0.333).degrad;
		az1=angle_cuttfreq1;
		az2=angle_bandwidth1;
		az3=angle_cuttfreq2;
		az4=angle_bandwidth2;
		el1=angle_cuttfreq1/2;
		el2=angle_bandwidth1/2;
		el3=angle_cuttfreq2/2;
		el4=angle_bandwidth2/2;

		cuttfreq1=Spherical(1,az1,el1);
		bandwidth1=Spherical(1,az2,el2);
		cuttfreq2=Spherical(1,az3,el3);
		bandwidth2=Spherical(1,az4,el4);

		pass1=cuttfreq1.x.round(0.00001).abs.linlin(0,1,20,20000).poll;
		pass2=cuttfreq1.y.round(0.00001).abs.linlin(0,1,20,20000);
		pass3=cuttfreq1.z.round(0.00001).abs.linlin(0,1,20,20000);
		pass4=cuttfreq2.x.round(0.00001).abs.linlin(0,1,20,20000);
		pass5=cuttfreq2.y.round(0.00001).abs.linlin(0,1,20,20000);
		pass6=cuttfreq2.z.round(0.00001).abs.linlin(0,1,20,20000);
		width1=bandwidth1.x.round(0.00001).abs.linlin(0,1,0.0001,1).poll;
		width2=bandwidth1.y.round(0.00001).abs.linlin(0,1,0.0001,1);
		width3=bandwidth1.z.round(0.00001).abs.linlin(0,1,0.0001,1);
		width4=bandwidth2.x.round(0.00001).abs.linlin(0,1,0.0001,1);
		width5=bandwidth2.y.round(0.00001).abs.linlin(0,1,0.0001,1);
		width6=bandwidth2.z.round(0.00001).abs.linlin(0,1,0.0001,1);


sig1=FreeVerb.ar(BPF.ar
			(PlayBuf.ar(2, ~c1.bufnum, BufRateScale.kr(~c1.bufnum), loop: inf, doneAction:2),
				freq:pass1,rq:width1,mul:gain1),
			mix:mix1,room:1,mul:1/width1.sqrt);

sig2=FreeVerb.ar(BPF.ar
			(PlayBuf.ar(2, ~c1.bufnum, BufRateScale.kr(~c1.bufnum), loop: inf, doneAction:2),
				freq:pass2,rq:width2,mul:gain2),
			mix:mix2,room:1,mul:1/width2.sqrt);
sig3=FreeVerb.ar(BPF.ar
			(PlayBuf.ar(2, ~c1.bufnum, BufRateScale.kr(~c1.bufnum), loop: inf, doneAction:2),
				freq:pass3,rq:width3,mul:gain1),
			mix:mix1,room:1,mul:1/width3.sqrt);

sig4=FreeVerb.ar(BPF.ar
			(PlayBuf.ar(2, ~c2.bufnum, BufRateScale.kr(~c2.bufnum), loop: inf, doneAction:2),
				freq:pass4,rq:width4,mul:gain2),
			mix:mix2,room:1,mul:1/width4.sqrt);

sig5=FreeVerb.ar(BPF.ar
			(PlayBuf.ar(2, ~c2.bufnum, BufRateScale.kr(~c2.bufnum), loop: inf, doneAction:2),
				freq:pass5,rq:width5,mul:gain1),
			mix:mix1,room:1,mul:1/width5.sqrt);

sig6=FreeVerb.ar(BPF.ar
			(PlayBuf.ar(2, ~c2.bufnum, BufRateScale.kr(~c2.bufnum), loop: inf, doneAction:2),
				freq:pass6,rq:width6,mul:gain2),
			mix:mix2,room:1,mul:1/width6.sqrt);


	Out.ar(0,sig1);
		//Out.ar(0,sig2);Out.ar(0,sig3);
//Out.ar(0,sig4);Out.ar(0,sig5);Out.ar(0,sig6);

}).add;);
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
\cutt1,~filter1.x.linlin(0,1,0,180),\band1,~filter1.y.linlin(0,1,0,180),
	\cutt2,~filter2.x.linlin(0,1,0,180),\band2,~filter2.y.linlin(0,1,0,180)]).register;},
		{~synth.free}
)});
(
a = StaticText(w, Rect(190,20,100, 20));
a.string = "gain1";
b = StaticText(w, Rect(190,60,100, 20));
b.string = "gain2";
c = StaticText(w, Rect(20,300,200, 20));
c.string = "3d bandpass s_real";
d = StaticText(w, Rect(240,300,200, 20));
d.string = "3d bandpass s_imag";
e = StaticText(w, Rect(420,20,200, 20));
e.string = "reverb1";
f = StaticText(w, Rect(420,60,200, 20));
f.string = "reverb2";
)
);

(
~gain1.value_(1).action_({
	arg obj;
	var gain;
	obj.value.postln;
	gain=obj.value;
	if(~synth.isPlaying,{~synth.set(\gain1,gain)});
});
);
(
~gain2.value_(1).action_({
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
	pass=obj.x.linlin(0,1,0,180);
	width=obj.y.linlin(0,1,0,180);
	//["pass1","widht1"].postln;
	//[pass.value,width.value].postln;
	if(~synth.isPlaying,{~synth.set(\cutt1,pass,\band1,width)});
});
);
(
~filter2.x_(0).y_(0).action_({
	arg obj;
	var pass,width;
    pass=obj.x.linlin(0,1,0,180);
	width=obj.y.linlin(0,1,0,180);
	//["pass2","widht2"].postln;
	//[pass.value,width.value].postln;
	if(~synth.isPlaying,{~synth.set(\cutt2,pass,\band2,width)});
});
)

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

	