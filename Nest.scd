s.scope
(
Window.closeAll;
////////////////////////////////////////////////////////////////////////////////////////////////window
w = Window("Nest", Rect(100,10,960,680))
.front
.alwaysOnTop_(true);

StaticText(w,Rect(20,2,200,20))
.string_("PinkNoise filter");

StaticText(w,Rect(220,2,200,20))
.string_("LFNoiseBlip detune");

StaticText(w,Rect(490,2,200,20))
.string_("LFNoiseBlip detune pan");

StaticText(w,Rect(20,222,200,20))
.string_("bubbles tzitzikas");

StaticText(w,Rect(240,222,200,20))
.string_("Blip");

StaticText(w,Rect(390,222,200,20))
.string_("BoomBap");

TextView(w,Rect(750,20,200,600))
.string_("Personality	C+	264
Circulation,Sex	C#	586
Adrenals	B	492
Kidney	E	330
Liver	Ab	198
Bladder	F#	352
Small Intestine	C#	281.6
Lungs	A	220
Colon	F#	176
Gall Bladder	E	330
Pancreas	C#	117.3
Stomach	A	110
Spleen	B	492

C3	130.81
 C#3/Db3 	138.59
D3	146.83
 D#3/Eb3 	155.56
E3	164.81
F3	174.61
 F#3/Gb3 	185.00
G3	196.00
 G#3/Ab3 	207.65
A3	220.00
 A#3/Bb3 	233.08
B3	246.94
C4	261.63
 C#4/Db4 	277.18
D4	293.66
 D#4/Eb4 	311.13
E4	329.63
F4	349.23
 F#4/Gb4 	369.99
G4	392.00
 G#4/Ab4 	415.30
A4	440.00
 A#4/Bb4 	466.16
B4	493.88
C5	523.25
 C#5/Db5 	554.37
D5	587.33
 D#5/Eb5 	622.25
E5	659.25
F5	698.46
 F#5/Gb5 	739.99
G5	783.99
 G#5/Ab5 	830.61
A5	880.00
 A#5/Bb5 	932.33
B5	987.77
C6	1046.50
 C#6/Db6 	1108.73	");

w.view.decorator_(FlowLayout(w.bounds,20@20,20@20));

c = Array.with(

	 CompositeView(w, 165@200)
	.background_(Color.rand),

	 CompositeView(w, 260@200)
	.background_(Color.rand),

	 CompositeView(w, 250@200)
	.background_(Color.rand),

	 CompositeView(w, 200@320)
	.background_(Color.rand),

	 CompositeView(w, 100@320)
	.background_(Color.rand),

	 CompositeView(w, 375@400)
	.background_(Color.rand),
);
/////////////////////////////////////////////////////////////////////////////////////////////////////array0
Array.with(
//////////////////////////////////////////knob0
Knob(c[0], Rect(100,110,40,40))
.action_({
	arg obj;
	var qual;
	qual = obj.value.linexp(0,1,1,100).reciprocal;
	if(
		v.isPlaying,
		{v.set(\rq,qual)}
	);
}),
 ///////////////////////////////////////////////slider1
	Slider(c[0], Rect(20,30,50,140))
.background_(Color.rand)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linexp(0,1,100,4000).postln;
	if(
		v.isPlaying,
		{v.set(\freq, cf)}
	);
	c[0].children[5].value_(obj.value.linexp(0,1,100,4000))
}),
	//////////////////////////////////////////////////////////button2
Button(c[0], Rect(110,20,40,40))
.background_(Color.rand)
	.states_([
	["OFF",Color.rand,Color.rand],
	["ON",Color.rand,Color.rand]])
.action_({
	arg obj;
	if(
		obj.value == 1,
		{
			v = Synth.new(
				\audio,
				[
						\gatef,1,
					\freq, c[0].children[1].value.linexp(0,1,100,4000),
					\rq, c[0].children[0].value.linexp(0,1,1,100).reciprocal
				]
			).register
		},
		{v.set(\gatef,0)}
	)
}),
////////////////////////////////////////////text3
StaticText(c[0],Rect(30,170,50,20))
.string_("freq"),
///////////////////////////////////////////text4
StaticText(c[0],Rect(130,140,50,20))
.string_("rq"),
///////////////////////////////////////////////numberbox5
 NumberBox(c[0], Rect(20,10,40,20))
.value_(100)
.clipLo_(100)
.clipHi_(4000)
.decimals_(2)
.action_({
	arg obj;
	c[0].children[1].valueAction_(obj.value.explin(100,4000,0,1))
})
);

//////////////////////////////////////////////////////////////////////////////////////////////////array1
Array.with(
//////////////////////////////////////////////////////////////////////////////knob0
Knob(c[1], Rect(140,90,40,40))
	.action_({
	arg obj;
	var qual;
	qual = obj.value.linexp(0,1,0.1,8);
	if(
		y.isPlaying,
		{y.set(\detune,qual)}
	);
}),
	/////////////////////////////////////////////////////////////////////////knob1
Knob(c[1], Rect(190,140,40,40))
	.action_({
	arg obj;
	var quala;
	quala = obj.value.linexp(0,1,1,6);
	if(
		y.isPlaying,
		{y.set(\amp,quala)}
	);
}),
////////////////////////////////////////////////////////////////////////////slider2
	Slider(c[1], Rect(20,30,40,140))
.background_(Color.rand)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linexp(0,1,40,1000).postln;
	if(
		y.isPlaying,
		{y.set(\frequ, cf)}
	);

	c[1].children[9].value_(obj.value.linexp(0,1,40,1000));
}),
	///////////////////////////////////////////////////////////////////////////slider3
Slider(c[1], Rect(70,30,40,140))
.background_(Color.rand)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linexp(0,1,1,100).postln;
	if(
		y.isPlaying,
		{y.set(\nharm, cf)}
	);

	c[1].children[10].value_(obj.value.linexp(0,1,1,100));
})
	,
///////////////////////////////////////////////////////////////////////////////////button4
 Button(c[1],Rect(180,20,45,45))
.background_(Color.rand)
	.states_([
	["OFF",Color.rand,Color.rand],
	["ON",Color.rand,Color.rand]])
.action_({
	arg obj;
	if(
		obj.value == 1,
		{
			y = Synth.new(
				\tone1,
				[
					\gate,1,
					\frequ, c[1].children[2].value.linexp(0,1,40,1000),
					\detune, c[1].children[0].value.linexp(0,1,0.1,8),
					\nharm, c[1].children[3].value.linexp(0,1,1,100),
					\amp, c[1].children[1].value.linexp(0,1,1,6)

				]
			).register;
		},
		{y.set(\gate,0)}
	);
}),
///////////////////////////////////////////text5
StaticText(c[1],Rect(30,170,50,20))
.string_("freq"),
/////////////////////////////////////////////////////text6
StaticText(c[1],Rect(80,170,50,20))
.string_("nharm"),
///////////////////////////////////////////////////text7
StaticText(c[1],Rect(185,100,70,20))
.string_("detune"),
////////////////////////////////////////////////////text8
StaticText(c[1],Rect(165,150,20,20))
.string_("amp"),
///////////////////////////////////////////////////numberbox9
NumberBox(c[1],  Rect(20,10,40,20))
.value_(40)
.clipLo_(40)
.clipHi_(1000)
.decimals_(2)
.action_({
	arg obj;
	c[1].children[2].valueAction_(obj.value.explin(40,1000,0,1))
}),
////////////////////////////////////////////numberbox10
NumberBox(c[1], Rect(70,10,40,20))
.value_(1)
.clipLo_(1)
.clipHi_(100)
.decimals_(2)
.action_({
	arg obj;
	c[1].children[3].valueAction_(obj.value.explin(1,100,0,1))
})
);

///////////////////////////////////////////////////////////////////////////////////////////////array2
Array.with(
	/////////////////////////////////////////////////////////////////knob0
	Knob(c[2], Rect(140,90,40,40))
	.action_({
	arg obj;
	var qual;
	qual = obj.value.linexp(0,1,0.1,4);
	if(
		p.isPlaying,
		{p.set(\detune1,qual)}
	);
}),
	/////////////////////////////////////////////////////////////////knob1
Knob(c[2], Rect(170,140,40,40))
	.action_({
	arg obj;
	var quala;
	quala = obj.value.linexp(0,1,1,6);
	if(
		p.isPlaying,
		{p.set(\amp1,quala)}
	);
}),
	//////////////////////////////////////////////////////////////////slider2
	Slider(c[2], Rect(20,30,40,140))
.background_(Color.rand)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linexp(0,1,40,1000).postln;
	if(
		p.isPlaying,
		{p.set(\frequ1, cf)}
	);

	c[2].children[11].value_(obj.value.linexp(0,1,40,1000));
}),
	///////////////////////////////////////////////////////////////////slider3
Slider(c[2], Rect(65,30,40,140))
.background_(Color.rand)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linexp(0,1,1,100).postln;
	if(
		p.isPlaying,
		{p.set(\nharm1, cf)}
	);

	c[2].children[12].value_(obj.value.linexp(0,1,1,100));
}),
	/////////////////////////////////////////////////////////////////slider4
	Slider(c[2], Rect(115,30,50,30))
.background_(Color.rand)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linexp(0,1,-1,1).postln;
	if(
		p.isPlaying,
		{p.set(\pan, cf)}
	);

}),
	/////////////////////////////////////////////////////////////////button5
	 Button(c[2],Rect(180,20,40,40))
.background_(Color.rand)
	.states_([
	["OFF",Color.rand,Color.rand],
	["ON",Color.rand,Color.rand]])
.action_({
	arg obj;
	if(
		obj.value == 1,
		{
			p = Synth.new(
				\tone2,
				[
					\gate1,1,
					\frequ1, c[1].children[2].value.linexp(0,1,40,1000),
					\detune1, c[1].children[0].value.linexp(0,1,0.1,8),
					\nharm1, c[1].children[3].value.linexp(0,1,1,100),
					\amp1, c[1].children[1].value.linexp(0,1,1,6),
						\pan, c[2].children[4].value.linexp(0,1,-1,1)
				]
			).register;
		},
		{p.set(\gate1,0)}
	);
}),
////////////////////////////////////////////////////text6
StaticText(c[2],Rect(30,170,50,20))
.string_("freq"),
/////////////////////////////////////////////text7
StaticText(c[2],Rect(70,170,50,20))
.string_("nharm"),
/////////////////////////////////////////////////////text8
StaticText(c[2],Rect(120,60,40,20))
.string_("pan"),
////////////////////////////////////////////////////////text9
StaticText(c[2],Rect(185,100,50,20))
.string_("detune"),
///////////////////////////////////////////////////////////text10
StaticText(c[2],Rect(145,150,20,20))
.string_("amp"),
//////////////////////////////////////////////////numberbox11
NumberBox(c[2], Rect(15,10,45,20))
.value_(40)
.clipLo_(40)
.clipHi_(1000)
.decimals_(2)
.action_({
	arg obj;
	c[2].children[2].valueAction_(obj.value.explin(40,1000,0,1))
}),
/////////////////////////////////////////////////numberbox12
NumberBox(c[2], Rect(65,10,40,20))
.value_(1)
.clipLo_(1)
.clipHi_(100)
.decimals_(2)
.action_({
	arg obj;
	c[2].children[3].valueAction_(obj.value.explin(1,100,0,1))
})
);
////////////////////////////////////////////////////////////////////////////////////////array3
Array.with(
	//////////////////////////////////////////////////button0
	Button(c[3], Rect(150,10,35,35))
		.background_(Color.rand)
	.states_([
	["OFF",Color.rand,Color.rand],
	["ON",Color.rand,Color.rand]])
.action_({
	arg obj;
	if(
		obj.value == 1,
		{
			b = Synth.new(
				\bubbles,
				[
					\gateb,1,
						\lfoDepth, c[3].children[2].y.linexp(0,1,200,8000),
						\lfoRate, c[3].children[2].x.linexp(0,1,4,60),
				]
			).register;
		},
		{b.set(\gateb,0)}
	);
}),
	////////////////////////////////////////////////button1
		Button(c[3], Rect(150,70,35,35))
		.background_(Color.rand)
	.states_([
	["OFF",Color.rand,Color.rand],
	["ON",Color.rand,Color.rand]])
.action_({
	arg obj;
	if(
		obj.value == 1,
		{
			z = Synth.new(
				\tzitzi,
				[

					\freqz, c[3].children[3].value.linexp(0,1,0.1,2),
						\ampz, c[3].children[4].value.linexp(0,1,0.2,20),
				]
			).register;
		},
		{z.free}
	);
}),
	////////////////////////////////////////////////slider2d2
			Slider2D(c[3], Rect(5,5,100,200))
	.x_(0)
	.y_(0)
	.action_({
		arg obj;
		var gg, cg, ff;

		cg = obj.y.linexp(0,1,200,8000);
		ff = obj.x.linexp(0,1,4,60);
		gg = [cg, ff];
		gg.postln;
		if(
			b.isPlaying,
			{b.set(\lfoDepth,cg,\lfoRate,ff)}
		);
		c[3].children[10].value_(obj.y.linexp(0,1,200,8000));
		c[3].children[11].value_(obj.x.linexp(0,1,4,60));
	}),
	///////////////////////////////////////////////////////slider3
				Slider(c[3], Rect(140,155,40,135))
				.background_(Color.rand)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linexp(0,1,0.1,20).postln;
	if(
		z.isPlaying,
		{z.set(\freqz, cf)}
	);
		c[3].children[12].value_(obj.value.linexp(0,1,0.1,20));
}),
	///////////////////////////////////////////////////////knob4
				Knob(c[3], Rect(50,250,40,40))
	.action_({
	arg obj;
	var qual;
	qual = obj.value.linexp(0,1,0.2,2);
	if(
		z.isPlaying,
		{z.set(\ampz,qual)}
	);
}),
////////////////////////////////////////////////text5
	StaticText(c[3],Rect(5,205,50,20))
.string_("b@"),
/////////////////////////////////////////text6
StaticText(c[3],Rect(155,100,50,20))
.string_("tzitzi"),
////////////////////////////////////////text7
StaticText(c[3],Rect(150,40,50,20))
.string_("bubbles"),
//////////////////////////////////////text8
StaticText(c[3],Rect(145,290,50,20))
.string_("tz freq"),
////////////////////////////////////////text9
StaticText(c[3],Rect(50,290,50,20))
.string_("tz amp"),
///////////////////////////////////////////////////////numberbox10
NumberBox(c[3], Rect(25,205,40,20))
.value_(200)
.clipLo_(200)
.clipHi_(8000)
.decimals_(2)
	.action_({
	arg obj;
	c[3].children[2].valueAction_(obj.value.explin(200,8000,0,1));
}),
/////////////////////////////////////////////////////numberbox11
NumberBox(c[3], Rect(65,205,40,20))
.value_(4)
.clipLo_(4)
.clipHi_(60)
.decimals_(2)
	.action_({
	arg obj;
	c[3].children[2].valueAction_(obj.value.explin(4,60,0,1));
}),
/////////////////////////////////////////////////////numberbox12
NumberBox(c[3], Rect(140,135,40,20))
.value_(0.1)
.clipLo_(0.2)
.clipHi_(20)
.decimals_(2)
	.action_({
	arg obj;
	c[3].children[3].valueAction_(obj.value.explin(0.1,2,0,1))
	})
);

///////////////////////////////////////////////////////////////////////////////////////////array4
Array.with(








);

///////////////////////////////////////////////////////////////////////////////////////////array5
Array.with(
		///////////////////////////////////////////////////////knob0
				Knob(c[5], Rect(140,55,30,30))
	.action_({
	arg obj;
	var qual;
	qual = obj.value.linexp(0,1,0.1,10);
	if(
		n.isPlaying,
		{n.set(\time1,qual)}
	);
		c[5].children[32].value_(obj.value.linexp(0,1,0.1,10));
}),
		///////////////////////////////////////////////////////knob1
				Knob(c[5], Rect(325,55,30,30))
	.action_({
	arg obj;
	var qual;
	qual = obj.value.linexp(0,1,0.1,10);
	if(
		m.isPlaying,
		{m.set(\time2,qual)}
	);
		c[5].children[36].value_(obj.value.linexp(0,1,0.1,10));
}),
		///////////////////////////////////////////////////////knob2
				Knob(c[5], Rect(140,250,30,30))
	.action_({
	arg obj;
	var qual;
	qual = obj.value.linexp(0,1,0.1,10);
	if(
		q.isPlaying,
		{q.set(\time3,qual)}
	);
		c[5].children[39].value_(obj.value.linexp(0,1,0.1,10));
}),
	///////////////////////////////////////////////////////knob3
				Knob(c[5], Rect(325,250,30,30))
	.action_({
	arg obj;
	var qual;
	qual = obj.value.linexp(0,1,0.1,10);
	if(
		w.isPlaying,
		{w.set(\time4,qual)}
	);
		c[5].children[42].value_(obj.value.linexp(0,1,0.1,10));
}),
	///////////////////////////////////////////////////////slider4
				Slider2D(c[5], Rect(10,10,100,185))
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
			{n.set(\phase1,cg,\decay1,ff)}
		);

	}),
	///////////////////////////////////////////////////////slider5
				Slider2D(c[5], Rect(190,10,100,185))
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
			m.isPlaying,
			{m.set(\phase2,cg,\decay2,ff)}
		);
	}),
	///////////////////////////////////////////////////////slider6
				Slider2D(c[5], Rect(10,205,100,185))
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
			q.isPlaying,
			{q.set(\phase3,cg,\decay3,ff)}
		);

	}),
	///////////////////////////////////////////////////////slider7
				Slider2D(c[5], Rect(190,205,100,185))
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
			w.isPlaying,
			{w.set(\phase4,cg,\decay4,ff)}
		);
	}),
	//////////////////////////////////////////////////////////////////button8
		Button(c[5], Rect(140,10,35,35))
		.background_(Color.rand)
	.states_([
	["OFF",Color.rand,Color.rand],
	["ON",Color.rand,Color.rand]])
.action_({
	arg obj;
	if(
		obj.value == 1,
		{
			n = Synth.new(
				\imp1,
				[

					\freq1, c[5].children[12].value.linexp(0,1,20,286),
						\out1, c[5].children[13].value.linexp(0,1,0.5,7),
						\time1, c[5].children[0].value.linexp(0,1,0.1,10),
						\phase1, c[5].children[4].value.y.linexp(0,1,20,286),
						\decay1, c[5].children[4].value.x.linexp(0,1,1,5),
						\gate1, 1
				]
			).register;
		},
		{n.free}
	);
}),
	////////////////////////////////////////////////////////////////button9
		Button(c[5], Rect(325,10,35,35))
		.background_(Color.rand)
	.states_([
	["OFF",Color.rand,Color.rand],
	["ON",Color.rand,Color.rand]])
.action_({
	arg obj;
	if(
		obj.value == 1,
		{
			m = Synth.new(
				\imp2,
				[

					\freq2, c[5].children[14].value.linexp(0,1,20,286),
						\out2, c[5].children[15].value.linexp(0,1,0.5,7),
						\time2, c[5].children[1].value.linexp(0,1,0.1,10),
						\phase2, c[5].children[5].value.y.linexp(0,1,20,286),
						\decay2, c[5].children[5].value.x.linexp(0,1,1,5),
						\gate2, 1
				]
			).register;
		},
		{m.free}
	);
}),
	/////////////////////////////////////////////////////////////////////button10
		Button(c[5], Rect(140,205,35,35))
		.background_(Color.rand)
	.states_([
	["OFF",Color.rand,Color.rand],
	["ON",Color.rand,Color.rand]])
.action_({
	arg obj;
	if(
		obj.value == 1,
		{
			q = Synth.new(
				\imp3,
				[


					\freq3, c[5].children[16].value.linexp(0,1,20,286),
						\out3, c[5].children[17].value.linexp(0,1,0.5,7),
						\time3, c[5].children[2].value.linexp(0,1,0.1,10),
						\phase3, c[5].children[6].value.y.linexp(0,1,20,286),
						\decay3, c[5].children[6].value.x.linexp(0,1,1,5),
						\gate3, 1
				]
			).register;
		},
		{q.free}
	);
}),
	/////////////////////////////////////////////////////////////////////button11
		Button(c[5], Rect(325,205,35,35))
		.background_(Color.rand)
	.states_([
	["OFF",Color.rand,Color.rand],
	["ON",Color.rand,Color.rand]])
.action_({
	arg obj;
	if(
		obj.value == 1,
		{
			w = Synth.new(
				\imp4,
				[
                      \freq4, c[5].children[18].value.linexp(0,1,20,286),
						\out4, c[5].children[19].value.linexp(0,1,0.5,7),
						\time4, c[5].children[3].value.linexp(0,1,0.1,10),
						\phase4, c[5].children[7].value.y.linexp(0,1,20,286),
						\decay4, c[5].children[7].value.x.linexp(0,1,1,5),
						\gate4, 1
				]
			).register;
		},
		{w.free}
	);
}),
	///////////////////////////////////////////////////////slider12
				Slider(c[5], Rect(120,115,65,10))
				.background_(Color.rand)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linexp(0,1,20,286).postln;
		if(
		n.isPlaying,
		{n.set(\freq1, cf)}
	);
		c[5].children[34].value_(obj.value.linexp(0,1,20,286));
	}),
///////////////////////////////////////////////////////slider13
				Slider(c[5], Rect(120,150,65,10))
				.background_(Color.rand)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linexp(0,1,0.5,7).postln;
	if(
		n.isPlaying,
		{n.set(\out1, cf)}
	);
		c[5].children[35].value_(obj.value.linexp(0,1,0.5,7));
}),///////////////////////////////////////////////////////slider14
				Slider(c[5], Rect(300,115,65,10))
				.background_(Color.rand)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linexp(0,1,20,286).postln;
	if(
		m.isPlaying,
		{m.set(\freq2, cf)}
	);
		c[5].children[37].value_(obj.value.linexp(0,1,20,286));
}),///////////////////////////////////////////////////////slider15
				Slider(c[5], Rect(300,150,65,10))
				.background_(Color.rand)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linexp(0,1,0.5,7).postln;
	if(
		m.isPlaying,
		{m.set(\out2, cf)}
	);
		c[5].children[38].value_(obj.value.linexp(0,1,0.5,7));
}),
///////////////////////////////////////////////////////slider16
				Slider(c[5], Rect(120,315,65,10))
				.background_(Color.rand)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linexp(0,1,20,286).postln;
	if(
		q.isPlaying,
		{q.set(\freq3, cf)}
	);
		c[5].children[40].value_(obj.value.linexp(0,1,20,286));
}),
	///////////////////////////////////////////////////////slider17
				Slider(c[5], Rect(120,350,65,10))
				.background_(Color.rand)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linexp(0,1,0.5,7).postln;
	if(
		q.isPlaying,
		{q.set(\out3, cf)}
	);
		c[5].children[41].value_(obj.value.linexp(0,1,0.5,7));
}),

		/////////////////////////////////////////////////////////////////////slider18
					Slider(c[5], Rect(300,315,65,10))
				.background_(Color.rand)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linexp(0,1,20,286).postln;
	if(
		w.isPlaying,
		{w.set(\freq4, cf)}
	);
		c[5].children[43].value_(obj.value.linexp(0,1,20,286));
}),	/////////////////////////////////////////////////////////////////////slider19
					Slider(c[5], Rect(300,350,65,10))
				.background_(Color.rand)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linexp(0,1,0.5,7).postln;
	if(
		w.isPlaying,
		{w.set(\out4, cf)}
	);
		c[5].children[44].value_(obj.value.linexp(0,1,0.5,7));
}),
	///////////////////////////////////////////text20
		StaticText(c[5],Rect(120,125,10,10))
.string_("f1"),
/////////////////////////////////////////text21
		StaticText(c[5],Rect(300,125,10,10))
.string_("f2"),
/////////////////////////////////////////text22
		StaticText(c[5],Rect(120,325,10,10))
.string_("f3"),
/////////////////////////////////////////text23
		StaticText(c[5],Rect(300,325,10,10))
.string_("f4"),
/////////////////////////////////////////text24
		StaticText(c[5],Rect(120,90,10,10))
.string_("t1"),
/////////////////////////////////////////text25
		StaticText(c[5],Rect(300,90,10,10))
.string_("t2"),
/////////////////////////////////////////text26
		StaticText(c[5],Rect(120,290,10,10))
.string_("t3"),
/////////////////////////////////////////text27
		StaticText(c[5],Rect(300,290,10,10))
.string_("t4"),
/////////////////////////////////////////text28
		StaticText(c[5],Rect(120,160,15,10))
.string_("o1"),
/////////////////////////////////////////text29
		StaticText(c[5],Rect(300,160,15,10))
.string_("o2"),
/////////////////////////////////////////text30
		StaticText(c[5],Rect(120,360,15,10))
.string_("o3"),
	/////////////////////////////////////////text31
		StaticText(c[5],Rect(300,360,15,10))
.string_("o4"),

	///////////////////////////////////////////numberbox32
	NumberBox(c[5], Rect(140,90,40,20))
.value_(0.1)
.clipLo_(0.1)
.clipHi_(10)
.decimals_(2)
	.action_({
	arg obj;
	c[5].children[0].valueAction_(obj.value.explin(0.1,10,0,1))
	}),
		/////////////////////////////////////////////////////numberbox34
	NumberBox(c[5], Rect(140,125,40,20))
.value_(20)
.clipLo_(20)
.clipHi_(286)
.decimals_(2)
	.action_({
	arg obj;
	c[5].children[12].valueAction_(obj.value.explin(20,286,0,1))
	}),
		/////////////////////////////////////////////////////numberbox35
	NumberBox(c[5], Rect(140,160,40,20))
.value_(0.5)
.clipLo_(0.5)
.clipHi_(7)
.decimals_(2)
	.action_({
	arg obj;
	c[5].children[13].valueAction_(obj.value.explin(0.5,7,0,1))
	}),
		/////////////////////////////////////////////////////numberbox36
	NumberBox(c[5], Rect(320,90,40,20))
.value_(0.1)
.clipLo_(0.1)
.clipHi_(10)
.decimals_(2)
	.action_({
	arg obj;
	c[5].children[1].valueAction_(obj.value.explin(0.1,10,0,1))
	}),
		/////////////////////////////////////////////////////numberbox37
	NumberBox(c[5], Rect(320,125,40,20))
.value_(0.1)
.clipLo_(20)
.clipHi_(286)
.decimals_(2)
	.action_({
	arg obj;
	c[5].children[14].valueAction_(obj.value.explin(20,286,0,1))
	}),
		/////////////////////////////////////////////////////numberbox38
	NumberBox(c[5], Rect(320,160,40,20))
.value_(0.5)
.clipLo_(0.5)
.clipHi_(7)
.decimals_(2)
	.action_({
	arg obj;
	c[5].children[15].valueAction_(obj.value.explin(0.5,7,0,1))
	}),
		/////////////////////////////////////////////////////numberbox39
	NumberBox(c[5], Rect(140,290,40,20))
.value_(0.1)
.clipLo_(0.1)
.clipHi_(10)
.decimals_(2)
	.action_({
	arg obj;
	c[5].children[2].valueAction_(obj.value.explin(0.1,10,0,1))
	}),
		/////////////////////////////////////////////////////numberbox40
	NumberBox(c[5], Rect(140,325,40,20))
.value_(20)
.clipLo_(20)
.clipHi_(286)
.decimals_(2)
	.action_({
	arg obj;
	c[5].children[16].valueAction_(obj.value.explin(20,286,0,1))
	}),
		/////////////////////////////////////////////////////numberbox41
	NumberBox(c[5], Rect(140,360,40,20))
.value_(0.5)
.clipLo_(0.5)
.clipHi_(7)
.decimals_(2)
	.action_({
	arg obj;
	c[5].children[17].valueAction_(obj.value.explin(0.5,7,0,1))
	}),
		/////////////////////////////////////////////////////numberbox42
	NumberBox(c[5], Rect(320,290,40,20))
.value_(0.1)
.clipLo_(0.1)
.clipHi_(10)
.decimals_(2)
	.action_({
	arg obj;
	c[5].children[3].valueAction_(obj.value.explin(0.1,10,0,1))
	}),
		/////////////////////////////////////////////////////numberbox43
	NumberBox(c[5], Rect(320,325,40,20))
.value_(20)
.clipLo_(20)
.clipHi_(286)
.decimals_(2)
	.action_({
	arg obj;
	c[5].children[18].valueAction_(obj.value.explin(20,286,0,1))
	}),
		/////////////////////////////////////////////////////numberbox44
	NumberBox(c[5], Rect(320,360,40,20))
.value_(0.5)
.clipLo_(0.5)
.clipHi_(7)
.decimals_(2)
	.action_({
	arg obj;
	c[5].children[19].valueAction_(obj.value.explin(0.5,7,0,1))
	})
);
)



s.quit;