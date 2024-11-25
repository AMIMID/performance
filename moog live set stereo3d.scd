(
s.options.numWireBufs = 1024*16;
s.options.numOutputBusChannels=2;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(120/120);
s.options.memSize = 8192*32;
//s.options.blockSize = 64/4;
s.options.maxNodes = 1024 * 64;
s.waitForBoot
)



(
~time=8;
////////fractal
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

)


////////////////////osc

(
SynthDef.new(\ostereo,
{
arg pl1=1;
var signal1,signal2,pl=0,in1,in2,chainx,chainxx,chainy,chainyy;
var pos1,pos2,ph1,ph2,mg,b=0;
var amp,bank=128,frames=1024;

	in1 = SoundIn.ar(0);
		in2 = SoundIn.ar(0);

	chainx = FFT(LocalBuf(frames), in1);
		chainy = FFT(LocalBuf(frames), in2);


		bank.do{

		pos1=~posL.[pl]/(2.sqrt);
			pos2=~posR.[pl]/(2.sqrt);

			//mg=Complex(Select.kr(pl1,~magL),Select.kr(pl1,~magR));
				mg=Complex(~magL.[pl],~magR.[pl]);

		//ph1=SinOsc.ar(mag.reciprocal,phase1,mag);
		//ph2=SinOsc.ar(mag.reciprocal,phase2,mag);
		mg=mg.round(0.0000000001);


		ph1=exp(Complex(0,1)*(Complex(mg.real,0).theta)).theta;
		ph2=exp(Complex(0,1)*(Complex(0,mg.imag).theta)).theta;


chainxx = chainx.pvcollect(frames, {|mag, phase, index| [mag*mg.rho/(2.sqrt), exp(Complex(0,1)*(phase+ph1)).theta]; }, frombin: b, tobin: b, zeroothers: 1);

chainyy = chainy.pvcollect(frames, {|mag, phase, index| [mag*mg.rho/(2.sqrt), exp(Complex(0,1)*(phase+ph2)).theta]; }, frombin: b, tobin: b, zeroothers: 1);

		signal1=Pan2.ar(IFFT(chainxx),pos1);
			signal2=Pan2.ar(IFFT(chainyy),pos2);
b=b+1;
pl=pl+1;
		Out.ar(0,signal1);
			Out.ar(0,signal2);

}
}).add;
)

~synth1=Synth(\ostereo);
(
MIDIClient.init;
MIDIIn.connectAll;

	(
MIDIdef.cc(\midi1,{ |val, num, chan, src|
		var r;
	//[val, num, chan, src].postln;
	r=val.linlin(0,127,0,1440);
		r.postln;
		~synth1.set(\pl1,r);
},25);
	);


)
