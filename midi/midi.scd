s.options.numOutputBusChannels =2;





(Env([0,0.6,0.6,0.9,0.9,0,0,0.9,0.9,0.6,0.6,0],[0.6,0.6,0.6,0.6,0.6,3,0.6,0.6,0.6,0.6,0.6])).plot
////////////////////////////////////////for mono output
////there is only one main oscilator and synth and the addition of the synthesis takes place inside the oscilator

s.boot

s.scope
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
	{	arg fre,pha=0.1,amp=0.3,gate=0,velosity=1,bend=1,cutoff=20;

		var out_sig,env,vomplex_wace;

		env= EnvGen.kr(Env.adsr(0.1,0.3,releaseTime:0.6),gate:gate,doneAction:2);
	vomplex_wace= SinOsc.kr(freq:SinOsc.ar(fre*0.5*MouseX.kr(1,2)*pha)+SinOsc.kr(fre*bend.midiratio*0.5*4*amp),
		                    	width:SinOsc.ar(fre*0.5*MouseX.kr(1,2)*pha)+SinOsc.kr(fre*bend.midiratio*0.5*4*amp),
			mul:(SinOsc.kr(fre*0.5*MouseX.kr(1,2)*pha)+SinOsc.ar(fre*bend.midiratio*0.5*4*amp))*0.5,
			                                      add:                                    SinOsc.ar(freq:SinOsc.ar(fre*bend.midiratio*1*MouseX.kr(1,2)*pha)+SinOsc.kr(fre*1*MouseY.kr(1,2)*amp),
	                 phase:SinOsc.ar(fre*bend.midiratio*1*MouseX.kr(1,2)*pha)+SinOsc.kr(fre*1*MouseY.kr(1,2)*amp),
		             mul:(SinOsc.kr(fre*bend.midiratio*1*MouseX.kr(1,2)*pha)+SinOsc.ar(fre*1*MouseY.kr(1,2)*amp))*0.33,
						              add:
				     SinOsc.ar(freq:SinOsc.ar(fre*bend.midiratio*2*MouseX.kr(1,2)*pha)+SinOsc.kr(fre*2*MouseY.kr(1,2)*amp),
					           phase:SinOsc.ar(fre*bend.midiratio*2*MouseX.kr(1,2)*pha)+SinOsc.kr(fre*2*MouseY.kr(1,2)*amp),
					     mul:(SinOsc.kr(fre*bend.midiratio*2*MouseX.kr(1,2)*pha)+SinOsc.ar(fre*2*MouseY.kr(1,2)*amp))*0.25,

						       	      add:
				  SinOsc.ar(freq:SinOsc.ar(fre*bend.midiratio*2.5*MouseX.kr(1,2)*pha)+SinOsc.kr(fre*2.5*MouseY.kr(1,2)*amp),
			               phase:SinOsc.ar(fre*bend.midiratio*2.5*MouseX.kr(1,2)*pha)+SinOsc.kr(fre*2.5*MouseY.kr(1,2)*amp),			             mul:(SinOsc.kr(fre*bend.midiratio*2.5*MouseX.kr(1,2)*pha)+SinOsc.ar(fre*2.5*MouseY.kr(1,2)*amp))*0.2,

						       	      add:
		       SinOsc.ar(freq:SinOsc.ar(fre*bend.midiratio*3*MouseX.kr(1,2)*pha)+SinOsc.kr(fre*3*MouseY.kr(1,2)*amp),
					          phase:SinOsc.ar(fre*bend.midiratio*3*MouseX.kr(1,2)*pha)+SinOsc.kr(fre*3*MouseY.kr(1,2)*amp),
					      mul:(SinOsc.kr(fre*bend.midiratio*3*MouseX.kr(1,2)*pha)+SinOsc.ar(fre*3*MouseY.kr(1,2)*amp))*0.16667,

						       	      add:
				 SinOsc.ar(freq:SinOsc.ar(fre*bend.midiratio*3.5*MouseX.kr(1,2)*pha)+SinOsc.kr(fre*3.5*MouseY.kr(1,2)*amp),
		          phase:SinOsc.ar(fre*bend.midiratio*3.5*MouseX.kr(1,2)*pha)+SinOsc.kr(fre*3.5*MouseY.kr(1,2)*amp),
			   mul:(SinOsc.kr(fre*bend.midiratio*3.5*MouseX.kr(1,2)*pha)+SinOsc.ar(fre*3.5*MouseY.kr(1,2)*amp))*1/7,

						       	      add:
				     SinOsc.ar(freq:SinOsc.ar(fre*bend.midiratio*4*MouseX.kr(1,2)*pha)+SinOsc.kr(fre*4*MouseY.kr(1,2)*amp),
					           phase:SinOsc.ar(fre*bend.midiratio*4*MouseX.kr(1,2)*pha)+SinOsc.kr(fre*4*MouseY.kr(1,2)*amp),
			             mul:(SinOsc.kr(fre*bend.midiratio*4*MouseX.kr(1,2)*pha)+SinOsc.ar(fre*4*MouseY.kr(1,2)*amp))*1/8
						       )))))));


		out_sig=LPF.ar(vomplex_wace,cutoff);
		Out.ar(0,out_sig*velosity*env*0.1!2)}).add);
)
s.record