(
s.options.numWireBufs = 1024*4;
s.options.numOutputBusChannels=8;
s.options.numInputBusChannels=2;
TempoClock.default.tempo_(1);
s.options.memSize = 8192*64;
s.options.blockSize = 64;
s.options.maxNodes = 1024 * 16;
s.options.sampleRate= 44100;
s.waitForBoot
)

/////wavetables
(
(
~t= Buffer.alloc(s,2048);


{
var signal,wt,m=0,amp;

~level=90.round(1).collect{m=m+1;amp=m.reciprocal};
~phase=90.collect{pi};
signal=Signal.sineFill(1024,~level,~phase);

wt = signal.asWavetable;
~t.loadCollection(wt);
signal.plot;
}.value;
);

////speaker setup
/////octahedron
(
	~a = VBAPSpeakerArray.new(3, [[0, 0], [90, 0], [180, 0], [90.neg, 0],[0,90],[0,90.neg]]);
	~b = Buffer.loadCollection(s, ~a.getSetsAndMatrices);
);

//////////arrays
(
/////////tetrahedron
/*(
// 3D
~a = VBAPSpeakerArray.new(3, [[0, 45], [180, 45], [90, 45.neg], [90.neg, 45.neg]]);
~b = Buffer.loadCollection(s, ~a.getSetsAndMatrices);
);*/
		~time=8;
{
var c,cc,angle=0,c_real,c_imag,z;
var c1,cc1,angle1=0,c_real1,c_imag1,z1;

~c = 5.collect{
 	c_real=exp(Complex(0,1)*angle.degrad).real;
	c_imag=exp(Complex(0,1)*angle.degrad).imag;
 	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
 	c=Complex(c_real,c_imag);
 };
z=Complex(0,0);

~j = (2*720*~time).collect{
	cc=~c.[4];
	z=z.pow(2)+cc;
	z.theta.round(0.0000000000001);

};

~k = 5.collect{
 	c_real1=exp(Complex(0,1)*angle1.degrad).real;
	c_imag1=exp(Complex(0,1)*angle1.degrad).imag;
 	angle1=(angle1+45).wrap(0,360);
 	c1=Complex(c_real,c_imag);
 };
z1=Complex(0,0);

~h = (2*720*~time).collect{
	cc1=~k.[4].round(0.0000000000001);
	z1=z1.pow(2)+cc1;
	z1.theta.round(0.0000000000001);

}

		}.value;
//////////////////////////////////////////////////basis
{
var  sph1,sph2,sph3,sph4,sph5,m_x=3,m_y=3,m_z=3;
var az1=0,el1=0,az2=0,el2=0,az3=0,el3=0,mag,mag_x,mag_y,mag_z;
var az4=0,el4=0,az5=0,el5=0,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;

~az = (720*~time).collect{
	pl1=pl1+1;

		az1=(az1+(1)).wrap(180.neg,180);

	el1=(el1+(360-(360/1.6180339887499))).wrap(90.neg,90);

		sph1=Spherical(1,(az1.degrad*~h.[pl1]).wrap(pi.neg,pi),(el1.degrad*~j.[pl1]).wrap((pi/2).neg,(pi/2))).theta.round(0.00001);

	};

~el = (720*~time).collect{
	pl2=pl2+1;

		az2=(az2+(1)).wrap(180.neg,180);

	el2=(el2+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph2=Spherical(1,(az2.degrad*~h.[pl2]).wrap(pi.neg,pi),(el2.degrad*~j.[pl2]).wrap((pi/2).neg,(pi/2))).phi.round(0.00001);

	};

~magx = (720*~time).collect{
pl3=pl3+1;
	az3=(az3+(1)).wrap(180.neg,180);

	el3=(el3+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph3=Spherical(1,(az3.degrad*~h.[pl3]).wrap(pi.neg,pi),(el3.degrad*~j.[pl3]).wrap((pi/2).neg,(pi/2)));

			//mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;

////for in-between harmonics multiply sin(phi) after cos, when m is 2 then harm 3/2 is formed in oder 3, when m is 3 harm 4/3 is formed in oder 4 and when m is 3 for theta and 2 for phi harm 4/2 is formed for order4//////same for y axis

		 mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),
		 	cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*
		 	Complex(sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2))),sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/
			2).neg,(pi/2)))).rho*
		 Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;

};

~magy = (720*~time).collect{
pl4=pl4+1;
	az4=(az4+(1)).wrap(180.neg,180);

	el4=(el4+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph4=Spherical(1,(az3.degrad*~h.[pl3]).wrap(pi.neg,pi),(el4.degrad*~j.[pl4]).wrap((pi/2).neg,(pi/2)));

	mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),
		sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
		Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/
		2)))).rho)*sph4.rho;
//		mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
//Complex(sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2))),sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).rho*
//Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph4.rho;
};

~magz = (720*~time).collect{
pl5=pl5+1;
	az5=(az5+(1)).wrap(180.neg,180);

	el5=(el5+(360-(360/1.6180339887499))).wrap(90.neg,90);

		sph5=Spherical(1,((az5.degrad*~h.[pl5]).wrap(pi.neg,pi)).wrap(pi.neg,pi),((el5.degrad*~j.[pl5]).wrap((pi/2).neg,(pi/2))).wrap((pi/2).neg,(pi/2)));

if(
m_z.even,
mag_z=Complex(cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho,
mag_z=Complex(sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho
	);
////z axis   ambi..  sin for odd numbers, cos for even
	};
}.value;

	({
		var angle=0;
		~angle=(720*~time).collect{
		angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
		}
		}.value;
	~angle=~angle/2;
	);

);

(
SynthDef.new(\o_in, {
    var in, chainx,b=0,az1=0,az2=0,el1=0,el2=0,rpr=1;
	var chainxx,pl=0,amp1,phase;
	var angle1=0,angle2=720;
	var phase1,bank1,frames=1024;


	in =SoundIn.ar(0);

	chainx = FFT(LocalBuf(frames), in);

	bank1=512;

	bank1.do{

		az1=~az.[pl];
		el1=~el.[pl];
amp1=Cartesian(~magx[pl],~magy.[pl],~magz.[pl]);

		phase1=Polar(amp1.phi.bilin(0,90.degrad.neg,90.degrad,1,0,0),amp1.theta.linlin(pi.neg,pi,2pi.neg,2pi));


		chainxx = chainx.pvcollect(frames, {|mag, phase, index| [mag*(amp1.rho/(2.sqrt)), exp(Complex(0,1)*(phase+~angle.[pl].degrad)).theta]; }, frombin: b, tobin: b, zeroothers: 1);

	b=b+1;

			Out.ar(0,VBAP.ar(6,IFFT(chainxx)*0.5,~b.bufnum,
			Osc.ar(~t,MouseX.kr(0.01,20),phase:az1.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
			Osc.ar(~t,MouseX.kr(0.01,20),phase:el1.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)));


	//	Out.ar(0,VBAP.ar(6,IFFT(chainxx),~b.bufnum,az1.raddeg,el1.raddeg));

pl=pl+1;

		};
}).add;
)
)

(
Synth(\o_in);
//{Out.ar(6,LFPulse.ar(MouseX.kr(0.01,20),width:0.01,mul:1))}.play;
{Out.ar(6,SinOsc.ar(MouseX.kr(0.01,20),mul:1))}.play;
)

s.record(numChannels:3);
s.record(numChannels:4);