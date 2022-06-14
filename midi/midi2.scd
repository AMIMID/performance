MIDIClient.init;
MIDIIn.connectAll;
~note=Array.newClear(128);
~bend=8192;
~data=127;
~modul=127;




(
////////////////////////////////midi
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

//////////////////////////////////////synth
(SynthDef(\synth,
	{	arg fre,pha=0.1,amp=1,gate=0,velosity=1,bend=1,cutoff=20;

		var out_sig,env,vomplex_wace;

		env= EnvGen.kr(Env.adsr(0.1,0.3,releaseTime:2),gate:gate,doneAction:2);
		vomplex_wace= Saw.ar(fre*bend.midiratio)

		;


		out_sig=LPF.ar(vomplex_wace,cutoff);
		Out.ar(0,out_sig*velosity*env!2)}).add);
)