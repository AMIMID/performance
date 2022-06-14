s.options.device_("ASIO : ASIO4ALL v2");
s.options.numOutputBusChannels=2



(
SynthDef(\rekord,
	{   arg azimuth;
		var audio,sig,sig1,env;
		sig= SoundIn.ar(0);
		sig1=SoundIn.ar(1);
		env=EnvGen.kr(Env.perc(0.01,1),gate:1,doneAction:2);
			#w,x,y,z=PanB.ar(sig+sig1,azimuth,0);
     audio=DecodeB2.ar(2, w, x, y, 0.5);
	Out.ar(0,audio*env);
}
).add;
)



a=Synth(\rekord)




MIDIClient.init;
m = MIDIOut(1);

(
//Pbind(*[\instrument: \rekord, \dur:1/4, \azimuth: Pxrand([-0.5pi,0.5pi],inf)]).play(quant:1);
a = Pbind(\dur,2/4,\scale, Scale.phrygian,\degree, Prand([0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15], inf));
(a <> (type: \midi, midiout: m)).play(quant:1);
)


​
