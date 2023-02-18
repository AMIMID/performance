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


(
Window.closeAll;
////////////////////////////////////////////////////////////////////////////////////////////////window
w = Window("Nest", Rect(100,10,1000,600))
.front
.alwaysOnTop_(true);

StaticText(w,Rect(20,2,200,20))
.string_("NIL");


w.view.decorator_(FlowLayout(w.bounds,20@20,20@20));

c = Array.with(

	 CompositeView(w, 950@500)
	.background_(Color.rand);
);

///////////////////////////////////////////////////////////////////////////////////////////hui
Array.with(
	///////////////////////////////////////////////////////lf
	Slider2D(c[0], Rect(10+(180*0),10,185,185)).background_(Color.rand)
	.x_(0)
	.y_(0)
	.action_({
		arg obj;
		var azx, azy, az,el;

		azx = obj.y;
		azy = obj.x;
		el = Complex.new(azx,azy).abs.postln;
		az = [azx, azy].postln;
		if(
			n.isPlaying,
			{n.set()});
	}),
		///////////////////////////////////////////////////////rf
	Slider2D(c[0], Rect(10+(180*1),10,185,185)).background_(Color.rand)
	.x_(0)
	.y_(0)
	.action_({
		arg obj;
		var azx, azy, az,el;

		azx = obj.y;
		azy = obj.x;
		el = Complex.new(azx,azy).abs;
		az = [azx, azy];
		if(
			n.isPlaying,
			{n.set()});
	}),
		///////////////////////////////////////////////////////rb
	Slider2D(c[0], Rect(10+(180*0),185,185,185)).background_(Color.rand)
	.x_(0)
	.y_(0)
	.action_({
		arg obj;
		var azx, azy, az,el;

		azx = obj.y;
		azy = obj.x;
		el = Complex.new(azx,azy).abs;
		az = [azx, azy];
		if(
			n.isPlaying,
			{n.set()});
	}),
		///////////////////////////////////////////////////////lb
	Slider2D(c[0], Rect(10+(180*1),185,185,185)).background_(Color.rand)
	.x_(0)
	.y_(0)
	.action_({
		arg obj;
		var azx, azy, az,el;

		azx = obj.y;
		azy = obj.x;
		el = Complex.new(azx,azy).abs;
		az = [azx, azy];
		if(
			n.isPlaying,
			{n.set()});
	}),
/////////////////////////////////////////////////////////////////////////////////////////level
	Slider(c[0], Rect(10+(180*3),10,40,350)).background_(Color.rand)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,-6,6).postln;
		if(
		~o.isPlaying,
			{n.set()});
	});
///////////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

StaticText(c[0],Rect(50+(180*1),10,80,20)).string_("lf"),
StaticText(c[0],Rect(50+(180*0),10,80,20)).string_("lr"),
StaticText(c[0],Rect(50+(180*1),195,80,20)).string_("rb"),
StaticText(c[0],Rect(50+(180*0),195,80,20)).string_("rl"),

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