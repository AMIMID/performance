(
Server.default = s = Server.local;

(
s.options.numWireBufs = 1024*2;
s.options.numOutputBusChannels=2;
s.options.numInputBusChannels=0;
s.options.memSize = 8192*8;
s.options.maxNodes = 1024 * 1;
);

s.waitForBoot{
Buffer.freeAll;
(
~t= Buffer.alloc(s,2048);
);


(
~time=1;
////////fractal
		{
var signal,wt,m=0,amp;

~level=45.round(1).collect{m=m+1;amp=m.reciprocal};
~phase=45.collect{pi};
signal=Signal.sineFill(1024,~level,~phase);

wt = signal.asWavetable;
~t.loadCollection(wt);
signal.plot;
		}.value;
{
var c,angle=0,c_real,c_imag,z;



~c = 5.collect{
 	c_real=exp(Complex(0,1)*angle.degrad).real;
	c_imag=exp(Complex(0,1)*angle.degrad).imag;
 	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
 	c=Complex(c_real,c_imag);
 };
z=Complex(0,0);

~j = (720*~time).collect{
	c=~c.[4];
	z=z.pow(2)+c;
	z.theta.round(0.000001);
}

}.value;
{
var phase1,phase2,angle1=0,angle2=0,m=2,pl1=0,pl2=0;

~posL=(720*~time).collect{

	phase1=exp(Complex(0,1)*(angle1.degrad*~j.[pl1])).theta;
	pl1=pl1=1;
	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	phase1=(Complex(sin(phase1.round(0.0001)*m),sin(phase1.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase1.round(0.0001)*m),cos(phase1.round(0.0001)*m)).rho).round(0.0001);

};

	~posR=(720*~time).collect{

	phase2=exp(Complex(0,1)*(angle2.degrad*~j.[pl2])).theta;
	pl2=pl2=1;
	angle2=(angle2+(360-(360/1.6180339887499))).wrap(0,360);
	phase2=(Complex(sin(phase2.round(0.0001)*m),sin(phase2.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase2.round(0.0001)*m),cos(phase2.round(0.0001)*m)).rho).round(0.0001).neg;
};

}.value;

{
var phase,angle=0,mag,phase1,angle1=0,mag1,m=2,pl1=0,pl2=0;

~magL = (720*~time).collect{

	phase=exp(Complex(0,1)*(angle.degrad*~j.[pl1])).theta;
	pl1=pl1=1;
	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
	mag=Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001);
	};

~magR = (720*~time).collect{

	phase1=exp(Complex(0,1)*(angle1.degrad*~j.[pl2])).theta;
	pl2=pl2=1;
	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	mag1=Complex(sin(phase1.round(0.0001)*m),sin(phase1.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase1.round(0.0001)*m),cos(phase1.round(0.0001)*m)).rho.round(0.0001);
	};
}.value;

{
var phase,angle=0,mag,phase1,angle1=0,mag1,m=1,pl1=0,pl2=0;

~magL1 = (720*~time).collect{

	phase=exp(Complex(0,1)*(angle.degrad*~j.[pl1])).theta;
	pl1=pl1=1;
	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
	mag=Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001);
	};

~magR1 = (720*~time).collect{

	phase1=exp(Complex(0,1)*(angle1.degrad*~j.[pl2])).theta;
	pl2=pl2=1;
	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	mag1=Complex(sin(phase1.round(0.0001)*m),sin(phase1.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase1.round(0.0001)*m),cos(phase1.round(0.0001)*m)).rho.round(0.0001);
	};
}.value;

{
var phase,angle=0,mag,phase1,angle1=0,mag1,m=2,pl1=0,pl2=0;

~magL2 = (720*~time).collect{

	phase=exp(Complex(0,1)*(angle.degrad*~j.[pl1])).theta;
	pl1=pl1=1;
	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
	mag=Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001);
	};

~magR2 = (720*~time).collect{

	phase1=exp(Complex(0,1)*(angle1.degrad*~j.[pl2])).theta;
	pl2=pl2=1;
	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	mag1=Complex(sin(phase1.round(0.0001)*m),sin(phase1.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase1.round(0.0001)*m),cos(phase1.round(0.0001)*m)).rho.round(0.0001);
	};
}.value;

{
var phase,angle=0,mag,phase1,angle1=0,mag1,m=3,pl1=0,pl2=0;

~magL3 = (720*~time).collect{

	phase=exp(Complex(0,1)*(angle.degrad*~j.[pl1])).theta;
	pl1=pl1=1;
	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
	mag=Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001);
	};

~magR3 = (720*~time).collect{

	phase1=exp(Complex(0,1)*(angle1.degrad*~j.[pl2])).theta;
	pl2=pl2=1;
	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	mag1=Complex(sin(phase1.round(0.0001)*m),sin(phase1.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase1.round(0.0001)*m),cos(phase1.round(0.0001)*m)).rho.round(0.0001);
	};
}.value;

{
var phase,angle=0,mag,phase1,angle1=0,mag1,m=4,pl1=0,pl2=0;

~magL4 = (720*~time).collect{

	phase=exp(Complex(0,1)*(angle.degrad*~j.[pl1])).theta;
	pl1=pl1=1;
	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
	mag=Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001);
	};

~magR4 = (720*~time).collect{

	phase1=exp(Complex(0,1)*(angle1.degrad*~j.[pl2])).theta;
	pl2=pl2=1;
	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	mag1=Complex(sin(phase1.round(0.0001)*m),sin(phase1.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase1.round(0.0001)*m),cos(phase1.round(0.0001)*m)).rho.round(0.0001);
	};
}.value;

{
var phase,angle=0,mag,phase1,angle1=0,mag1,m=5,pl1=0,pl2=0;

~magL5 = (720*~time).collect{

	phase=exp(Complex(0,1)*(angle.degrad*~j.[pl1])).theta;
	pl1=pl1=1;
	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
	mag=Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001);
	};

~magR5 = (720*~time).collect{

	phase1=exp(Complex(0,1)*(angle1.degrad*~j.[pl2])).theta;
	pl2=pl2=1;
	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	mag1=Complex(sin(phase1.round(0.0001)*m),sin(phase1.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase1.round(0.0001)*m),cos(phase1.round(0.0001)*m)).rho.round(0.0001);
	};
}.value;

{
var phase,angle=0,mag,phase1,angle1=0,mag1,m=6,pl1=0,pl2=0;

~magL6 = (720*~time).collect{

	phase=exp(Complex(0,1)*(angle.degrad*~j.[pl1])).theta;
	pl1=pl1=1;
	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
	mag=Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001);
	};

~magR6 = (720*~time).collect{

	phase1=exp(Complex(0,1)*(angle1.degrad*~j.[pl2])).theta;
	pl2=pl2=1;
	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	mag1=Complex(sin(phase1.round(0.0001)*m),sin(phase1.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase1.round(0.0001)*m),cos(phase1.round(0.0001)*m)).rho.round(0.0001);
	};
}.value;

(
~magR=~magR.normalize(0,1);
~magL=~magL.normalize(0,1);
~magR1=~magR1.normalize(0,1);
~magL1=~magL1.normalize(0,1);
~magR2=~magR2.normalize(0,1);
~magL2=~magL2.normalize(0,1);
~magR3=~magR3.normalize(0,1);
~magL3=~magL3.normalize(0,1);
~magR4=~magR4.normalize(0,1);
~magL4=~magL4.normalize(0,1);
~magR5=~magR5.normalize(0,1);
~magL5=~magL5.normalize(0,1);
~magR6=~magR6.normalize(0,1);
~magL6=~magL6.normalize(0,1);
);

	(	~magx=[~magR1.round(0.0000000000001),~magR2.round(0.0000000000001),~magR3.round(0.0000000000001),~magR4.round(0.0000000000001),~magR5.round(0.0000000000001),~magR6.round(0.0000000000001)];
	~magy=[~magL1.round(0.0000000000001),~magL2.round(0.0000000000001),~magL3.round(0.0000000000001),~magL4.round(0.0000000000001),~magL5.round(0.0000000000001),~magL6.round(0.0000000000001)];
);

	);


////////////////////osc

(
SynthDef.new(\synhtone,
{
arg speed=1,octave=4,gate=0,rot_angle=0,mult=24,n=0;
var signal1,signal2,env,pl=0,m=1,freq1,freq2,amp1,amp2,amp3;
var pos1,pos2,phase1,phase2,ph1,ph2,mag,fundamental=32,freq;
var chainx,chainy,amp,rq=1,cutt,f,pl1=0,pl2=0,bank1=2,bank2=4;
var n1,n2,n3;
var sig1,sig2,sig3,sig4,sig5,sig6;
var v,i,j,k,q;
var pitch1, pitch2, pitch3,pitch,ton;
var xyz,xyz_array,axis;

	var wrappedOut1 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut2 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut3 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut4 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut5 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut6 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!

				ton=2.pow(n/12);

		freq=fundamental*octave*speed.reciprocal;
				env=EnvGen.ar(Env.perc(0.02,4),doneAction:2);

bank1.do{
bank2.do{

		pos1=~posL.[pl1]/(2.sqrt);
		pos2=~posR.[pl1]/(2.sqrt);
		//phase1=~phase1.[pl];
		//phase2=~phase2.[pl];
				mag=Complex(~magx.[pl2].[pl1],~magy.[pl2].[pl1]);

		//ph1=SinOsc.ar(mag.reciprocal,phase1,mag);
		//ph2=SinOsc.ar(mag.reciprocal,phase2,mag);
		mag=mag.round(0.0000000001);

						xyz=Spherical(1,mag.theta.wrap(pi.neg,pi),mag.theta.wrap((pi/2).neg,(pi/2)));
		xyz_array=[xyz.x.round(0.000001),xyz.y.round(0.000001),xyz.z.round(0.000001)];

	v=Quaternion(0,0,0,1);
	i=Quaternion(0, xyz_array.[0], 0, 0); j=Quaternion(0, 0, xyz_array.[1], 0); k=Quaternion(0, 0, 0, xyz_array.[2]);

	axis=(i+j+k);

q=((axis*exp(Complex(0,1)*rot_angle.degrad).imag)+exp(Complex(0,1)*rot_angle.degrad).real);
v=q*v*q.conjugate;

	pitch=Cartesian(v.b,v.c,v.d);

	n1=(pitch.x*mult).round(1); n2=(pitch.y*mult).round(1); n3=(pitch.z*mult).round(1);

		pitch1=2.pow(n1/12);
		pitch2=2.pow(n2/12);
		pitch3=2.pow(n3/12);



		ph1=exp(Complex(0,1)*(2pi*mag.real).mod(2pi)).theta;
		ph2=exp(Complex(0,1)*(2pi*mag.imag).mod(2pi)).theta;

		amp1=m.reciprocal*octave.reciprocal*speed*pitch1.reciprocal*ton.reciprocal;
		amp2=m.reciprocal*octave.reciprocal*speed*pitch2.reciprocal*ton.reciprocal;
		amp3=m.reciprocal*octave.reciprocal*speed*pitch3.reciprocal*ton.reciprocal;

		f=freq*m*ton;

		cutt=freq*m*ton;

				sig1=LPF.ar(Osc.ar(~t.bufnum,f*pitch1,ph1,amp1),cutt*pitch1,env);
				sig2=LPF.ar(Osc.ar(~t.bufnum,f*pitch2,ph1,amp2),cutt*pitch1,env);
				sig3=LPF.ar(Osc.ar(~t.bufnum,f*pitch3,ph1,amp3),cutt*pitch3,env);
				sig4=LPF.ar(Osc.ar(~t.bufnum,f*pitch1,ph2,amp1),cutt*pitch1,env);
				sig5=LPF.ar(Osc.ar(~t.bufnum,f*pitch2,ph2,amp2),cutt*pitch2,env);
				sig6=LPF.ar(Osc.ar(~t.bufnum,f*pitch3,ph2,amp3),cutt*pitch3,env);
	m=m+1;

		//wrappedOut1.value(out,Pan2.ar(LeakDC.ar(sig1),pos1,mag.rho/(2.sqrt)));
		//wrappedOut2.value(out,Pan2.ar(LeakDC.ar(sig2),pos1,mag.rho/(2.sqrt)));
		//wrappedOut3.value(out,Pan2.ar(LeakDC.ar(sig3),pos1,mag.rho/(2.sqrt)));
		//wrappedOut4.value(out,Pan2.ar(LeakDC.ar(sig4),pos2,mag.rho/(2.sqrt)));
		//wrappedOut5.value(out,Pan2.ar(LeakDC.ar(sig5),pos2,mag.rho/(2.sqrt)));
		//wrappedOut6.value(out,Pan2.ar(LeakDC.ar(sig6),pos2,mag.rho/(2.sqrt)));
						Out.ar(0,Pan2.ar(LeakDC.ar(sig1),pos1));
						Out.ar(0,Pan2.ar(LeakDC.ar(sig2),pos1));
						Out.ar(0,Pan2.ar(LeakDC.ar(sig3),pos1));
						Out.ar(0,Pan2.ar(LeakDC.ar(sig4),pos2));
						Out.ar(0,Pan2.ar(LeakDC.ar(sig5),pos2));
						Out.ar(0,Pan2.ar(LeakDC.ar(sig6),pos2));

pl1=pl1+1;
			};
					pl2=pl2+1;
		m=m+1;
}
}).add;
);
///midi
(
MIDIClient.init;
MIDIIn.connectAll;
~angle=0;

MIDIdef.noteOn(\note, { |val, num, chan, src|
	[val, num, chan, src].postln;
	if(num < 72) {
		num = num - 1
	};
	~a=Synth(\synhtone, [n: num - 72, rot_angle: ~angle.linlin(0,127,360.neg,360).round(1), out: [(0..1).rotate(2.rand)]]);

}, noteNum: (36..96));
	(
MIDIdef.cc(\midi1,{ |val, num, chan, src|
		var angle;
	//[val, num, chan, src].postln;
				~angle=val;
				angle=val.linlin(0,127,360.neg,360).round(1);
		angle.postln;
				~a.set(\rot_angle,angle);
},20);

	);
)
}
)