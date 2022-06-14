s.options.device_("ASIO : ASIO4ALL v2");
s.options.numOutputBusChannels=4;

s.record(numChannels:4);

(
SynthDef(\rekord,
	{   arg azimuth,decay;
		var audio,sig,sig1,env;
		sig= SoundIn.ar(0);
		sig1=SoundIn.ar(1);
		env=EnvGen.kr(Env.new([0,1,1,0],[0,decay+0.3,0]),gate:1,doneAction:2);
			#w,x,y,z=PanB.ar(sig+sig1,azimuth,0);
     audio=DecodeB2.ar(4, w, x, y, 0.5);
	Out.ar(0,audio*env);
}
).add;
)
////////////////////////////////////////
(
SynthDef(\rekord,
	{   arg azimuth,decay;
		var audio,sig,sig1,env;
		sig= SoundIn.ar(0);
		sig1=SoundIn.ar(1);
	env=env=EnvGen.kr(Env.perc(0.01,decay+1.6),gate:1, doneAction:2);
		//env=EnvGen.kr(Env.new([0,1,1,0],[0,decay,0]),gate:1,doneAction:2);
		audio= PanAz.ar(4,sig+sig1,azimuth);
	Out.ar(0,audio*env);
}
).add;
)
a=Synth(\rekord)




MIDIClient.init;
m = MIDIOut(1);

(
//var dict = IdentityDictionary[\A -> "ABB", \B -> "BCC", \C -> "CAA"];
var dict1 = IdentityDictionary[\A -> "BCDCB", \B -> "CDEDC", \C -> "DEGED",\D -> "EFGFE", \E -> "FGKGF", \F -> "GKAKG",\G -> "KABAK", \K -> "ABCBA"];
var dict = IdentityDictionary[\A -> "BCDCB", \B -> "CDEDC", \C -> "DEGED",\D -> "EFGFE", \E -> "FGKGF", \F -> "GKAKG",\G -> "KABAK", \K -> "ABCBA"];
//var dict = IdentityDictionary[\A -> "AB", \B -> "A", \C -> "DB", \D -> "BC"];
//var dict = IdentityDictionary[\A -> "AB", \B -> "A"];
//var dict = IdentityDictionary[\A -> "ABA", \B -> "BBB"];
//var word = "AC";
//var word = "A";
var word = "ABCDEFGKGFEDCBA";
var word1 = "ABCDEFGKGFEDCBA";
var string_temp = "";
var string_temp1 = "";
var iter = 5;
var iter1 = 5;

//var dictnotes = IdentityDictionary[\A -> 0.125, \B -> 0.25, \C -> 0.5, \D -> 1];
//var dictnotes = IdentityDictionary[\A -> 0.25, \B ->  0.5];
var dictnotes = IdentityDictionary[\A -> 0.03125, \B -> 0.0625, \C -> 0.125, \D -> 0.25, \E -> 0.5, \F -> 1, \G -> 2, \K -> 4];
//var dictnotes = IdentityDictionary[\A -> 0.125, \B -> 0.25, \C -> 0.5];
var dictnotes1 = IdentityDictionary[\A -> 0, \B -> 1, \C -> 2, \D -> 3, \E -> 4, \F -> 5, \G -> 6, \K -> 7];

var notes=[];
var notes1=[];

iter.do({

word.asArray.do({|i|
    string_temp = string_temp ++ dict[i.asSymbol];
});

word = string_temp;
	string_temp = "";

});

word.postln;

iter1.do({

word1.asArray.do({|i|
    string_temp1 = string_temp1 ++ dict1[i.asSymbol];
});

word1 = string_temp1;
	string_temp1 = "";
});

word1.postln;

word.do({|i| notes = notes ++ dictnotes[i.asSymbol];});
word1.do({|i| notes1 = notes1 ++ dictnotes1[i.asSymbol];});

notes.postln;
notes1.postln;





Pbind(*[\instrument: \rekord, \dur:Pseq(notes,inf),\decay:Pseq(notes,inf), \azimuth: Pxrand(#[-0.75,-0.25,0.25,0.75],inf)]).play(quant:60);
a = Pbind(\dur,Pseq(notes,inf),\scale, Scale.phrygian,\degree, Pseq(notes1,inf));
(a <> (type: \midi, midiout: m)).play(quant:60);
)
