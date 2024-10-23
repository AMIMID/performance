


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
~c1 = Buffer.read(s,"/Users/petrostatsiopoulos/Dokuments/EXTERNAL/music/piece of my heart Intermission.wav");
~c2 = Buffer.read(s,"/Users/petrostatsiopoulos/Dokuments/EXTERNAL/music/piece of my heart Intermission.wav");
)

(
(
SynthDef.new(\inst4,
{
		arg band1=0,band2=0,cutt1=0,cutt2=0,gain1=1,gain2=1,mix1=1,mix2=1;
		var sig1,sig2,sig3,sig4,sig5,sig6;
		var pass1,pass2,pass3,pass4,pass5,pass6;
		var width1,width2,width3,width4,width5,width6;
		var i,j,k,q1,q2,q3,q4,v1,v2,v3,v4,xyz=[1,1,1].normalizeSum.sqrt;
		var angle_cuttfreq1, angle_bandwidth1,angle_cuttfreq2, angle_bandwidth2;
		var cuttfreq1,bandwidth1,cuttfreq2,bandwidth2;

		angle_cuttfreq1 = cutt1; angle_bandwidth1 = band1;
		angle_cuttfreq2 = cutt2; angle_bandwidth2 = band2;
		v1=Quaternion(0,1,0,0);v2=Quaternion(0,0,1,0);v3=Quaternion(0,1,0,0);v4=Quaternion(0,0,1,0);

	i=Quaternion(0, xyz.[0], 0, 0); j=Quaternion(0, 0, xyz.[1], 0); k=Quaternion(0, 0, 0, xyz.[2]);

q1=(cos(angle_cuttfreq1.degrad)+(sin(angle_cuttfreq1.degrad)*(i+j+k))); v1=q1*v1*q1.conjugate;

q2=(cos(angle_bandwidth1.degrad)+(sin(angle_bandwidth1.degrad)*(i+j+k))); v2=q2*v2*q2.conjugate;

q3=(cos(angle_cuttfreq2.degrad)+(sin(angle_cuttfreq2.degrad)*(i+j+k))); v3=q3*v3*q3.conjugate;

q4=(cos(angle_bandwidth2.degrad)+(sin(angle_bandwidth2.degrad)*(i+j+k))); v4=q4*v4*q4.conjugate;


		cuttfreq1=Cartesian(v1.b,v1.c,v1.d);
		bandwidth1=Cartesian(v2.b,v2.c,v2.d);
		cuttfreq2=Cartesian(v3.b,v3.c,v3.d);
		bandwidth2=Cartesian(v4.b,v4.c,v4.d);

		pass1=cuttfreq1.x.linlin(1.neg,1,20,20000);
		pass2=cuttfreq1.y.linlin(1.neg,1,20,20000);
		pass3=cuttfreq1.z.linlin(1.neg,1,20,20000);
		pass4=cuttfreq2.x.linlin(1.neg,1,20,20000);
		pass5=cuttfreq2.y.linlin(1.neg,1,20,20000);
		pass6=cuttfreq2.z.linlin(1.neg,1,20,20000);
		width1=bandwidth1.x.linlin(1.neg,1,0.0001,1);
		width2=bandwidth1.y.linlin(1.neg,1,0.0001,1);
		width3=bandwidth1.z.linlin(1.neg,1,0.0001,1);
		width4=bandwidth2.x.linlin(1.neg,1,0.0001,1);
		width5=bandwidth2.y.linlin(1.neg,1,0.0001,1);
		width6=bandwidth2.z.linlin(1.neg,1,0.0001,1);


sig1=FreeVerb.ar(BPF.ar
			(PlayBuf.ar(2, ~c1.bufnum, BufRateScale.kr(~c1.bufnum), loop: 1, doneAction:2),
				freq:pass1.lag(0.333),rq:width1.lag(0.333),mul:gain1.lag(0.333)),
			mix:mix1.lag(0.333),room:1,mul:1/width1.sqrt);

sig2=FreeVerb.ar(BPF.ar
			(PlayBuf.ar(2, ~c1.bufnum, BufRateScale.kr(~c1.bufnum), loop: 1, doneAction:2),
				freq:pass2.lag(0.333),rq:width2.lag(0.333),mul:gain2.lag(0.333)),
			mix:mix2.lag(0.333),room:1,mul:1/width2.sqrt);
sig3=FreeVerb.ar(BPF.ar
			(PlayBuf.ar(2, ~c1.bufnum, BufRateScale.kr(~c1.bufnum), loop: 1, doneAction:2),
				freq:pass3.lag(0.333),rq:width3.lag(0.333),mul:gain1.lag(0.333)),
			mix:mix1.lag(0.333),room:1,mul:1/width1.sqrt);

/*sig4=FreeVerb.ar(BPF.ar
			(PlayBuf.ar(2, ~c2.bufnum, BufRateScale.kr(~c2.bufnum), loop: 1, doneAction:2),
				freq:pass4.lag(0.333),rq:width4.lag(0.333),mul:gain2.lag(0.333)),
			mix:mix2.lag(0.333),room:1,mul:1/width2.sqrt);

sig5=FreeVerb.ar(BPF.ar
			(PlayBuf.ar(2, ~c2.bufnum, BufRateScale.kr(~c2.bufnum), loop: 1, doneAction:2),
				freq:pass5.lag(0.333),rq:width5.lag(0.333),mul:gain1.lag(0.333)),
			mix:mix1.lag(0.333),room:1,mul:1/width1.sqrt);

sig6=FreeVerb.ar(BPF.ar
			(PlayBuf.ar(2, ~c2.bufnum, BufRateScale.kr(~c2.bufnum), loop: 1, doneAction:2),
				freq:pass6.lag(0.333),rq:width6.lag(0.333),mul:gain2.lag(0.333)),
			mix:mix2.lag(0.333),room:1,mul:1/width2.sqrt);*/


	Out.ar(0,sig1);Out.ar(0,sig2);Out.ar(0,sig3);
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
\cutt1,~filter1.x.linlin(0,1,0,360),\band1,~filter1.y.linlin(0,1,0,360),
	\cutt2,~filter2.x.linlin(0,1,0,360),\band2,~filter2.y.linlin(0,1,0,360)]).register;},
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
	pass=obj.x.linlin(0,1,0,360);
	width=obj.y.linlin(0,1,0,360);
	["pass1","widht1"].postln;
	[pass.value,width.value].postln;
	if(~synth.isPlaying,{~synth.set(\cutt1,pass,\band1,width)});
});
);
(
~filter2.x_(0).y_(0).action_({
	arg obj;
	var pass,width;
    pass=obj.x.linlin(0,1,0,360);
	width=obj.y.linlin(0,1,0,360);
	["pass2","widht2"].postln;
	[pass.value,width.value].postln;
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

	