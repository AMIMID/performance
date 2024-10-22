(
Server.default = s = Server.local;

////server setup
(
s.options.numWireBufs = 1024*4;
s.options.numOutputBusChannels=4;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(0.5);
s.options.memSize = 8192*8;
s.options.blockSize = 64;
s.options.maxNodes = 1024 * 16;
s.options.sampleRate= 48000;
s.waitForBoot
);

s.waitForBoot{
/////wavetables
Buffer.freeAll;
(
(
//~w= Buffer.alloc(s,2048);
~t= Buffer.alloc(s,2048);
~a = VBAPSpeakerArray.new(3, [[0, 45], [180, 45], [90, 45.neg], [90.neg, 45.neg]]);
~b = Buffer.loadCollection(s, ~a.getSetsAndMatrices);
);

/*(
var env,sig,wt,angle=0,level,levels;

~levelss=360.collect{

	level=exp(Complex(0,1)*angle).imag;
		angle=angle+1.degrad;
	levels=level.rrand(exp(Complex(0,1)*angle+((360-(360/1.6180339887499))/5).degrad).imag);
};
env = Env(~levelss,[1]);
sig=env.asSignal(1024);
wt = sig.asWavetable;
~w.loadCollection(wt);
sig.plot;
)*///;

////speaker setup
/*(
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
)*/

//////////arrays
///fractal
		{
var signal,wt,m=0,amp;

~level=45.round(1).collect{m=m+1;amp=m.reciprocal};
~phase=45.collect{pi};
signal=Signal.sineFill(1024,~level,~phase);

wt = signal.asWavetable;
~t.loadCollection(wt);
//signal.plot;
		}.value;
		~time=1;
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

~j = (180*~time).collect{
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

~h = (180*~time).collect{
	cc1=~k.[4].round(0.0000000000001);
	z1=z1.pow(2)+cc1;
	z1.theta.round(0.0000000000001);

}

		}.value;
//////////////////////basis
{

var  sph1,sph2,m_x=3,m_y=2,m_z=1,az1=0,el1=0,az2=0,el2=0,mag_x,mag_y,mag_z;
var azx=0,elx=0,azy=0,ely=0,azz=0,elz=0,sphx,sphy,sphz,rad=1;
var pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;

~az = (90*~time).collect{
pl1=pl1+1;
		az1=(az1+(1)).wrap(180.neg,180);

	el1=(el1+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph1=Spherical(1,az1.degrad*~h.[pl1],el1.degrad*~j.[pl1]).theta.round(0.0000000000001);

	};

~el = (90*~time).collect{
pl2=pl2+1;
		az2=(az2+(1)).wrap(90.neg,90);

	el2=(el2+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph2=Spherical(1,az2.degrad*~h.[pl2],el2.degrad*~j.[pl2]).phi.round(0.0000000000001);

	};

~magx = (90*~time).collect{
pl3=pl3+1;

	azx=(azx+(1)).wrap(180.neg,180);

	elx=(elx+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sphx=Spherical(rad,azx.degrad*~h.[pl3],elx.degrad*~j.[pl3]);


/*mag_x=(Complex(cos((sphx.theta.round(0.0000000000001)*m_x).wrap(pi.neg,pi)),cos((sphx.theta.round(0.0000000000001)*m_x).wrap(pi.neg,pi))).rho*
	Complex(cos((sphx.phi.round(0.0000000000001)).wrap((pi/2).neg,(pi/2))),cos((sphx.phi.round(0.0000000000001)).wrap((pi/2).neg,(pi/2)))).rho)*sphx.rho;
	mag_x.round(0.0000000000001);*/

	mag_x=(Complex(cos((sphx.theta.round(0.0000000000001)*m_x).wrap(pi.neg,pi)),cos((sphx.theta.round(0.0000000000001)*m_x).wrap(pi.neg,pi))).rho*
Complex(sin((sphx.phi.round(0.0000000000001)*(m_x-1)).wrap((pi/2).neg,(pi/2))),sin((sphx.phi.round(0.0000000000001)*(m_x-1)).wrap((pi/2).neg,(pi/2)))).rho*
Complex(cos((sphx.phi.round(0.0000000000001)).wrap((pi/2).neg,(pi/2))),cos((sphx.phi.round(0.0000000000001)).wrap((pi/2).neg,(pi/2)))).rho)*sphx.rho;


	};

~magy = (90*~time).collect{
pl4=pl4+1;
	azy=(azy+(1)).wrap(180.neg,180);

	ely=(ely+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sphy=Spherical(rad,azy.degrad*~h.[pl4],ely.degrad*~j.[pl4]);

	mag_y=(Complex(sin((sphy.theta.round(0.0000000000001)*m_y).wrap(pi.neg,pi)),sin((sphy.theta.round(0.0000000000001)*m_y).wrap(pi.neg,pi))).rho*
		Complex(cos((sphy.phi.round(0.0000000000001)).wrap((pi/2).neg,(pi/2))),cos((sphy.phi.round(0.0000000000001)).wrap((pi/2).neg,(pi/2)))).rho)*sphy.rho;
mag_y.round(0.0000000000001);
//	mag_y=(Complex(sin((sphy.theta.round(0.0000000000001)*m_y).wrap(pi.neg,pi)),sin((sphy.theta.round(0.0000000000001)*m_y).wrap(pi.neg,pi))).rho*
//Complex(sin((sphy.phi.round(0.0000000000001)*(m_y-1)).wrap((pi/2).neg,(pi/2))),sin((sphy.phi.round(0.0000000000001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).rho*
//Complex(cos((sphy.phi.round(0.0000000000001)).wrap((pi/2).neg,(pi/2))),cos((sphy.phi.round(0.0000000000001)).wrap((pi/2).neg,(pi/2)))).rho)*sphy.rho;

	};

~magz = (90*~time).collect{
pl5=pl5+1;
	azz=(azz+(1)).wrap(180.neg,180);

	elz=(elz+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sphz=Spherical(rad,azz.degrad*~h.[pl5],elz.degrad*~j.[pl5]);

if(
m_z.even,
mag_z=Complex(cos((sphz.phi.round(0.0000000000001)*m_z).wrap((pi/2).neg,(pi/2))),cos((sphz.phi.round(0.0000000000001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sphz.rho,
mag_z=Complex(sin((sphz.phi.round(0.0000000000001)*m_z).wrap((pi/2).neg,(pi/2))),sin((sphz.phi.round(0.0000000000001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sphz.rho
	);
	mag_z.round(0.0000000000001);
	};

		}.value;

{
var  sph1,sph2,m_x=1,m_y=1,m_z=1,az1=0,el1=0,az2=0,el2=0,mag_x,mag_y,mag_z;
var azx=0,elx=0,azy=0,ely=0,azz=0,elz=0,sphx,sphy,sphz,rad=1;
var pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;


~magx1 = (90*~time).collect{
pl3=pl3+1;
	azx=(azx+(1)).wrap(180.neg,180);

	elx=(elx+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sphx=Spherical(rad,azx.degrad*~h.[pl3],elx.degrad*~j.[pl3]);

	mag_x=(Complex(cos((sphx.theta.round(0.0000000000001)*m_x).wrap(pi.neg,pi)),cos((sphx.theta.round(0.0000000000001)*m_x).wrap(pi.neg,pi))).rho*
	Complex(cos((sphx.phi.round(0.0000000000001)).wrap((pi/2).neg,(pi/2))),cos((sphx.phi.round(0.0000000000001)).wrap((pi/2).neg,(pi/2)))).rho)*sphx.rho;
	mag_x.round(0.0000000000001);

	/*mag_x=(Complex(cos((sphx.theta.round(0.0000000000001)*m_x).wrap(pi.neg,pi)),cos((sphx.theta.round(0.0000000000001)*m_x).wrap(pi.neg,pi))).rho*
Complex(sin((sphx.phi.round(0.0000000000001)*(m_x-1)).wrap((pi/2).neg,(pi/2))),sin((sphx.phi.round(0.0000000000001)*(m_x-1)).wrap((pi/2).neg,(pi/2)))).rho*
Complex(cos((sphx.phi.round(0.0000000000001)).wrap((pi/2).neg,(pi/2))),cos((sphx.phi.round(0.0000000000001)).wrap((pi/2).neg,(pi/2)))).rho)*sphx.rho;
*/
	};

~magy1 = (90*~time).collect{
pl4=pl4+1;
	azy=(azy+(1)).wrap(180.neg,180);

	ely=(ely+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sphy=Spherical(rad,azy.degrad*~h.[pl4],ely.degrad*~j.[pl4]);

	mag_y=(Complex(sin((sphy.theta.round(0.0000000000001)*m_y).wrap(pi.neg,pi)),sin((sphy.theta.round(0.0000000000001)*m_y).wrap(pi.neg,pi))).rho*
		Complex(cos((sphy.phi.round(0.0000000000001)).wrap((pi/2).neg,(pi/2))),cos((sphy.phi.round(0.0000000000001)).wrap((pi/2).neg,(pi/2)))).rho)*sphy.rho;
mag_y.round(0.0000000000001);
//	mag_y=(Complex(sin((sphy.theta.round(0.0000000000001)*m_y).wrap(pi.neg,pi)),sin((sphy.theta.round(0.0000000000001)*m_y).wrap(pi.neg,pi))).rho*
//Complex(sin((sphy.phi.round(0.0000000000001)*(m_y-1)).wrap((pi/2).neg,(pi/2))),sin((sphy.phi.round(0.0000000000001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).rho*
//Complex(cos((sphy.phi.round(0.0000000000001)).wrap((pi/2).neg,(pi/2))),cos((sphy.phi.round(0.0000000000001)).wrap((pi/2).neg,(pi/2)))).rho)*sphy.rho;

	};

~magz1 = (90*~time).collect{
pl5=pl5+1;
	azz=(azz+(1)).wrap(180.neg,180);

	elz=(elz+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sphz=Spherical(rad,azz.degrad*~h.[pl5],elz.degrad*~j.[pl5]);

if(
m_z.even,
mag_z=Complex(cos((sphz.phi.round(0.0000000000001)*m_z).wrap((pi/2).neg,(pi/2))),cos((sphz.phi.round(0.0000000000001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sphz.rho,
mag_z=Complex(sin((sphz.phi.round(0.0000000000001)*m_z).wrap((pi/2).neg,(pi/2))),sin((sphz.phi.round(0.0000000000001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sphz.rho
	);
	mag_z.round(0.0000000000001);
	};

		}.value;

{
var  sph1,sph2,m_x=2,m_y=2,m_z=2,az1=0,el1=0,az2=0,el2=0,mag_x,mag_y,mag_z;
var azx=0,elx=0,azy=0,ely=0,azz=0,elz=0,sphx,sphy,sphz,rad=1;
var pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;


~magx2 = (90*~time).collect{
pl3=pl3+1;
	azx=(azx+(1)).wrap(180.neg,180);

	elx=(elx+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sphx=Spherical(rad,azx.degrad*~h.[pl3],elx.degrad*~j.[pl3]);

mag_x=(Complex(cos((sphx.theta.round(0.0000000000001)*m_x).wrap(pi.neg,pi)),cos((sphx.theta.round(0.0000000000001)*m_x).wrap(pi.neg,pi))).rho*
	Complex(cos((sphx.phi.round(0.0000000000001)).wrap((pi/2).neg,(pi/2))),cos((sphx.phi.round(0.0000000000001)).wrap((pi/2).neg,(pi/2)))).rho)*sphx.rho;
	mag_x.round(0.0000000000001);

	/*mag_x=(Complex(cos((sphx.theta.round(0.0000000000001)*m_x).wrap(pi.neg,pi)),cos((sphx.theta.round(0.0000000000001)*m_x).wrap(pi.neg,pi))).rho*
Complex(sin((sphx.phi.round(0.0000000000001)*(m_x-1)).wrap((pi/2).neg,(pi/2))),sin((sphx.phi.round(0.0000000000001)*(m_x-1)).wrap((pi/2).neg,(pi/2)))).rho*
Complex(cos((sphx.phi.round(0.0000000000001)).wrap((pi/2).neg,(pi/2))),cos((sphx.phi.round(0.0000000000001)).wrap((pi/2).neg,(pi/2)))).rho)*sphx.rho;
*/

	};

~magy2 = (90*~time).collect{
pl4=pl4+1;
	azy=(azy+(1)).wrap(180.neg,180);

	ely=(ely+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sphy=Spherical(rad,azy.degrad*~h.[pl4],ely.degrad*~j.[pl4]);

	mag_y=(Complex(sin((sphy.theta.round(0.0000000000001)*m_y).wrap(pi.neg,pi)),sin((sphy.theta.round(0.0000000000001)*m_y).wrap(pi.neg,pi))).rho*
		Complex(cos((sphy.phi.round(0.0000000000001)).wrap((pi/2).neg,(pi/2))),cos((sphy.phi.round(0.0000000000001)).wrap((pi/2).neg,(pi/2)))).rho)*sphy.rho;
mag_y.round(0.0000000000001);
//	mag_y=(Complex(sin((sphy.theta.round(0.0000000000001)*m_y).wrap(pi.neg,pi)),sin((sphy.theta.round(0.0000000000001)*m_y).wrap(pi.neg,pi))).rho*
//Complex(sin((sphy.phi.round(0.0000000000001)*(m_y-1)).wrap((pi/2).neg,(pi/2))),sin((sphy.phi.round(0.0000000000001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).rho*
//Complex(cos((sphy.phi.round(0.0000000000001)).wrap((pi/2).neg,(pi/2))),cos((sphy.phi.round(0.0000000000001)).wrap((pi/2).neg,(pi/2)))).rho)*sphy.rho;

	};

~magz2 = (90*~time).collect{
pl5=pl5+1;
	azz=(azz+(1)).wrap(180.neg,180);

	elz=(elz+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sphz=Spherical(rad,azz.degrad*~h.[pl5],elz.degrad*~j.[pl5]);

if(
m_z.even,
mag_z=Complex(cos((sphz.phi.round(0.0000000000001)*m_z).wrap((pi/2).neg,(pi/2))),cos((sphz.phi.round(0.0000000000001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sphz.rho,
mag_z=Complex(sin((sphz.phi.round(0.0000000000001)*m_z).wrap((pi/2).neg,(pi/2))),sin((sphz.phi.round(0.0000000000001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sphz.rho
	);
	mag_z.round(0.0000000000001);
	};

}.value;

{
var  sph1,sph2,m_x=3,m_y=3,m_z=3,az1=0,el1=0,az2=0,el2=0,mag_x,mag_y,mag_z;
var azx=0,elx=0,azy=0,ely=0,azz=0,elz=0,sphx,sphy,sphz,rad=1;
var pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;


~magx3 = (90*~time).collect{
pl3=pl3+1;
	azx=(azx+(1)).wrap(180.neg,180);

	elx=(elx+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sphx=Spherical(rad,azx.degrad*~h.[pl3],elx.degrad*~j.[pl3]);

mag_x=(Complex(cos((sphx.theta.round(0.0000000000001)*m_x).wrap(pi.neg,pi)),cos((sphx.theta.round(0.0000000000001)*m_x).wrap(pi.neg,pi))).rho*
	Complex(cos((sphx.phi.round(0.0000000000001)).wrap((pi/2).neg,(pi/2))),cos((sphx.phi.round(0.0000000000001)).wrap((pi/2).neg,(pi/2)))).rho)*sphx.rho;
	mag_x.round(0.0000000000001);

	/*mag_x=(Complex(cos((sphx.theta.round(0.0000000000001)*m_x).wrap(pi.neg,pi)),cos((sphx.theta.round(0.0000000000001)*m_x).wrap(pi.neg,pi))).rho*
Complex(sin((sphx.phi.round(0.0000000000001)*(m_x-1)).wrap((pi/2).neg,(pi/2))),sin((sphx.phi.round(0.0000000000001)*(m_x-1)).wrap((pi/2).neg,(pi/2)))).rho*
Complex(cos((sphx.phi.round(0.0000000000001)).wrap((pi/2).neg,(pi/2))),cos((sphx.phi.round(0.0000000000001)).wrap((pi/2).neg,(pi/2)))).rho)*sphx.rho;
*/

	};

~magy3 = (90*~time).collect{
pl4=pl4+1;
	azy=(azy+(1)).wrap(180.neg,180);

	ely=(ely+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sphy=Spherical(rad,azy.degrad*~h.[pl4],ely.degrad*~j.[pl4]);

	mag_y=(Complex(sin((sphy.theta.round(0.0000000000001)*m_y).wrap(pi.neg,pi)),sin((sphy.theta.round(0.0000000000001)*m_y).wrap(pi.neg,pi))).rho*
		Complex(cos((sphy.phi.round(0.0000000000001)).wrap((pi/2).neg,(pi/2))),cos((sphy.phi.round(0.0000000000001)).wrap((pi/2).neg,(pi/2)))).rho)*sphy.rho;
mag_y.round(0.0000000000001);
//	mag_y=(Complex(sin((sphy.theta.round(0.0000000000001)*m_y).wrap(pi.neg,pi)),sin((sphy.theta.round(0.0000000000001)*m_y).wrap(pi.neg,pi))).rho*
//Complex(sin((sphy.phi.round(0.0000000000001)*(m_y-1)).wrap((pi/2).neg,(pi/2))),sin((sphy.phi.round(0.0000000000001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).rho*
//Complex(cos((sphy.phi.round(0.0000000000001)).wrap((pi/2).neg,(pi/2))),cos((sphy.phi.round(0.0000000000001)).wrap((pi/2).neg,(pi/2)))).rho)*sphy.rho;

	};

~magz3 = (90*~time).collect{
pl5=pl5+1;
	azz=(azz+(1)).wrap(180.neg,180);

	elz=(elz+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sphz=Spherical(rad,azz.degrad*~h.[pl5],elz.degrad*~j.[pl5]);

if(
m_z.even,
mag_z=Complex(cos((sphz.phi.round(0.0000000000001)*m_z).wrap((pi/2).neg,(pi/2))),cos((sphz.phi.round(0.0000000000001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sphz.rho,
mag_z=Complex(sin((sphz.phi.round(0.0000000000001)*m_z).wrap((pi/2).neg,(pi/2))),sin((sphz.phi.round(0.0000000000001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sphz.rho
	);
	mag_z.round(0.0000000000001);
	};

}.value;

{
var  sph1,sph2,m_x=4,m_y=4,m_z=4,az1=0,el1=0,az2=0,el2=0,mag_x,mag_y,mag_z;
var azx=0,elx=0,azy=0,ely=0,azz=0,elz=0,sphx,sphy,sphz,rad=1;
var pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;


~magx4 = (90*~time).collect{
pl3=pl3+1;
	azx=(azx+(1)).wrap(180.neg,180);

	elx=(elx+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sphx=Spherical(rad,azx.degrad*~h.[pl3],elx.degrad*~j.[pl3]);

mag_x=(Complex(cos((sphx.theta.round(0.0000000000001)*m_x).wrap(pi.neg,pi)),cos((sphx.theta.round(0.0000000000001)*m_x).wrap(pi.neg,pi))).rho*
	Complex(cos((sphx.phi.round(0.0000000000001)).wrap((pi/2).neg,(pi/2))),cos((sphx.phi.round(0.0000000000001)).wrap((pi/2).neg,(pi/2)))).rho)*sphx.rho;
	mag_x.round(0.0000000000001);

	/*mag_x=(Complex(cos((sphx.theta.round(0.0000000000001)*m_x).wrap(pi.neg,pi)),cos((sphx.theta.round(0.0000000000001)*m_x).wrap(pi.neg,pi))).rho*
Complex(sin((sphx.phi.round(0.0000000000001)*(m_x-1)).wrap((pi/2).neg,(pi/2))),sin((sphx.phi.round(0.0000000000001)*(m_x-1)).wrap((pi/2).neg,(pi/2)))).rho*
Complex(cos((sphx.phi.round(0.0000000000001)).wrap((pi/2).neg,(pi/2))),cos((sphx.phi.round(0.0000000000001)).wrap((pi/2).neg,(pi/2)))).rho)*sphx.rho;
*/

	};

~magy4 = (90*~time).collect{
pl4=pl4+1;
	azy=(azy+(1)).wrap(180.neg,180);

	ely=(ely+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sphy=Spherical(rad,azy.degrad*~h.[pl4],ely.degrad*~j.[pl4]);

	mag_y=(Complex(sin((sphy.theta.round(0.0000000000001)*m_y).wrap(pi.neg,pi)),sin((sphy.theta.round(0.0000000000001)*m_y).wrap(pi.neg,pi))).rho*
		Complex(cos((sphy.phi.round(0.0000000000001)).wrap((pi/2).neg,(pi/2))),cos((sphy.phi.round(0.0000000000001)).wrap((pi/2).neg,(pi/2)))).rho)*sphy.rho;
mag_y.round(0.0000000000001);
//	mag_y=(Complex(sin((sphy.theta.round(0.0000000000001)*m_y).wrap(pi.neg,pi)),sin((sphy.theta.round(0.0000000000001)*m_y).wrap(pi.neg,pi))).rho*
//Complex(sin((sphy.phi.round(0.0000000000001)*(m_y-1)).wrap((pi/2).neg,(pi/2))),sin((sphy.phi.round(0.0000000000001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).rho*
//Complex(cos((sphy.phi.round(0.0000000000001)).wrap((pi/2).neg,(pi/2))),cos((sphy.phi.round(0.0000000000001)).wrap((pi/2).neg,(pi/2)))).rho)*sphy.rho;

	};

~magz4 = (90*~time).collect{
pl5=pl5+1;
	azz=(azz+(1)).wrap(180.neg,180);

	elz=(elz+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sphz=Spherical(rad,azz.degrad*~h.[pl5],elz.degrad*~j.[pl5]);

if(
m_z.even,
mag_z=Complex(cos((sphz.phi.round(0.0000000000001)*m_z).wrap((pi/2).neg,(pi/2))),cos((sphz.phi.round(0.0000000000001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sphz.rho,
mag_z=Complex(sin((sphz.phi.round(0.0000000000001)*m_z).wrap((pi/2).neg,(pi/2))),sin((sphz.phi.round(0.0000000000001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sphz.rho
	);
	mag_z.round(0.0000000000001);
	};

}.value;

{
var  sph1,sph2,m_x=5,m_y=5,m_z=5,az1=0,el1=0,az2=0,el2=0,mag_x,mag_y,mag_z;
var azx=0,elx=0,azy=0,ely=0,azz=0,elz=0,sphx,sphy,sphz,rad=1;
var pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;


~magx5 = (90*~time).collect{
pl3=pl3+1;
	azx=(azx+(1)).wrap(180.neg,180);

	elx=(elx+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sphx=Spherical(rad,azx.degrad*~h.[pl3],elx.degrad*~j.[pl3]);

mag_x=(Complex(cos((sphx.theta.round(0.0000000000001)*m_x).wrap(pi.neg,pi)),cos((sphx.theta.round(0.0000000000001)*m_x).wrap(pi.neg,pi))).rho*
	Complex(cos((sphx.phi.round(0.0000000000001)).wrap((pi/2).neg,(pi/2))),cos((sphx.phi.round(0.0000000000001)).wrap((pi/2).neg,(pi/2)))).rho)*sphx.rho;
	mag_x.round(0.0000000000001);

	/*mag_x=(Complex(cos((sphx.theta.round(0.0000000000001)*m_x).wrap(pi.neg,pi)),cos((sphx.theta.round(0.0000000000001)*m_x).wrap(pi.neg,pi))).rho*
Complex(sin((sphx.phi.round(0.0000000000001)*(m_x-1)).wrap((pi/2).neg,(pi/2))),sin((sphx.phi.round(0.0000000000001)*(m_x-1)).wrap((pi/2).neg,(pi/2)))).rho*
Complex(cos((sphx.phi.round(0.0000000000001)).wrap((pi/2).neg,(pi/2))),cos((sphx.phi.round(0.0000000000001)).wrap((pi/2).neg,(pi/2)))).rho)*sphx.rho;
*/

	};

~magy5 = (90*~time).collect{
pl4=pl4+1;
	azy=(azy+(1)).wrap(180.neg,180);

	ely=(ely+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sphy=Spherical(rad,azy.degrad*~h.[pl4],ely.degrad*~j.[pl4]);

	mag_y=(Complex(sin((sphy.theta.round(0.0000000000001)*m_y).wrap(pi.neg,pi)),sin((sphy.theta.round(0.0000000000001)*m_y).wrap(pi.neg,pi))).rho*
		Complex(cos((sphy.phi.round(0.0000000000001)).wrap((pi/2).neg,(pi/2))),cos((sphy.phi.round(0.0000000000001)).wrap((pi/2).neg,(pi/2)))).rho)*sphy.rho;
mag_y.round(0.0000000000001);
//	mag_y=(Complex(sin((sphy.theta.round(0.0000000000001)*m_y).wrap(pi.neg,pi)),sin((sphy.theta.round(0.0000000000001)*m_y).wrap(pi.neg,pi))).rho*
//Complex(sin((sphy.phi.round(0.0000000000001)*(m_y-1)).wrap((pi/2).neg,(pi/2))),sin((sphy.phi.round(0.0000000000001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).rho*
//Complex(cos((sphy.phi.round(0.0000000000001)).wrap((pi/2).neg,(pi/2))),cos((sphy.phi.round(0.0000000000001)).wrap((pi/2).neg,(pi/2)))).rho)*sphy.rho;

	};

~magz5 = (90*~time).collect{
pl5=pl5+1;
	azz=(azz+(1)).wrap(180.neg,180);

	elz=(elz+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sphz=Spherical(rad,azz.degrad*~h.[pl5],elz.degrad*~j.[pl5]);

if(
m_z.even,
mag_z=Complex(cos((sphz.phi.round(0.0000000000001)*m_z).wrap((pi/2).neg,(pi/2))),cos((sphz.phi.round(0.0000000000001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sphz.rho,
mag_z=Complex(sin((sphz.phi.round(0.0000000000001)*m_z).wrap((pi/2).neg,(pi/2))),sin((sphz.phi.round(0.0000000000001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sphz.rho
	);
	mag_z.round(0.0000000000001);
	};

}.value;

{
var  sph1,sph2,m_x=6,m_y=6,m_z=6,az1=0,el1=0,az2=0,el2=0,mag_x,mag_y,mag_z;
var azx=0,elx=0,azy=0,ely=0,azz=0,elz=0,sphx,sphy,sphz,rad=1;
var pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;


~magx6 = (90*~time).collect{
pl3=pl3+1;
	azx=(azx+(1)).wrap(180.neg,180);

	elx=(elx+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sphx=Spherical(rad,azx.degrad*~h.[pl3],elx.degrad*~j.[pl3]);

mag_x=(Complex(cos((sphx.theta.round(0.0000000000001)*m_x).wrap(pi.neg,pi)),cos((sphx.theta.round(0.0000000000001)*m_x).wrap(pi.neg,pi))).rho*
	Complex(cos((sphx.phi.round(0.0000000000001)).wrap((pi/2).neg,(pi/2))),cos((sphx.phi.round(0.0000000000001)).wrap((pi/2).neg,(pi/2)))).rho)*sphx.rho;
	mag_x.round(0.0000000000001);

	/*mag_x=(Complex(cos((sphx.theta.round(0.0000000000001)*m_x).wrap(pi.neg,pi)),cos((sphx.theta.round(0.0000000000001)*m_x).wrap(pi.neg,pi))).rho*
Complex(sin((sphx.phi.round(0.0000000000001)*(m_x-1)).wrap((pi/2).neg,(pi/2))),sin((sphx.phi.round(0.0000000000001)*(m_x-1)).wrap((pi/2).neg,(pi/2)))).rho*
Complex(cos((sphx.phi.round(0.0000000000001)).wrap((pi/2).neg,(pi/2))),cos((sphx.phi.round(0.0000000000001)).wrap((pi/2).neg,(pi/2)))).rho)*sphx.rho;
*/

	};

~magy6 = (90*~time).collect{
pl4=pl4+1;
	azy=(azy+(1)).wrap(180.neg,180);

	ely=(ely+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sphy=Spherical(rad,azy.degrad*~h.[pl4],ely.degrad*~j.[pl4]);

	mag_y=(Complex(sin((sphy.theta.round(0.0000000000001)*m_y).wrap(pi.neg,pi)),sin((sphy.theta.round(0.0000000000001)*m_y).wrap(pi.neg,pi))).rho*
		Complex(cos((sphy.phi.round(0.0000000000001)).wrap((pi/2).neg,(pi/2))),cos((sphy.phi.round(0.0000000000001)).wrap((pi/2).neg,(pi/2)))).rho)*sphy.rho;
mag_y.round(0.0000000000001);
//	mag_y=(Complex(sin((sphy.theta.round(0.0000000000001)*m_y).wrap(pi.neg,pi)),sin((sphy.theta.round(0.0000000000001)*m_y).wrap(pi.neg,pi))).rho*
//Complex(sin((sphy.phi.round(0.0000000000001)*(m_y-1)).wrap((pi/2).neg,(pi/2))),sin((sphy.phi.round(0.0000000000001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).rho*
//Complex(cos((sphy.phi.round(0.0000000000001)).wrap((pi/2).neg,(pi/2))),cos((sphy.phi.round(0.0000000000001)).wrap((pi/2).neg,(pi/2)))).rho)*sphy.rho;

	};

~magz6 = (90*~time).collect{
pl5=pl5+1;
	azz=(azz+(1)).wrap(180.neg,180);

	elz=(elz+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sphz=Spherical(rad,azz.degrad*~h.[pl5],elz.degrad*~j.[pl5]);

if(
m_z.even,
mag_z=Complex(cos((sphz.phi.round(0.0000000000001)*m_z).wrap((pi/2).neg,(pi/2))),cos((sphz.phi.round(0.0000000000001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sphz.rho,
mag_z=Complex(sin((sphz.phi.round(0.0000000000001)*m_z).wrap((pi/2).neg,(pi/2))),sin((sphz.phi.round(0.0000000000001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sphz.rho
	);
	mag_z.round(0.0000000000001);
	};

}.value;
////////////////////////az///randomizer-difuser

{
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

raz1=Cartesian(v1.b.round(0.0001),v1.c.round(0.0001),v1.d.round(0.0001)).theta.round(0.0000000000001);
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

raz2=Cartesian(v2.b.round(0.0001),v2.c.round(0.0001),v2.d.round(0.0001)).theta.round(0.0000000000001);
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

raz3=Cartesian(v3.b.round(0.0001),v3.c.round(0.0001),v3.d.round(0.0001)).theta.round(0.0000000000001);
};

}.value;
///////////////////////el
{
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

rel1=Cartesian(v1.b.round(0.0001),v1.c.round(0.0001),v1.d.round(0.0001)).phi.round(0.0000000000001);
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

rel2=Cartesian(v2.b.round(0.0001),v2.c.round(0.0001),v2.d.round(0.0001)).phi.round(0.0000000000001);
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

rel3=Cartesian(v3.b.round(0.0001),v3.c.round(0.0001),v3.d.round(0.0001)).phi.round(0.0000000000001);
};

	}.value;
//////////////////////////////////////////////////space
(
~magx1=(~magx1/(2.sqrt)).round(0.0000000000001);
~magy1=(~magy1/(2.sqrt)).round(0.0000000000001);
~magz1=(~magz1/(2.sqrt)).round(0.0000000000001);
~magx2=(~magx2/(2.sqrt)).round(0.0000000000001);
~magy2=(~magy2/(2.sqrt)).round(0.0000000000001);
~magz2=(~magz2/(2.sqrt)).round(0.0000000000001);
~magx3=(~magx3/(2.sqrt)).round(0.0000000000001);
~magy3=(~magy3/(2.sqrt)).round(0.0000000000001);
~magz3=(~magz3/(2.sqrt)).round(0.0000000000001);
~magx4=(~magx4/(2.sqrt)).round(0.0000000000001);
~magy4=(~magy4/(2.sqrt)).round(0.0000000000001);
~magz4=(~magz4/(2.sqrt)).round(0.0000000000001);
~magx5=(~magx5/(2.sqrt)).round(0.0000000000001);
~magy5=(~magy5/(2.sqrt)).round(0.0000000000001);
~magz5=(~magz5/(2.sqrt)).round(0.0000000000001);
~magx6=(~magx6/(2.sqrt)).round(0.0000000000001);
~magy6=(~magy6/(2.sqrt)).round(0.0000000000001);
~magz6=(~magz6/(2.sqrt)).round(0.0000000000001);

~magx_array=[~magx1.round(0.00001),~magx2.round(0.00001),~magx3.round(0.00001),~magx4.round(0.00001),~magx5.round(0.00001)];
~magy_array=[~magy1.round(0.00001),~magy2.round(0.00001),~magy3.round(0.00001),~magy4.round(0.00001),~magy5.round(0.00001)];
~magz_array=[~magz1.round(0.00001),~magz2.round(0.00001),~magz3.round(0.00001),~magz4.round(0.00001),~magz5.round(0.00001)];
);
/////////////////notes and durs
{
var dur=2,ph1,ph2,ph3,ph4,ph5,ph6,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0,pl6=0;
var sph1,sph2,sph3,sph4,sph5,sph6,sph7,sph8,sph9;
var n1,n2,n3,n4,n5,n6,n7,n8,n9,mult=12;
var mag1,mag2,mag3,mag4,mag5,mag6,mag7,mag8,mag9,rythm;
var index1,index2,index3,index4,index5,index6,pl7=0,pl8=0,pl9=0,t1,t2,t3,t4,t5,t6;
var pl10=0,pl11=0,pl12=0,pl13=0,pl14=0,pl15=0;

////L-system algae variable a,b rules:a=ab b=a , n3 for n0=a
rythm=[1,1/1,1,1,1/1];

~dur1 = (45*~time).collect{
	ph1=Cartesian(~magx1.[pl1],~magy1.[pl1],~magz1.[pl1]).rho/(2.sqrt);
	index1=rythm.wrapAt(pl7);
	pl7=pl7+1;
	pl1=pl1+1;
	ph1=(ph1*dur).round(1/32);
	t1=ph1*index1;

	};

~dur2 = (45*~time).collect{
	ph2=Cartesian(~magx2.[pl2],~magy2.[pl2],~magz2.[pl2]).rho/(2.sqrt);
	index2=rythm.wrapAt(pl8);
	pl8=pl8+1;
	pl2=pl2+1;
	ph2=(ph2*dur).round(1/32);
	t2=ph2*index2;
	};

~dur3 = (45*~time).collect{
	ph3=Cartesian(~magx3.[pl6],~magy3.[pl3],~magz3.[pl3]).rho/(2.sqrt);
	index3=rythm.wrapAt(pl9);
	pl9=pl9+1;
	pl3=pl3+1;
	ph3=(ph3*dur).round((1/32));
	t3=ph3*index3;
	};

~dur4 = (45*~time).collect{
	ph4=Cartesian(~magx4.[pl10],~magy4.[pl10],~magz4.[pl10]).rho/(2.sqrt);
	index4=rythm.wrapAt(pl11);
	pl11=pl11+1;
	pl10=pl10+1;
	ph4=(ph4*dur).round((1/32));
	t4=ph4*index4;
	};
~dur5 = (45*~time).collect{
	ph5=Cartesian(~magx5.[pl12],~magy5.[pl12],~magz5.[pl12]).rho/(2.sqrt);
	index5=rythm.wrapAt(pl13);
	pl13=pl13+1;
	pl12=pl12+1;
	ph5=(ph5*dur).round((1/32));
	t5=ph5*index5;
	};

~dur6 = (45*~time).collect{
	ph6=Cartesian(~magx6.[pl14],~magy6.[pl14],~magz6.[pl14]).rho/(2.sqrt);
	index6=rythm.wrapAt(pl9);
	pl15=pl15+1;
	pl14=pl14+1;
	ph6=(ph6*dur).round((1/32));
	t6=ph6*index6;
	};



~nx = (45*~time).collect{
	//mag1=Cartesian(~magx1.[pl4],~magy1.[pl4],~magz1.[pl4]).rho/(2.sqrt);
	mag1=1;
	sph1=Spherical(mag1*mult,~az.[pl4],~el.[pl4]).x;
	pl4=pl4+1;
	n1=(sph1).round(0.000000001);
	};

~ny = (45*~time).collect{
	//mag2=Cartesian(~magx1.[pl5],~magy1.[pl5],~magz1.[pl5]).rho/(2.sqrt);
	mag2=1;
	sph2=Spherical(mag2*mult,~az.[pl5],~el.[pl5]).y;
	pl5=pl5+1;
	n2=(sph2).round(0.000000001);
	};

~nz = (45*~time).collect{
	//mag3=Cartesian(~magx1.[pl6],~magy1.[pl6],~magz1.[pl6]).rho/(2.sqrt);
	mag3=1;
	sph3=Spherical(mag3*mult,~az.[pl6],~el.[pl6]).z;
	pl6=pl6+1;
	n3=(sph3).round(0.000000001);
};
}.value;

///////////////////////////wt envelope sine levels
	// (
	// 	var ang=0,level,levels,env,pl;
	// 	~levels=180.collect{ level=exp(Complex(0,1)*ang).imag; ang=ang+1.degrad;
	// 	levels=level.rrand(exp(Complex(0,1)*ang+((360-(360/1.6180339887499))/10).degrad).imag);};
	// )

//Env(~levels,[0.02222]).plot;
////perc
{
 var ang=0,level,levels,env,pl;
 ~levels=90.collect{ level=exp(Complex(0,1)*ang).real; ang=ang+1.degrad;
 levels=level.rrand(exp(Complex(0,1)*ang+((360-(360/1.6180339887499))/100).degrad).real);};
 ~levels=[0]++~levels;
	}.value;
//Env(~levels,[0.04444]).plot;


/////////////////////////////rotations
{
var freq=1,ph1,ph2,ph3,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0,pl6=0,sph1,sph2,sph3,n1,n2,n3;
var mag1,mag2,mag3,rythm,index1,index2,index3,pl7=0,pl8=0,pl9=0,t1,t2,t3;


~rot_speed = (45*~time).collect{
	ph1=Cartesian((~magx/(2.sqrt)).[pl1],(~magy/(2.sqrt)).[pl1],(~magz/(2.sqrt)).[pl1]).rho/(2.sqrt);
	pl1=pl1+1;
	ph1=(ph1).round(0.0000000000001);

	};

}.value;
~rot_speed=~rot_speed.scramble;
	);
/////synth////
(
SynthDef.new(\ospace1, {
	arg  n1=1,n2=1,n3=1,fund=55,octave=2,cutt=10,rpr=1,speed=10,decay=0.04444;
	var phase,osc1,osc2,osc3,sphere,mag_o,amp1,amp2,amp3;
	var ton1,ton2,ton3,pl=0,pl1=0,pl2=0,rq1=1,rq2=1,rq3=1,cutt_freq1=1,cutt_freq2=1,cutt_freq3=1;
	var fundamental=64*(speed.reciprocal);
	var freq,m=2,bank1=2,bank2=6,pitch1,pitch2,pitch3,env,gate=1;

	var wrappedOut1 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut2 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut3 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
var out1 = NamedControl.kr(\out1, [0, 1, 2, 3]);  // multiple buses!
	var out2 = NamedControl.kr(\out2, [0, 1, 2, 3]);  // multiple buses!
	var out3 = NamedControl.kr(\out3, [0, 1, 2, 3]);  // multiple buses!

ton1=2.pow(n1/(2*6));
ton2=2.pow(n2/(2*6));
ton3=2.pow(n3/(2*6));
freq=(fundamental*octave);

bank1.do{

bank2.do{

mag_o=Cartesian(~magx_array.[pl2].[pl1], ~magy_array.[pl2].[pl1], ~magz_array.[pl2].[pl1]);

	//sphere=Spherical(mag_o.rho.round(0.0000000000001)/(2.sqrt),~az_x.[pl1],~el_x.[pl1]);
			sphere=Spherical(mag_o.rho.round(0.0000000000001)/(2.sqrt),~az.[pl1],~el.[pl1]);

			//phase=(exp(Complex(0,1)*(mag_o.theta))*exp(Complex(0,1)*(mag_o.phi))).theta;
phase=2pi;
	    amp1=(ton1.reciprocal*speed*octave.reciprocal*m.reciprocal).round(0.0000000000001);
		amp2=(ton2.reciprocal*speed*octave.reciprocal*m.reciprocal).round(0.0000000000001);
		amp3=(ton3.reciprocal*speed*octave.reciprocal*m.reciprocal).round(0.0000000000001);

	pitch1=(freq*ton1*m).round(0.0000000000001);
	pitch2=(freq*ton2*m).round(0.0000000000001);
	pitch3=(freq*ton3*m).round(0.0000000000001);

env=EnvGen.ar(Env(~levels,[decay],4.neg),doneAction:2,levelScale:1/10);

		cutt_freq1=(freq*ton1*m).round(0.0000000000001);
		cutt_freq2=(freq*ton2*m).round(0.0000000000001);
		cutt_freq3=(freq*ton3*m).round(0.0000000000001);

osc1=VBAP.ar(4,
				LeakDC.ar(Osc.ar(~t.bufnum,pitch1,mul:amp1,phase:(sphere.x*phase).mod(2pi))),
~b.bufnum,
Osc.ar(~t.bufnum,rpr,phase:sphere.theta.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
Osc.ar(~t.bufnum,rpr,phase:sphere.phi.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)
		);
osc2=VBAP.ar(4,
				LeakDC.ar(Osc.ar(~t.bufnum,pitch2,mul:amp2,phase:(sphere.y*phase).mod(2pi))),
~b.bufnum,
Osc.ar(~t.bufnum,rpr,phase:sphere.theta.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
Osc.ar(~t.bufnum,rpr,phase:sphere.phi.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)
		);
osc3=VBAP.ar(4,
				LeakDC.ar(Osc.ar(~t.bufnum,pitch3,mul:amp3,phase:(sphere.z*phase).mod(2pi))),
~b.bufnum,
Osc.ar(~t.bufnum,rpr,phase:sphere.theta.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
Osc.ar(~t.bufnum,rpr,phase:sphere.phi.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)
		);

			wrappedOut1.value(out1,LeakDC.ar(LPF.ar(osc1,cutt_freq1),mul:env));
		wrappedOut2.value(out2,LeakDC.ar(LPF.ar(osc2,cutt_freq2),mul:env));
		wrappedOut3.value(out3,LeakDC.ar(LPF.ar(osc3,cutt_freq3),mul:env));
		//	Out.ar(0,LeakDC.ar(LeakDC.ar(LPF.ar(osc1,cutt_freq1),mul:env)));
		//	Out.ar(0,LeakDC.ar(LeakDC.ar(LPF.ar(osc2,cutt_freq2),mul:env)));
		//	Out.ar(0,LeakDC.ar(LeakDC.ar(LPF.ar(osc3,cutt_freq3),mul:env)));
			pl1=pl1+1;
	};
			pl2=pl2+1;
		m=m+2;
			};
}).add;
);

(
MIDIClient.init;
MIDIIn.connectAll;

MIDIdef.noteOn(\note, { |val, num, chan, src|
	[val, num, chan, src].postln;
	if(num < 61) {
		num = num - 1
	};
			~a=Synth(\ospace1, [n1: num - 60 ,n2: num - 60, n3: num - 60, out1: [(0..3).rotate(4.rand)], out2: [(0..3).rotate(4.rand)], out3: [(0..3).rotate(4.rand)]]);

}, noteNum: (36..96));
);

	}
	)


s.record(numChannels:4);


