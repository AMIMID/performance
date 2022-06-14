s.boot
/////////////////////////////////SYNTHS/////////////////////////./////////

//////////PinkNoise filter///
(
(
v = SynthDef.new(\audio,
	{
		arg freq = 100, rq=0.2, gatef=0;
		var sig, env;
				env = EnvGen.kr(Env.adsr(0.05,0.1,0.5,3),gatef);

		sig = PinkNoise.ar(1);
		sig = BPF.ar(sig,
			freq.lag(0.5),
			rq.lag(0.5),
			1/rq.sqrt.lag(0.5)
		);
		sig = PanAz.ar(
        2,                 // numChans
        sig,     // in
        SinOsc.kr(MouseX.kr(0.1, 3, 'exponential')), // pos
        0.5,            // level
        1            // width
    );


		Out.ar(0,sig*env *2);
}).add;
);


///////////LFNoiseBlip detune///
(
y = SynthDef.new(\tone1,
	{
		arg frequ=10, nharm=1, detune=0, gate=0,
		pan=0, amp=1;
		var sig, env;
		env = EnvGen.kr(Env.adsr(0.05,0.1,0.5,3),gate);
		sig = Blip.ar(
			frequ *
			LFNoise1.kr(0.2!16).bipolar(detune.neg,detune).midiratio,nharm);

		sig = sig * LFNoise1.kr(0.5!16).exprange(0.1,1);
		sig = Splay.ar(sig);
		sig = sig * env * amp;


		Out.ar(1,sig);
}).add
);


/////////////////LFNoiseBlip detune pan//////

(
p = SynthDef.new(\tone2,
	{
		arg frequ1=10, nharm1=1, detune1=0, gate1=0,
		pan=0, amp1=1;
		var sig, env;
		env = EnvGen.kr(Env.adsr(0.1,0.5,0.5,4),gate1);
		sig = Blip.ar(
			frequ1 *
			LFNoise1.kr(1!16).bipolar(detune1.neg,detune1).midiratio,nharm1
		);
		sig = sig * LFNoise0.kr(0.5!16).exprange(0.1,1);
		sig = Splay.ar(sig);
		sig = Balance2.ar(sig[0],sig[1],pan);
		sig = sig * env * amp1;


		Out.ar(0,sig);
}).add;
);

////////////////bubbles tzitzikas/////

(
b = SynthDef.new(\bubbles,
	{
		arg lfoDepth=200, lfoRate=4, gateb=0;
		var   env, freq, filtered, audio ;

		env = EnvGen.kr(Env.adsr(0.05,0.1,0.5,3),gateb);
		freq = LFSaw.kr(lfoRate, 0, lfoDepth, lfoDepth * 1.2);
		filtered = RLPF.ar(WhiteNoise.ar([0.03,0.03]), freq, 0.1);
		 audio = CombN.ar(filtered, 0.3, 0.3, 2, 1, filtered);

		Out.ar(0,audio * env);
}).add;
);

//////////

(
z = SynthDef.new(\tzitzi,
{
		arg freqz = 0.1, ampz=0.01, outz=1;
		var audio;

audio = BPZ2.ar(
in: WhiteNoise.ar( mul: LFPulse.kr(freq: LFPulse.kr(freq: freqz, iphase: 0, width: 0.16, mul: 10, add:6),iphase: 0, mul: ampz, add: 0.1)));

		Out.ar(outz, audio * ampz);
}).add;
);





///////////margaret/////////


(
n = SynthDef(\imp1,
	{
		arg time1=1, decay1=1, freq1=283, phase1=283, out1= 0.5, gate1=0;
		var audio1;
	    var env1;

		env1 =  EnvGen.kr(Env.adsr(0.05,0.1,0.5,3),gate1);

		audio1 =  Decay.ar(Impulse.ar(time1), decay1, SinOsc.ar(freq: freq1,phase:SinOsc.ar(phase1)));

		audio1 = PanAz.ar(
        2,                 // numChans
       audio1,     // in
        SinOsc.kr(out1), // pos
        0.5,            // level
        1            // width
    );


		Out.ar(0,audio1 * env1 * 2 );
}).add
);

///////////margaret/////////

(
m = SynthDef(\imp2,
	{
		arg time2=1, decay2=1, freq2=283, phase2=283, out2=0.5, gate2=0;
		var audio1;
	    var env1;

		env1 =  EnvGen.kr(Env.adsr(0.05,0.1,0.5,3),gate2);

		audio1 =  Decay.ar(Impulse.ar(time2), decay2, SinOsc.ar(freq: freq2,phase:SinOsc.ar(phase2)));
		audio1 = PanAz.ar(
        2,                 // numChans
        audio1,     // in
        SinOsc.kr(out2), // pos
        0.5,            // level
        1            // width
    );


		Out.ar(1,audio1 * env1 *2);
}).add
);
///////////margaret/////////

(
q = SynthDef(\imp3,
	{
		arg time3=1, decay3=1, freq3=283, phase3=283, out3=0.5, gate3=0;
		var audio1;
	    var env1;

		env1 =  EnvGen.kr(Env.adsr(0.05,0.1,0.5,3),gate3);

		audio1 =  Decay.ar(Impulse.ar(time3), decay3, SinOsc.ar(freq: freq3,phase:SinOsc.ar(phase3)));
audio1 = PanAz.ar(
        2,                 // numChans
        audio1,     // in
        SinOsc.kr(out3), // pos
        0.5,            // level
        1            // width
    );

		Out.ar(0,audio1 * env1 * 2);
}).add
);
///////////margaret/////////

(
w = SynthDef(\imp4,
	{
		arg time4=1, decay4=1, freq4=283, phase4=283, out4=0.5, gate4=0;
		var audio1;
	    var env1;

		env1 =  EnvGen.kr(Env.adsr(0.05,0.1,0.5,3),gate4);

		audio1 =  Decay.ar(Impulse.ar(time4), decay4, SinOsc.ar(freq: freq4,phase:SinOsc.ar(phase4)));
audio1 = PanAz.ar(
        2,                 // numChans
        audio1,     // in
        SinOsc.kr(out4), // pos
        0.5,            // level
        1            // width
    );

		Out.ar(1,audio1 * env1 * 2);
}).add
);
)


(
m = Synth(\imp2);
n = Synth(\imp1);
q = Synth(\imp3);
w = Synth(\imp4);

)
////////boompap////////////////

(
p = SynthDef(\imp2,
	{
		var audio;
	    var env2;
		var audio1;
		var audio2;
        var freq;

		freq = 233;
		env2 = EnvGen.kr(Env.perc(66, 1));

		audio1 = Decay.ar(Impulse.ar(1.5),Line.kr(1,10,65), SinOsc.ar(freq:[freq,freq + 1.5]));
	    audio2 = Decay.ar(Impulse.ar(0.5),1.5, SinOsc.ar(freq:65,mul:10));

	audio = audio1 + audio2;


		Out.ar(0,audio * env2);
}).add
);

p = Synth(\imp2)


(
p = Pseq(#[1, 30, 60, 90, 120], inf).asStream;
Routine({
    loop({
        Synth(\imp2,[\freq, a.next.midicps]);
        2.wait;
    })
}).play;
)

////////////////////Blip//////

(
l = SynthDef(\blip,
	{
		arg outl =0, freql =;
		var audio;

		audio =  SinOsc.ar(freql),Blip.ar(Line.ar(400,40,30),Line.ar(20,3,60)));

		Out.ar(outl,audio);
}).add
)

l = Synth(\blip).scope



//////////////////


(

SynthDef(\help_Klank, { arg out=0, i_freq;
    var klank, n, harm, amp, ring;

    // harmonics
    harm = \harm.ir(Array.series(4, 1, 1).postln);
    // amplitudes
    amp = \amp.ir(Array.fill(4, 0.05));
    // ring times
    ring = \ring.ir(Array.fill(4, 1));

    klank = Klank.ar(`[harm, amp, ring], {ClipNoise.ar(0.003)}.dup, i_freq);

    Out.ar(out, klank);
}).add;
)

// nothing special yet, just using the default set of harmonics.
a = Synth(\help_Klank, [\i_freq, 300]);

b = Synth(\help_Klank, [\i_freq, 400]);
c = Synth(\help_Klank, [\i_freq, 533.33]);
d = Synth(\help_Klank, [\i_freq, 711.11]);



//////decay beats////////////////////////////////


////snare//////////////
(
c = SynthDef(\snare,
	{
		arg outs =0;
		var audio;

audio = CombN.ar(Decay.ar(Impulse.ar(2,0.5), 0.2, BPF.ar(PinkNoise.ar(1!2), MouseX.kr(10,4000))), 0.1, 0.7, 3,6) ;

		Out.ar(outs,audio);
}).add
);

c = Synth(\snare)
////////////////////////





















































)














