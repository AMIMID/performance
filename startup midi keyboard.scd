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

~b= Buffer.alloc(s,2048);

////////////////////osc

(
SynthDef.new(\synhtone,{
arg n=1,rq=0.1;
var signal1,signal2,env1,env2,pl=89,m=1,fund=55,pitch;
var pos1,pos2,ph1,ph2,mag;
var phase1,angle1=0,phase2,angle2=90;
var phase3,phase4,angle3=0,angle4=0;
var phase5,angle5=0,mag1,phase6,angle6=0,mag2;
var env,sig,wt,ang=0,level,levels;
var octave=1,freq,amp;

~levels=720.collect{
level=exp(Complex(0,1)*ang).imag;
ang=ang+1.degrad;
levels=level.rrand(exp(Complex(0,1)*ang+((1/4)/1.6180339887499)).imag);};
env = Env(~levels,[1]);sig=env.asSignal(1024);wt = sig.asWavetable;
~b.loadCollection(wt);
//sig.plot;

/*~phase1=720.collect{
phase1=exp(Complex(0,1)*angle1.degrad).theta;
angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
phase1.round(0.0001)};
~phase2=720.collect{
phase2=exp(Complex(0,1)*angle2.degrad).theta;
angle2=(angle2+(360-(360/1.6180339887499))).wrap(0,360);
phase2.round(0.0001).neg};*/

~posL=720.collect{
phase3=exp(Complex(0,1)*angle3.degrad).theta;
angle3=(angle3+(360-(360/1.6180339887499))).wrap(0,360);							phase3=(Complex(sin(phase3.round(0.0001)*m),sin(phase3.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase3.round(0.0001)*m),cos(phase3.round(0.0001)*m)).rho).round(0.0001);};

~posR=720.collect{
phase4=exp(Complex(0,1)*angle4.degrad).theta;
angle4=(angle4+(360-(360/1.6180339887499))).wrap(0,360);						phase4=(Complex(sin(phase4.round(0.0001)*m),sin(phase4.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase4.round(0.0001)*m),cos(phase4.round(0.0001)*m)).rho).round(0.0001).neg;};

~magL = 720.collect{
	phase5=exp(Complex(0,1)*angle5.degrad).theta;
	angle5=(angle5+(360-(360/1.6180339887499))).wrap(0,360);	mag1=Complex(cos(phase5.round(0.0001)*m),cos(phase5.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase5.round(0.0001)*m),cos(phase5.round(0.0001)*m)).rho.round(0.0001);};

~magR = 720.collect{
	phase6=exp(Complex(0,1)*angle6.degrad).theta;
	angle6=(angle6+(360-(360/1.6180339887499))).wrap(0,360);	mag2=Complex(sin(phase6.round(0.0001)*m),sin(phase6.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase6.round(0.0001)*m),cos(phase6.round(0.0001)*m)).rho.round(0.0001);};

			pitch=(fund*octave)*2.pow(n/12);

32.do{

		pos1=~posL.[pl]/(2.sqrt);pos2=~posR.[pl]/(2.sqrt);

		mag=Complex(~magL.[pl]/(2.sqrt),~magR.[pl]/(2.sqrt));

		//ph1=SinOsc.ar(mag.reciprocal,~phase1.[pl]);
		//ph2=SinOsc.ar(mag.reciprocal,~phase2.[pl]);

				mag=mag.round(0.00001);

				ph1=exp(Complex(0,1)*(mag.theta*90.degrad));
		ph2=exp(Complex(0,1)*mag.theta);

		amp=m.reciprocal;
		freq=pitch*amp.reciprocal;

		env1=EnvGen.ar(Env.sine(8,mag.rho/(2.sqrt)),doneAction:2);

			signal1=BPF.ar(Osc.ar(~b.bufnum,freq,ph1.theta,m.reciprocal),freq,rq);
		signal2=BPF.ar(Osc.ar(~b.bufnum,freq,ph2.theta,m.reciprocal),freq,rq);
m=m+1;
pl=pl+1;


Out.ar(0,Pan2.ar(signal1,pos1,env1));
Out.ar(0,Pan2.ar(signal2,pos2,env1))
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
	~a=Synth(\synhtone, [\n, num - 60,\rq,1]);

}, noteNum: (36..96));
);
}
)
