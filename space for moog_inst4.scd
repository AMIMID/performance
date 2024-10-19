(
s.options.numWireBufs = 1024*4;
s.options.numOutputBusChannels=4;
s.options.numInputBusChannels=2;
TempoClock.default.tempo_(0.5);
s.options.memSize = 8192*8;
s.options.blockSize = 64/1;
s.options.maxNodes = 1024 * 16;
s.options.sampleRate= 48000;
s.waitForBoot
)

Buffer.freeAll


//////////phase shift
~c1 = Buffer.readChannel(s,,channels:0 );
(
(
SynthDef("help-phaseShift", { arg out=0;
        var in, chain;
        in = PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1), loop: 0);
        chain = FFT(LocalBuf(2048), in);
        chain = PV_PhaseShift(chain,90.degrad);
        Out.ar(out, 0.1 * IFFT(chain));
}).play(s);
);
)


////////////////buffers
(
~c1 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Dokuments/PROJECT  FILES/freesound_org recordings/217236__roofusj__steady-rain-in-the-city.wav",channels:0 );
~c2 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Dokuments/PROJECT  FILES/freesound_org recordings/217236__roofusj__steady-rain-in-the-city.wav",channels:1 );
~c3 = Buffer.readChannel(s,,channels:0 );
~c4 = Buffer.readChannel(s,,channels:1 );
~c5 = Buffer.readChannel(s,,channels:0 );
~c6 = Buffer.readChannel(s,,channels:1 );
)

/////wavetables
Buffer.freeAll

~t= Buffer.alloc(s,2048);


(
var signal,wt,m=0,amp;

~level=90.round(1).collect{m=m+1;amp=m.reciprocal};
~phase=90.collect{pi};
signal=Signal.sineFill(1024,~level,~phase);

wt = signal.asWavetable;
~t.loadCollection(wt);
signal.plot;
)

////speaker setup
(
// 3D///cube
~a = VBAPSpeakerArray.new(3, [[45, 45], [135, 45], [135.neg, 45], [45.neg, 45],[45, 45.neg], [135, 45.neg], [135.neg, 45.neg], [45.neg, 45.neg]]);
//0 up fl, 1 up bl, 2 up br, 3 up fr, 4 down fl, 5 down bl, 6 down br, 7 down fr
~b = Buffer.loadCollection(s, ~a.getSetsAndMatrices);
///furhter on speaker setup can be geodesic octahedron 2nd order torus with 16 channels, and Rhombic triacontahedron with 32 vertices as 32 speaker channels
)

/////////tetrahedron
(
// 3D
~a = VBAPSpeakerArray.new(3, [[0, 45], [180, 45], [90, 45.neg], [90.neg, 45.neg]]);
~b = Buffer.loadCollection(s, ~a.getSetsAndMatrices);
)

(
// 3D random
~a = VBAPSpeakerArray.new(3, [[180.rand2, 90.rand2], [180.rand2, 90.rand2], [180.rand2, 90.rand2], [180.rand2, 90.rand2]]);
~b = Buffer.loadCollection(s, ~a.getSetsAndMatrices);
)

//////////arrays
~time=8;
///1= about 15:30 min in normal+reverse sequence
///fractal
(
var c,angle=0,c_real,c_imag,z;



~c = 5.collect{
 	c_real=exp(Complex(0,1)*angle.degrad).real;
	c_imag=exp(Complex(0,1)*angle.degrad).imag;
 	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
 	c=Complex(c_real,c_imag);
 };
z=Complex(0,0);

~j = (180*~time).collect{
	c=~c.[4];
	z=z.pow(2)+c;
	z.theta.round(0.000001);

}

)

(
var c,angle=0,c_real,c_imag,z;



~k = 5.collect{
 	c_real=exp(Complex(0,1)*angle.degrad).real;
	c_imag=exp(Complex(0,1)*angle.degrad).imag;
 	angle=(angle+45).wrap(0,360);
 	c=Complex(c_real,c_imag);
 };
z=Complex(0,0);

~h = (180*~time).collect{
	c=~k.[4].round(0.00001);
	z=z.pow(2)+c;
	z.theta.round(0.000001);

}

)
//////////////////////basis

(
var  sph1,sph2,m_x=3,m_y=2,m_z=1,az1=0,el1=0,az2=0,el2=0,mag_x,mag_y,mag_z;
var azx=0,elx=0,azy=0,ely=0,azz=0,elz=0,sphx,sphy,sphz,rad=1;
var pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;

~az = (90*~time).collect{
pl1=pl1+1;
		az1=(az1+(1)).wrap(180.neg,180);

	el1=(el1+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph1=Spherical(1,az1.degrad*~h.[pl1],el1.degrad*~j.[pl1]).theta.round(0.00001);

	};

~el = (90*~time).collect{
pl2=pl2+1;
		az2=(az2+(1)).wrap(90.neg,90);

	el2=(el2+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph2=Spherical(1,az2.degrad*~h.[pl2],el2.degrad*~j.[pl2]).phi.round(0.00001);

	};

~magx = (90*~time).collect{
pl3=pl3+1;

	azx=(azx+(1)).wrap(180.neg,180);

	elx=(elx+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sphx=Spherical(rad,azx.degrad*~h.[pl3],elx.degrad*~j.[pl3]);


/*mag_x=(Complex(cos((sphx.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),cos((sphx.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*
	Complex(cos((sphx.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sphx.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sphx.rho;
	mag_x.round(0.00001);*/

	mag_x=(Complex(cos((sphx.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),cos((sphx.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*
Complex(sin((sphx.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2))),sin((sphx.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2)))).rho*
Complex(cos((sphx.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sphx.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sphx.rho;


	};

~magy = (90*~time).collect{
pl4=pl4+1;
	azy=(azy+(1)).wrap(180.neg,180);

	ely=(ely+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sphy=Spherical(rad,azy.degrad*~h.[pl4],ely.degrad*~j.[pl4]);

	mag_y=(Complex(sin((sphy.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),sin((sphy.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
		Complex(cos((sphy.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sphy.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sphy.rho;
mag_y.round(0.00001);
//	mag_y=(Complex(sin((sphy.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),sin((sphy.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
//Complex(sin((sphy.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2))),sin((sphy.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).rho*
//Complex(cos((sphy.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sphy.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sphy.rho;

	};

~magz = (90*~time).collect{
pl5=pl5+1;
	azz=(azz+(1)).wrap(180.neg,180);

	elz=(elz+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sphz=Spherical(rad,azz.degrad*~h.[pl5],elz.degrad*~j.[pl5]);

if(
m_z.even,
mag_z=Complex(cos((sphz.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),cos((sphz.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sphz.rho,
mag_z=Complex(sin((sphz.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),sin((sphz.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sphz.rho
	);
	mag_z.round(0.00001);
	};

)

(
var  sph1,sph2,m_x=1,m_y=1,m_z=1,az1=0,el1=0,az2=0,el2=0,mag_x,mag_y,mag_z;
var azx=0,elx=0,azy=0,ely=0,azz=0,elz=0,sphx,sphy,sphz,rad=1;
var pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;


~magx1 = (90*~time).collect{
pl3=pl3+1;
	azx=(azx+(1)).wrap(180.neg,180);

	elx=(elx+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sphx=Spherical(rad,azx.degrad*~h.[pl3],elx.degrad*~j.[pl3]);

	mag_x=(Complex(cos((sphx.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),cos((sphx.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*
	Complex(cos((sphx.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sphx.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sphx.rho;
	mag_x.round(0.00001);

	/*mag_x=(Complex(cos((sphx.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),cos((sphx.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*
Complex(sin((sphx.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2))),sin((sphx.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2)))).rho*
Complex(cos((sphx.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sphx.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sphx.rho;
*/
	};

~magy1 = (90*~time).collect{
pl4=pl4+1;
	azy=(azy+(1)).wrap(180.neg,180);

	ely=(ely+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sphy=Spherical(rad,azy.degrad*~h.[pl4],ely.degrad*~j.[pl4]);

	mag_y=(Complex(sin((sphy.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),sin((sphy.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
		Complex(cos((sphy.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sphy.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sphy.rho;
mag_y.round(0.00001);
//	mag_y=(Complex(sin((sphy.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),sin((sphy.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
//Complex(sin((sphy.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2))),sin((sphy.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).rho*
//Complex(cos((sphy.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sphy.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sphy.rho;

	};

~magz1 = (90*~time).collect{
pl5=pl5+1;
	azz=(azz+(1)).wrap(180.neg,180);

	elz=(elz+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sphz=Spherical(rad,azz.degrad*~h.[pl5],elz.degrad*~j.[pl5]);

if(
m_z.even,
mag_z=Complex(cos((sphz.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),cos((sphz.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sphz.rho,
mag_z=Complex(sin((sphz.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),sin((sphz.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sphz.rho
	);
	mag_z.round(0.00001);
	};

)

(
var  sph1,sph2,m_x=2,m_y=2,m_z=2,az1=0,el1=0,az2=0,el2=0,mag_x,mag_y,mag_z;
var azx=0,elx=0,azy=0,ely=0,azz=0,elz=0,sphx,sphy,sphz,rad=1;
var pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;


~magx2 = (90*~time).collect{
pl3=pl3+1;
	azx=(azx+(1)).wrap(180.neg,180);

	elx=(elx+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sphx=Spherical(rad,azx.degrad*~h.[pl3],elx.degrad*~j.[pl3]);

mag_x=(Complex(cos((sphx.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),cos((sphx.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*
	Complex(cos((sphx.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sphx.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sphx.rho;
	mag_x.round(0.00001);

	/*mag_x=(Complex(cos((sphx.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),cos((sphx.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*
Complex(sin((sphx.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2))),sin((sphx.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2)))).rho*
Complex(cos((sphx.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sphx.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sphx.rho;
*/

	};

~magy2 = (90*~time).collect{
pl4=pl4+1;
	azy=(azy+(1)).wrap(180.neg,180);

	ely=(ely+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sphy=Spherical(rad,azy.degrad*~h.[pl4],ely.degrad*~j.[pl4]);

	mag_y=(Complex(sin((sphy.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),sin((sphy.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
		Complex(cos((sphy.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sphy.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sphy.rho;
mag_y.round(0.00001);
//	mag_y=(Complex(sin((sphy.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),sin((sphy.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
//Complex(sin((sphy.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2))),sin((sphy.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).rho*
//Complex(cos((sphy.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sphy.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sphy.rho;

	};

~magz2 = (90*~time).collect{
pl5=pl5+1;
	azz=(azz+(1)).wrap(180.neg,180);

	elz=(elz+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sphz=Spherical(rad,azz.degrad*~h.[pl5],elz.degrad*~j.[pl5]);

if(
m_z.even,
mag_z=Complex(cos((sphz.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),cos((sphz.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sphz.rho,
mag_z=Complex(sin((sphz.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),sin((sphz.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sphz.rho
	);
	mag_z.round(0.00001);
	};

)

(
var  sph1,sph2,m_x=3,m_y=3,m_z=3,az1=0,el1=0,az2=0,el2=0,mag_x,mag_y,mag_z;
var azx=0,elx=0,azy=0,ely=0,azz=0,elz=0,sphx,sphy,sphz,rad=1;
var pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;


~magx3 = (90*~time).collect{
pl3=pl3+1;
	azx=(azx+(1)).wrap(180.neg,180);

	elx=(elx+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sphx=Spherical(rad,azx.degrad*~h.[pl3],elx.degrad*~j.[pl3]);

mag_x=(Complex(cos((sphx.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),cos((sphx.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*
	Complex(cos((sphx.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sphx.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sphx.rho;
	mag_x.round(0.00001);

	/*mag_x=(Complex(cos((sphx.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),cos((sphx.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*
Complex(sin((sphx.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2))),sin((sphx.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2)))).rho*
Complex(cos((sphx.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sphx.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sphx.rho;
*/

	};

~magy3 = (90*~time).collect{
pl4=pl4+1;
	azy=(azy+(1)).wrap(180.neg,180);

	ely=(ely+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sphy=Spherical(rad,azy.degrad*~h.[pl4],ely.degrad*~j.[pl4]);

	mag_y=(Complex(sin((sphy.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),sin((sphy.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
		Complex(cos((sphy.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sphy.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sphy.rho;
mag_y.round(0.00001);
//	mag_y=(Complex(sin((sphy.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),sin((sphy.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
//Complex(sin((sphy.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2))),sin((sphy.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).rho*
//Complex(cos((sphy.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sphy.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sphy.rho;

	};

~magz3 = (90*~time).collect{
pl5=pl5+1;
	azz=(azz+(1)).wrap(180.neg,180);

	elz=(elz+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sphz=Spherical(rad,azz.degrad*~h.[pl5],elz.degrad*~j.[pl5]);

if(
m_z.even,
mag_z=Complex(cos((sphz.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),cos((sphz.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sphz.rho,
mag_z=Complex(sin((sphz.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),sin((sphz.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sphz.rho
	);
	mag_z.round(0.00001);
	};

)

(
var  sph1,sph2,m_x=4,m_y=4,m_z=4,az1=0,el1=0,az2=0,el2=0,mag_x,mag_y,mag_z;
var azx=0,elx=0,azy=0,ely=0,azz=0,elz=0,sphx,sphy,sphz,rad=1;
var pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;


~magx4 = (90*~time).collect{
pl3=pl3+1;
	azx=(azx+(1)).wrap(180.neg,180);

	elx=(elx+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sphx=Spherical(rad,azx.degrad*~h.[pl3],elx.degrad*~j.[pl3]);

mag_x=(Complex(cos((sphx.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),cos((sphx.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*
	Complex(cos((sphx.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sphx.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sphx.rho;
	mag_x.round(0.00001);

	/*mag_x=(Complex(cos((sphx.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),cos((sphx.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*
Complex(sin((sphx.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2))),sin((sphx.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2)))).rho*
Complex(cos((sphx.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sphx.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sphx.rho;
*/

	};

~magy4 = (90*~time).collect{
pl4=pl4+1;
	azy=(azy+(1)).wrap(180.neg,180);

	ely=(ely+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sphy=Spherical(rad,azy.degrad*~h.[pl4],ely.degrad*~j.[pl4]);

	mag_y=(Complex(sin((sphy.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),sin((sphy.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
		Complex(cos((sphy.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sphy.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sphy.rho;
mag_y.round(0.00001);
//	mag_y=(Complex(sin((sphy.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),sin((sphy.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
//Complex(sin((sphy.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2))),sin((sphy.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).rho*
//Complex(cos((sphy.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sphy.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sphy.rho;

	};

~magz4 = (90*~time).collect{
pl5=pl5+1;
	azz=(azz+(1)).wrap(180.neg,180);

	elz=(elz+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sphz=Spherical(rad,azz.degrad*~h.[pl5],elz.degrad*~j.[pl5]);

if(
m_z.even,
mag_z=Complex(cos((sphz.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),cos((sphz.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sphz.rho,
mag_z=Complex(sin((sphz.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),sin((sphz.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sphz.rho
	);
	mag_z.round(0.00001);
	};

)

(
var  sph1,sph2,m_x=5,m_y=5,m_z=5,az1=0,el1=0,az2=0,el2=0,mag_x,mag_y,mag_z;
var azx=0,elx=0,azy=0,ely=0,azz=0,elz=0,sphx,sphy,sphz,rad=1;
var pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;


~magx5 = (90*~time).collect{
pl3=pl3+1;
	azx=(azx+(1)).wrap(180.neg,180);

	elx=(elx+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sphx=Spherical(rad,azx.degrad*~h.[pl3],elx.degrad*~j.[pl3]);

mag_x=(Complex(cos((sphx.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),cos((sphx.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*
	Complex(cos((sphx.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sphx.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sphx.rho;
	mag_x.round(0.00001);

	/*mag_x=(Complex(cos((sphx.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),cos((sphx.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*
Complex(sin((sphx.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2))),sin((sphx.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2)))).rho*
Complex(cos((sphx.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sphx.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sphx.rho;
*/

	};

~magy5 = (90*~time).collect{
pl4=pl4+1;
	azy=(azy+(1)).wrap(180.neg,180);

	ely=(ely+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sphy=Spherical(rad,azy.degrad*~h.[pl4],ely.degrad*~j.[pl4]);

	mag_y=(Complex(sin((sphy.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),sin((sphy.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
		Complex(cos((sphy.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sphy.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sphy.rho;
mag_y.round(0.00001);
//	mag_y=(Complex(sin((sphy.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),sin((sphy.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
//Complex(sin((sphy.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2))),sin((sphy.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).rho*
//Complex(cos((sphy.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sphy.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sphy.rho;

	};

~magz5 = (90*~time).collect{
pl5=pl5+1;
	azz=(azz+(1)).wrap(180.neg,180);

	elz=(elz+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sphz=Spherical(rad,azz.degrad*~h.[pl5],elz.degrad*~j.[pl5]);

if(
m_z.even,
mag_z=Complex(cos((sphz.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),cos((sphz.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sphz.rho,
mag_z=Complex(sin((sphz.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),sin((sphz.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sphz.rho
	);
	mag_z.round(0.00001);
	};

)


////////////////////////az///randomizer-difuser

(
var pl1=0,az1,el1,sph1,rot1,i1,j1,k1,q1,raz1,rel1;
var pl2=0,az2,el2,sph2,rot2,i2,j2,k2,q2,raz2,rel2;
var pl3=0,az3,el3,sph3,rot3,i3,j3,k3,q3,raz3,rel3;
var r1=[0,0,1],r2=[1,0,0],r3=[0,1,0];
var v1=Quaternion(0,r1.[0],r1.[1],r1.[2]),v2=Quaternion(0,r2.[0],r2.[1],r2.[2]),v3=Quaternion(0,r3.[0],r3.[1],r3.[2]);
var angle=(360-(360/1.6180339887499));
var harm1,harn2,harm3;

~az_x=(90*~time).collect{

	az1=~az.[pl1];el1=~el.[pl1];
	pl1=pl1+1;
sph1=Spherical(1,az1,el1).asCartesian;

	rot1=[sph1.x,sph1.y,sph1.z];

	i1=Quaternion(0, rot1.[0], 0, 0);
	j1=Quaternion(0, 0, rot1.[1], 0);
	k1=Quaternion(0, 0, 0, rot1.[2]);

q1=(cos(angle.degrad)+(sin(angle.degrad)*(i1+j1+k1)));
v1=q1*v1*q1.conjugate;

raz1=Cartesian(v1.b.round(0.0001),v1.c.round(0.0001),v1.d.round(0.0001)).theta.round(0.00001);
};

~az_y=(90*~time).collect{

	az2=~az.[pl2];el2=~el.[pl2];
	pl2=pl2+1;
sph2=Spherical(1,az2,el2).asCartesian;

	rot2=[sph2.x,sph2.y,sph2.z];

	i2=Quaternion(0, rot2.[0], 0, 0);
	j2=Quaternion(0, 0, rot2.[1], 0);
	k2=Quaternion(0, 0, 0, rot2.[2]);

q2=(cos(angle.degrad)+(sin(angle.degrad)*(i2+j2+k2)));
v2=q2*v2*q2.conjugate;

raz2=Cartesian(v2.b.round(0.0001),v2.c.round(0.0001),v2.d.round(0.0001)).theta.round(0.00001);
};

~az_z=(90*~time).collect{

	az3=~az.[pl3];el3=~el.[pl3];
	pl3=pl3+1;
sph3=Spherical(1,az3,el3).asCartesian;

	rot3=[sph3.x,sph3.y,sph3.z];

	i3=Quaternion(0, rot3.[0], 0, 0);
	j3=Quaternion(0, 0, rot3.[1], 0);
	k3=Quaternion(0, 0, 0, rot3.[2]);

q3=(cos(angle.degrad)+(sin(angle.degrad)*(i3+j3+k3)));
v3=q3*v3*q3.conjugate;

raz3=Cartesian(v3.b.round(0.0001),v3.c.round(0.0001),v3.d.round(0.0001)).theta.round(0.00001);
};

)

///////////////////////el
(
var pl1=0,az1,el1,sph1,rot1,i1,j1,k1,q1,raz1,rel1;
var pl2=0,az2,el2,sph2,rot2,i2,j2,k2,q2,raz2,rel2;
var pl3=0,az3,el3,sph3,rot3,i3,j3,k3,q3,raz3,rel3;
var r1=[0,0,1],r2=[1,0,0],r3=[0,1,0];
var v1=Quaternion(0,r1.[0],r1.[1],r1.[2]),v2=Quaternion(0,r2.[0],r2.[1],r2.[2]),v3=Quaternion(0,r3.[0],r3.[1],r3.[2]);
var angle=(360-(360/1.6180339887499));

~el_x=(90*~time).collect{

	az1=~az.[pl1];el1=~el.[pl1];
	pl1=pl1+1;
sph1=Spherical(1,az1,el1).asCartesian;

	rot1=[sph1.x,sph1.y,sph1.z];

	i1=Quaternion(0, rot1.[0], 0, 0);
	j1=Quaternion(0, 0, rot1.[1], 0);
	k1=Quaternion(0, 0, 0, rot1.[2]);

q1=(cos(angle.degrad)+(sin(angle.degrad)*(i1+j1+k1)));
v1=q1*v1*q1.conjugate;

rel1=Cartesian(v1.b.round(0.0001),v1.c.round(0.0001),v1.d.round(0.0001)).phi.round(0.00001);
};

~el_y=(90*~time).collect{

	az2=~az.[pl2];el2=~el.[pl2];
	pl2=pl2+1;
sph2=Spherical(1,az2,el2).asCartesian;

	rot2=[sph2.x,sph2.y,sph2.z];

	i2=Quaternion(0, rot2.[0], 0, 0);
	j2=Quaternion(0, 0, rot2.[1], 0);
	k2=Quaternion(0, 0, 0, rot2.[2]);

q2=(cos(angle.degrad)+(sin(angle.degrad)*(i2+j2+k2)));
v2=q2*v2*q2.conjugate;

rel2=Cartesian(v2.b.round(0.0001),v2.c.round(0.0001),v2.d.round(0.0001)).phi.round(0.00001);
};

~el_z=(90*~time).collect{

	az3=~az.[pl3];el3=~el.[pl3];
	pl3=pl3+1;
sph3=Spherical(1,az3,el3).asCartesian;

	rot3=[sph3.x,sph3.y,sph3.z];

	i3=Quaternion(0, rot3.[0], 0, 0);
	j3=Quaternion(0, 0, rot3.[1], 0);
	k3=Quaternion(0, 0, 0, rot3.[2]);

q3=(cos(angle.degrad)+(sin(angle.degrad)*(i3+j3+k3)));
v3=q3*v3*q3.conjugate;

rel3=Cartesian(v3.b.round(0.0001),v3.c.round(0.0001),v3.d.round(0.0001)).phi.round(0.00001);
};

)

/////////////////////extra radomizer

(
~az_x=~az_x.scramble;
~az_y=~az_y.scramble;
~az_z=~az_z.scramble;
~el_x=~el_x.scramble;
~el_y=~el_y.scramble;
~el_z=~el_z.scramble;
)

//////////////////////////////////////////////////space
(
~magx_array=[~magx1.normalize(0,1),~magx2.normalize(0,1),~magx3.normalize(0,1),~magx4.normalize(0,1),~magx5.normalize(0,1)];
~magy_array=[~magy1.normalize(0,1),~magy2.normalize(0,1),~magy3.normalize(0,1),~magy4.normalize(0,1),~magy5.normalize(0,1)];
~magz_array=[~magz1.normalize(0,1),~magz2.normalize(0,1),~magz3.normalize(0,1),~magz4.normalize(0,1),~magz5.normalize(0,1)];
)
/////////////////////////////piknotites
(
var freq=1,ph1,ph2,ph3,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0,pl6=0,sph1,sph2,sph3,n1,n2,n3;
var mag1,mag2,mag3,rythm,index1,index2,index3,pl7=0,pl8=0,pl9=0,t1,t2,t3;


~rot_speed = (90*~time).collect{
	ph1=Cartesian(~magx.normalize(0,1).[pl1],~magy.normalize(0,1).[pl1],~magz.normalize(0,1).[pl1]).rho/(2.sqrt);
	pl1=pl1+1;
	ph1=(ph1/10).round(0.000001);

	};

)
~rot_speed=~rot_speed.scramble;

(
~magx1=~magx1.normalize(0,1).round(0.0000001);
~magy1=~magy1.normalize(0,1).round(0.0000001);
~magz1=~magz1.normalize(0,1).round(0.0000001);
~magx2=~magx2.normalize(0,1).round(0.0000001);
~magy2=~magy2.normalize(0,1).round(0.0000001);
~magz2=~magz2.normalize(0,1).round(0.0000001);
~magx3=~magx3.normalize(0,1).round(0.0000001);
~magy3=~magy3.normalize(0,1).round(0.0000001);
~magz3=~magz3.normalize(0,1).round(0.0000001);
~magx4=~magx4.normalize(0,1).round(0.0000001);
~magy4=~magy4.normalize(0,1).round(0.0000001);
~magz4=~magz4.normalize(0,1).round(0.0000001);
~magx5=~magx5.normalize(0,1).round(0.0000001);
~magy5=~magy5.normalize(0,1).round(0.0000001);
~magz5=~magz5.normalize(0,1).round(0.0000001);
)

(
(
SynthDef.new(\o1, {
    var in1,in2, chainx,chainy,b=0,az1=0,az2=0,el1=0,el2=0,rpr=1;
	var chainxx,chainyy,pl=0,amp1,amp2,phase;
	var angle1=0,angle2=90;
	var phase1,phase2,bank1,bank2,frames=1024;

    in1 =SoundIn.ar(0);
	 in2 = SoundIn.ar(0);

	chainx = FFT(LocalBuf(frames), in1);
	chainy = FFT(LocalBuf(frames), in2);

	bank2=180;

   bank2.do{

		az1=~az.[pl];
		el1=~el.[pl];
		az2=~az.neg.[pl];
		el2=~el.neg.[pl];
amp1=Cartesian(~magx1.[pl],~magy1.[pl],~magz1.[pl]);
amp2=Cartesian(~magx1.[pl],~magy1.[pl],~magz1.[pl]);

		phase1=exp(Complex(0,1)*(amp1.theta*amp1.phi));
		phase2=exp(Complex(0,1)*(amp2.theta*amp2.phi));

chainxx = chainx.pvcollect(frames, {|mag, phase, index| [mag*amp1.rho/(2.sqrt), exp(Complex(0,1)*(phase+phase1.theta)).theta]; }, frombin: b, tobin: b, zeroothers: 1);
chainyy = chainy.pvcollect(frames, {|mag, phase, index| [mag*amp2.rho/(2.sqrt), exp(Complex(0,1)*(phase+phase2.theta)).theta]; }, frombin: b, tobin: b, zeroothers: 1);

	b=b+1;

		Out.ar(0,VBAP.ar(4,IFFT(chainxx),~b.bufnum,
		Osc.ar(~t,~rot_speed.[pl],phase:az1.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
			Osc.ar(~t,~rot_speed.[pl],phase:el1.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)));

		Out.ar(0,VBAP.ar(4,IFFT(chainyy),~b.bufnum,
		Osc.ar(~t,~rot_speed.[pl],phase:az2.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
			Osc.ar(~t,~rot_speed.[pl],phase:el2.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)));
pl=pl+1;

	};
}).add;
);
(
SynthDef.new(\o2, {
    var in1,in2, chainx,chainy,b=0,az1=0,az2=0,el1=0,el2=0,rpr=1;
	var chainxx,chainyy,pl=0,amp1,amp2,phase;
	var angle1=0,angle2=90;
	var phase1,phase2,bank1,bank2,frames=1024;

in1 =SoundIn.ar(0);
	 in2 = SoundIn.ar(0);

	chainx = FFT(LocalBuf(frames), in1);
	chainy = FFT(LocalBuf(frames), in2);

	bank2=180;

   bank2.do{

		az1=~az.[pl];
		el1=~el.[pl];
		az2=~az.neg.[pl];
		el2=~el.neg.[pl];
amp1=Cartesian(~magx2.[pl],~magy2.[pl],~magz2.[pl]);
amp2=Cartesian(~magx2.[pl],~magy2.[pl],~magz2.[pl]);

		phase1=exp(Complex(0,1)*(amp1.theta*amp1.phi));
		phase2=exp(Complex(0,1)*(amp2.theta*amp2.phi));

chainxx = chainx.pvcollect(frames, {|mag, phase, index| [mag*amp1.rho/(2.sqrt), exp(Complex(0,1)*(phase+phase1.theta)).theta]; }, frombin: b, tobin: b, zeroothers: 1);
chainyy = chainy.pvcollect(frames, {|mag, phase, index| [mag*amp2.rho/(2.sqrt), exp(Complex(0,1)*(phase+phase2.theta)).theta]; }, frombin: b, tobin: b, zeroothers: 1);

	b=b+1;

		Out.ar(0,VBAP.ar(4,IFFT(chainxx),~b.bufnum,
		Osc.ar(~t,~rot_speed.[pl],phase:az1.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
			Osc.ar(~t,~rot_speed.[pl],phase:el1.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)));

		Out.ar(0,VBAP.ar(4,IFFT(chainyy),~b.bufnum,
		Osc.ar(~t,~rot_speed.[pl],phase:az2.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
			Osc.ar(~t,~rot_speed.[pl],phase:el2.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)));
pl=pl+1;
	}
	}).add;
);
(
SynthDef.new(\o3, {
    var in1,in2, chainx,chainy,b=0,az1=0,az2=0,el1=0,el2=0,rpr=1;
	var chainxx,chainyy,pl=0,amp1,amp2,phase;
	var angle1=0,angle2=90;
	var phase1,phase2,bank1,bank2,frames=1024;

    in1 =SoundIn.ar(0);
	 in2 = SoundIn.ar(0);

	chainx = FFT(LocalBuf(frames), in1);
	chainy = FFT(LocalBuf(frames), in2);

	bank2=180;

   bank2.do{

		az1=~az.[pl];
		el1=~el.[pl];
		az2=~az.neg.[pl];
		el2=~el.neg.[pl];
amp1=Cartesian(~magx3.[pl],~magy3.[pl],~magz3.[pl]);
amp2=Cartesian(~magx3.[pl],~magy3.[pl],~magz3.[pl]);

		phase1=exp(Complex(0,1)*(amp1.theta*amp1.phi));
		phase2=exp(Complex(0,1)*(amp2.theta*amp2.phi));

chainxx = chainx.pvcollect(frames, {|mag, phase, index| [mag*amp1.rho/(2.sqrt), exp(Complex(0,1)*(phase+phase1.theta)).theta]; }, frombin: b, tobin: b, zeroothers: 1);
chainyy = chainy.pvcollect(frames, {|mag, phase, index| [mag*amp2.rho/(2.sqrt), exp(Complex(0,1)*(phase+phase2.theta)).theta]; }, frombin: b, tobin: b, zeroothers: 1);

	b=b+1;

		Out.ar(0,VBAP.ar(4,IFFT(chainxx),~b.bufnum,
		Osc.ar(~t,~rot_speed.[pl],phase:az1.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
			Osc.ar(~t,~rot_speed.[pl],phase:el1.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)));

		Out.ar(0,VBAP.ar(4,IFFT(chainyy),~b.bufnum,
		Osc.ar(~t,~rot_speed.[pl],phase:az2.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
			Osc.ar(~t,~rot_speed.[pl],phase:el2.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)));
pl=pl+1;
	}
	}).add;
);
(
SynthDef.new(\o4, {
    var in1,in2, chainx,chainy,b=0,az1=0,az2=0,el1=0,el2=0,rpr=1;
	var chainxx,chainyy,pl=0,amp1,amp2,phase;
	var angle1=0,angle2=90;
	var phase1,phase2,bank1,bank2,frames=1024;

   in1 =SoundIn.ar(0);
	 in2 = SoundIn.ar(0);

	chainx = FFT(LocalBuf(frames), in1);
	chainy = FFT(LocalBuf(frames), in2);

	bank2=180;

   bank2.do{

		az1=~az.[pl];
		el1=~el.[pl];
		az2=~az.neg.[pl];
		el2=~el.neg.[pl];
amp1=Cartesian(~magx4.[pl],~magy4.[pl],~magz4.[pl]);
amp2=Cartesian(~magx4.[pl],~magy4.[pl],~magz4.[pl]);

		phase1=exp(Complex(0,1)*(amp1.theta*amp1.phi));
		phase2=exp(Complex(0,1)*(amp2.theta*amp2.phi));

chainxx = chainx.pvcollect(frames, {|mag, phase, index| [mag*amp1.rho/(2.sqrt), exp(Complex(0,1)*(phase+phase1.theta)).theta]; }, frombin: b, tobin: b, zeroothers: 1);
chainyy = chainy.pvcollect(frames, {|mag, phase, index| [mag*amp2.rho/(2.sqrt), exp(Complex(0,1)*(phase+phase2.theta)).theta]; }, frombin: b, tobin: b, zeroothers: 1);

	b=b+1;

		Out.ar(0,VBAP.ar(4,IFFT(chainxx),~b.bufnum,
		Osc.ar(~t,~rot_speed.[pl],phase:az1.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
			Osc.ar(~t,~rot_speed.[pl],phase:el1.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)));

		Out.ar(0,VBAP.ar(4,IFFT(chainyy),~b.bufnum,
		Osc.ar(~t,~rot_speed.[pl],phase:az2.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
			Osc.ar(~t,~rot_speed.[pl],phase:el2.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)));
pl=pl+1;
	}
	}).add;
);
(
SynthDef.new(\o5, {
    var in1,in2, chainx,chainy,b=0,az1=0,az2=0,el1=0,el2=0,rpr=1;
	var chainxx,chainyy,pl=0,amp1,amp2,phase;
	var angle1=0,angle2=90;
	var phase1,phase2,bank1,bank2,frames=1024;

    in1 =SoundIn.ar(0);
	 in2 = SoundIn.ar(0);

	chainx = FFT(LocalBuf(frames), in1);
	chainy = FFT(LocalBuf(frames), in2);

	bank2=180;

   bank2.do{

		az1=~az.[pl];
		el1=~el.[pl];
		az2=~az.neg.[pl];
		el2=~el.neg.[pl];
amp1=Cartesian(~magx5.[pl],~magy5.[pl],~magz5.[pl]);
amp2=Cartesian(~magx5.[pl],~magy5.[pl],~magz5.[pl]);

		phase1=exp(Complex(0,1)*(amp1.theta*amp1.phi));
		phase2=exp(Complex(0,1)*(amp2.theta*amp2.phi));

chainxx = chainx.pvcollect(frames, {|mag, phase, index| [mag*amp1.rho/(2.sqrt), exp(Complex(0,1)*(phase+phase1.theta)).theta]; }, frombin: b, tobin: b, zeroothers: 1);
chainyy = chainy.pvcollect(frames, {|mag, phase, index| [mag*amp2.rho/(2.sqrt), exp(Complex(0,1)*(phase+phase2.theta)).theta]; }, frombin: b, tobin: b, zeroothers: 1);

	b=b+1;

		Out.ar(0,VBAP.ar(4,IFFT(chainxx),~b.bufnum,
		Osc.ar(~t,~rot_speed.[pl],phase:az1.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
			Osc.ar(~t,~rot_speed.[pl],phase:el1.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)));

		Out.ar(0,VBAP.ar(4,IFFT(chainyy),~b.bufnum,
		Osc.ar(~t,~rot_speed.[pl],phase:az2.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
			Osc.ar(~t,~rot_speed.[pl],phase:el2.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)));
pl=pl+1;
	}
	}).add;
);
)
(
Synth(\o1);
Synth(\o2);
Synth(\o3);
Synth(\o4);
Synth(\o5);
s.record(numChannels:4)
)
////exp(Complex(0,1)*(phase+SinOsc.ar(mg,phase1))).theta
//////////////////////////////////////IN

(
SynthDef.new(\o_in, {
    var in1,in2, chainx,chainy,b=0,az1=0,az2=0,el1=0,el2=0,rpr=1;
	var chainxx,chainyy,pl1=0,pl2=0,pl=0,amp1,amp2,phase;
	var angle1=0,angle2=90;
	var phase1,phase2,bank1,bank2,frames=1024;

	in1 =SoundIn.ar(0);
	 in2 = SoundIn.ar(0);

	chainx = FFT(LocalBuf(frames), in1);
	chainy = FFT(LocalBuf(frames), in2);

	bank1=3;
	bank2=90;

	bank1.do{

   bank2.do{

		az1=~az.[pl];
		el1=~el.[pl];
		az2=~az.neg.[pl];
		el2=~el.neg.[pl];
amp1=Cartesian(~magx_array.[pl2].[pl1],~magx_array.[pl2].[pl1],~magx_array.[pl2].[pl1]);
amp2=Cartesian(~magx_array.[pl2].[pl1],~magx_array.[pl2].[pl1],~magx_array.[pl2].[pl1]);

		phase1=exp(Complex(0,1)*(amp1.theta*amp1.phi));
		phase2=exp(Complex(0,1)*(amp2.theta*amp2.phi));

chainxx = chainx.pvcollect(frames, {|mag, phase, index| [mag*amp1.rho/(2.sqrt), exp(Complex(0,1)*(phase+phase1.theta)).theta]; }, frombin: b, tobin: b, zeroothers: 1);
chainyy = chainy.pvcollect(frames, {|mag, phase, index| [mag*amp2.rho/(2.sqrt), exp(Complex(0,1)*(phase+phase2.theta)).theta]; }, frombin: b, tobin: b, zeroothers: 1);

	b=b+1;

		Out.ar(0,VBAP.ar(4,IFFT(chainxx),~b.bufnum,
		Osc.ar(~t,rpr,phase:az1.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
			Osc.ar(~t,rpr,phase:el1.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)));

		Out.ar(0,VBAP.ar(4,IFFT(chainyy),~b.bufnum,
		Osc.ar(~t,rpr,phase:az2.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
			Osc.ar(~t,rpr,phase:el2.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)));
pl=pl+1;
	pl1=pl1+1;

		};
		pl2=pl2+1;
	};
}).add;
)


Synth(\o_in);
s.record(numChannels:4)