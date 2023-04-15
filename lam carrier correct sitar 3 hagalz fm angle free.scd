//////////////////////////////////synth server and audio settings
s.options.sampleRate = 44100;
s.options.numBuffers = 1024*8;
s.options.numRGens=64*1;
s.options.numWireBufs=64*1;
s.options.numInputBusChannels=0;
s.options.outputStreamsEnabled.postln
s.options.device_("USB Sound Device");

({Out.ar(2,SoundIn.ar(0))}.play;
s.record(numChannels:4)

s.options.numWireBufs = 1024*16;

s.options.numOutputBusChannels=4;
TempoClock.default.tempo_(120/120);
s.options.memSize = 8192*16;
s.waitForBoot
(
(
SynthDef.new(\oa, {
	arg n1=1, n2=1, n3=1,rotation1=0.01,rotation2=0.01,rotation3=0.01, cf=8, theta=45;
	var frequency, note1, note2, note3, detune1,detune2, detune3,detune4, detune5,detune6;
	var envelope,envelopneg;
	var osc_1, osc_2, osc_3,osc_1neg, osc_2neg, osc_3neg;
	var over1, m;
	var freq;
	var bank, angle1,angle2,angle3,angle4,angle5,angle6, scale;
    var fundamental;
	var v=343;
	var env,level,duration,face1,face2,face3,face4;
	var edge1a,edge1b,edge1c,edge2a,edge2b,edge2c;
	var edge3a,edge3b,edge3c,edge4a,edge4b,edge4c;
	var modulator_length, carrier_length, carrier_freq;

	over1=1;
	over1=2;
	m=0;
	frequency=1;
	bank=32;
	angle1=90;
	angle2=180;
	angle3=135;
	angle4=90.neg;
	angle5=180.neg;
	angle6=135.neg;
	freq =(((4*cf)-1)*((4*cf)/2))*frequency;

 fundamental=((4*cf)-1)*((4*cf)/2);

	note1 = 2.pow(n1/(fundamental*2));
	note2 = 2.pow(n2/(fundamental*2));
	note3 = 2.pow(n3/(fundamental*2));

	modulator_length=v/freq;
	carrier_length=modulator_length/2;
	carrier_freq=v/carrier_length;

	envelope= EnvGen.ar(Env.new([0,2,0],[4,4],[-4,4]), doneAction: 0);
	envelopneg= EnvGen.ar(Env.new([0,0,2,0],[0.1,4,4],[0,-4,4]), doneAction: 2);

	bank.do{

				angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune1=exp(Complex(0,1)*angle1);

		angle2=(angle2+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune2=exp(Complex(0,1)*angle2);

		angle3=(angle3+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune3=exp(Complex(0,1)*angle3);

		angle4=(angle4-(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune4=exp(Complex(0,1)*angle4);

		angle5=(angle5-(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune5=exp(Complex(0,1)*angle5);

		angle6=(angle6-(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune6=exp(Complex(0,1)*angle6);

osc_1 = (Pan4.ar(
			SinOsc.ar(freq:((note1*carrier_freq)*over1)*detune1.real+SinOsc.ar(((note1*freq)*over1)*detune1.real,mul:over1),mul:((cf*note1)*over1).reciprocal*detune1.real,phase:detune1.theta)
		*
		SinOsc.ar(freq:((note1*carrier_freq)*over1)*detune1.imag+SinOsc.ar(((note1*freq)*over1)*detune1.imag,mul:over1),mul:((cf*note1)*over1).reciprocal*detune1.imag,phase:detune1.theta+90.degrad)

,xpos:SinOsc.ar(rotation1,phase:detune1.theta+0.degrad,mul:detune1.real),ypos:SinOsc.ar(rotation1,phase:detune1.theta+90.degrad,mul:detune1.imag)));


osc_2 = (Pan4.ar(
		SinOsc.ar(freq:((note2*carrier_freq)*over1)*detune2.real+SinOsc.ar(((note2*freq)*over1)*detune1.real,mul:over1),mul:((cf*note2)*over1).reciprocal*detune2.real,phase:detune2.theta)
		*
		SinOsc.ar(freq:((note2*carrier_freq)*over1)*detune2.imag+SinOsc.ar(((note2*freq)*over1)*detune1.imag,mul:over1),mul:((cf*note2)*over1).reciprocal*detune2.imag,phase:detune2.theta+90.degrad)

,xpos:SinOsc.ar(rotation2,phase:detune2.theta+90.degrad,mul:detune2.real),ypos:SinOsc.ar(rotation2,phase:detune2.theta+0.degrad,mul:detune2.imag)));


osc_3 = (Pan4.ar(
		SinOsc.ar(freq:((note3*carrier_freq)*over1)*detune3.real+SinOsc.ar(((note3*freq)*over1)*detune1.real,mul:over1),mul:((cf*note3)*over1).reciprocal*detune3.real,phase:detune3.theta)
		*
		SinOsc.ar(freq:((note3*carrier_freq)*over1)*detune3.imag+SinOsc.ar(((note3*freq)*over1)*detune1.imag,mul:over1),mul:((cf*note3)*over1).reciprocal*detune3.imag,phase:detune3.theta+90.degrad)

			,xpos:SinOsc.ar(rotation3,phase:detune3.theta+theta.degrad,mul:detune3.real),ypos:SinOsc.ar(rotation3,phase:detune3.theta+(theta+90).degrad,mul:detune3.imag)));


osc_1neg = (Pan4.ar(
		SinOsc.ar(freq:((note1*carrier_freq)*over1)*detune4.real+SinOsc.ar(((note1*freq)*over1)*detune1.real,mul:over1),mul:((cf*note1)*over1).reciprocal*detune4.real,phase:detune4.theta)
		*
		SinOsc.ar(freq:((note1*carrier_freq)*over1)*detune4.imag+SinOsc.ar(((note1*freq)*over1)*detune1.imag,mul:over1),mul:((cf*note1)*over1).reciprocal*detune4.imag,phase:detune4.theta+90.neg.degrad)


,xpos:SinOsc.ar(rotation1,phase:detune4.theta+0.degrad,mul:detune4.real),ypos:SinOsc.ar(rotation1,phase:detune4.theta+90.neg.degrad,mul:detune4.imag)));


osc_2neg = (Pan4.ar(
		SinOsc.ar(freq:((note2*carrier_freq)*over1)*detune5.real+SinOsc.ar(((note2*freq)*over1)*detune1.real,mul:over1),mul:((cf*note2)*over1).reciprocal*detune5.real,phase:detune5.theta)
		*
		SinOsc.ar(freq:((note2*carrier_freq)*over1)*detune5.imag+SinOsc.ar(((note2*freq)*over1)*detune1.imag,mul:over1),mul:((cf*note2)*over1).reciprocal*detune5.imag,phase:detune5.theta+90.neg.degrad)

,xpos:SinOsc.ar(rotation2,phase:detune5.theta+90.neg.degrad,mul:detune5.real),ypos:SinOsc.ar(rotation2,phase:detune5.theta+0.degrad,mul:detune5.imag)));


osc_3neg = (Pan4.ar(
		SinOsc.ar(freq:((note3*carrier_freq)*over1)*detune6.real+SinOsc.ar(((note3*freq)*over1)*detune1.real,mul:over1),mul:((cf*note3)*over1).reciprocal*detune6.real,phase:detune6.theta)
		*
		SinOsc.ar(freq:((note3*carrier_freq)*over1)*detune6.imag+SinOsc.ar(((note3*freq)*over1)*detune1.imag,mul:over1),mul:((cf*note3)*over1).reciprocal*detune6.imag,phase:detune6.theta+90.neg.degrad)

,xpos:SinOsc.ar(rotation3,phase:detune6.theta+theta.neg.degrad,mul:detune6.real),ypos:SinOsc.ar(rotation3,phase:detune6.theta+(theta+90).neg.degrad,mul:detune6.imag)));

	    osc_1=osc_1*envelope;
		osc_2=osc_2*envelope;
		osc_3=osc_3*envelope;
		osc_1neg=osc_1neg*envelopneg;
		osc_2neg=osc_2neg*envelopneg;
		osc_3neg=osc_3neg*envelopneg;


		Out.ar(0,LeakDC.ar(osc_1));
		Out.ar(0,LeakDC.ar(osc_2));
		Out.ar(0,LeakDC.ar(osc_3));
		Out.ar(0,LeakDC.ar(osc_1neg));
		Out.ar(0,LeakDC.ar(osc_2neg));
		Out.ar(0,LeakDC.ar(osc_3neg));


		m = m+1;
		over1 = over1 + (m+1)/1;


	};

}).add;
);
)


/////////////////////////////////Synth Patterns(generators)
(
(
Pdef(\1, Pbind(\instrument, \oa, \dur,Pexprand(2,2,12*4),
	\cf,Prand([1],12*4,),
	\n1,Pseq(Array.fill(12*4, { arg i; i + 1 }),1),
   \n2,Pseq(Array.fill(12*4, { arg i; i + 1 }),1),
  	\n3,Pseq(Array.fill(12*4, { arg i; i + 1 }),1),
	\rotation1,Pexprand(0.1,1,inf),
	\rotation2,Pexprand(0.1,1,inf),
	\rotation3,Pexprand(0.1,1,inf),
	\theta,Pexprand(45,45,inf);
)).play(quant:1);
);
s.record(numChannels:4) ;
)


////record in 6 channels beggining to end of pattern definition duration

////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\/////////////////\\\\\\\\\\\\\\\/////////////////
////CHANNELS:BLRF_LR


/////channel recordings will be downmixed in stereo under the above sequence for use in the Granulator.
////Granulator uses the left and right mono individual channels from the resulting mix, as buffers

