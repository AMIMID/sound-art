(
s.options.numWireBufs = 1024*8;
s.options.numOutputBusChannels=8;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(1);
s.options.memSize = 8192*32;
s.options.blockSize = 64;
s.options.maxNodes = 1024 * 4;
//s.options.sampleRate= 44100;
//s.recHeaderFormat="aiff";
//s.recSampleFormat ="int16";
//s.recChannels = 8;
s.boot;
~frames=1024;
)


Buffer.freeAll
(
~c1 = Buffer.readChannel(s,"/Users/amimid/Desktop/My Movie.wav",channels:0 );
~c2 = Buffer.readChannel(s,"/Users/amimid/Desktop/My Movie.wav",channels:1 );
)

////speaker setup

///cube

(
~a = VBAPSpeakerArray.new(3,
[[45, 35.264390.neg], [135, 35.264390.neg], [45.neg, 35.264390.neg], [135.neg, 35.264390.neg],[45,35.264390],[135,35.264390],[45.neg,35.264390],[135.neg,35.264390]]);
	 ~b = Buffer.loadCollection(s, ~a.getSetsAndMatrices);
)


(
			{
var steps = 8;

~nVals = steps.collect { |i|
    i.linexp(0, steps-1, 0.18, 463).round
};
			~nVals.asInteger;
			}.value;
		)

(
SynthDef.new(\re, {
	var chain1rl,chain2rl,chain3rl,chain4rl,chain5rl,chain6rl,chain7rl,chain8rl;
	var chain1rr,chain2rr,chain3rr,chain4rr,chain5rr,chain6rr,chain7rr,chain8rr;
    var sig1rl,sig2rl,sig3rl,sig4rl,sig5rl,sig6rl,sig7rl,sig8rl;
	var sig1rr,sig2rr,sig3rr,sig4rr,sig5rr,sig6rr,sig7rr,sig8rr;
    var sph1,sph2,sph3,sph4,sph5,sph6,sph7,sph8;
	var anglex1,angley1,anglez1,anglex2,angley2,anglez2,anglex3,angley3,anglez3,anglex4,angley4,anglez4;
	var anglex5,angley5,anglez5,anglex6,angley6,anglez6,anglex7,angley7,anglez7,anglex8,angley8,anglez8;
	var frames=~frames,silver=45,golden=45,g=((1+5.sqrt)/2),s=(1+2.sqrt);
	var in1,in2,chain1,chain2,spread=83;
	var az1,el1,az2,el2,az3,el3,az4,el4,az5,el5,az6,el6,az7,el7,az8,el8;
	var pan1,pan2,pan3,pan4,pan5,pan6,pan7,pan8;

     in1 = PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1.bufnum), loop: 0, doneAction:2);
	in2 = PlayBuf.ar(1, ~c2.bufnum, BufRateScale.kr(~c2.bufnum), loop: 0, doneAction:2);

	chain1 = FFT(LocalBuf(frames), in1);
	chain2 = FFT(LocalBuf(frames), in2);

chain1rl = chain1.pvcollect(frames,
						{|mag, phase, index| [mag, (phase)]; }, frombin: ~nVals.[0], tobin: ~nVals.[0], zeroothers: 1);
chain2rl = chain1.pvcollect(frames,
						{|mag, phase, index| [mag, (phase)]; }, frombin: ~nVals.[0]+1, tobin: ~nVals.[1], zeroothers: 1);
chain3rl = chain1.pvcollect(frames,
					{|mag, phase, index| [mag, (phase)]; }, frombin: ~nVals.[1]+1, tobin: ~nVals.[2], zeroothers: 1);
chain4rl = chain1.pvcollect(frames,
					{|mag, phase, index| [mag, (phase)]; }, frombin: ~nVals.[2]+1, tobin: ~nVals.[3], zeroothers: 1);
chain5rl = chain1.pvcollect(frames,
					{|mag, phase, index| [mag, (phase)]; }, frombin: ~nVals.[3]+1, tobin: ~nVals.[4], zeroothers: 1);
chain6rl = chain1.pvcollect(frames,
					{|mag, phase, index| [mag, (phase)]; }, frombin: ~nVals.[4]+1, tobin: ~nVals.[5], zeroothers: 1);
chain7rl = chain1.pvcollect(frames,
					{|mag, phase, index| [mag, (phase)]; }, frombin: ~nVals.[5]+1, tobin: ~nVals.[6], zeroothers: 1);
chain8rl = chain1.pvcollect(frames,
					{|mag, phase, index| [mag, (phase)]; }, frombin: ~nVals.[6]+1, tobin: ~nVals.[7], zeroothers: 1);

chain1rr = chain2.pvcollect(frames,
			{|mag, phase, index| [mag, (phase)]; },  frombin: ~nVals.[0], tobin: ~nVals.[0], zeroothers: 1);
chain2rr = chain2.pvcollect(frames,
			{|mag, phase, index| [mag, (phase)]; },  frombin: ~nVals.[0]+1, tobin: ~nVals.[1], zeroothers: 1);
chain3rr = chain2.pvcollect(frames,
			{|mag, phase, index| [mag, (phase)]; }, frombin: ~nVals.[1]+1, tobin: ~nVals.[2], zeroothers: 1);
chain4rr = chain2.pvcollect(frames,
			{|mag, phase, index| [mag, (phase)]; }, frombin: ~nVals.[2]+1, tobin: ~nVals.[3], zeroothers: 1);
chain5rr = chain2.pvcollect(frames,
			{|mag, phase, index| [mag, (phase)]; }, frombin: ~nVals.[3]+1, tobin: ~nVals.[4], zeroothers: 1);
chain6rr = chain2.pvcollect(frames,
			{|mag, phase, index| [mag, (phase)]; }, frombin: ~nVals.[4]+1, tobin: ~nVals.[5], zeroothers: 1);
chain7rr = chain2.pvcollect(frames,
			{|mag, phase, index| [mag, (phase)]; }, frombin: ~nVals.[5]+1, tobin: ~nVals.[6], zeroothers: 1);
chain8rr = chain2.pvcollect(frames,
			{|mag, phase, index| [mag, (phase)]; }, frombin: ~nVals.[6]+1, tobin: ~nVals.[7], zeroothers: 1);


	sig1rl=IFFT(chain1rl);sig2rl=IFFT(chain2rl);sig3rl=IFFT(chain3rl);sig4rl=IFFT(chain4rl);
sig5rl=IFFT(chain5rl);sig6rl=IFFT(chain6rl);sig7rl=IFFT(chain7rl);sig8rl=IFFT(chain8rl);

sig1rr=IFFT(chain1rr);sig2rr=IFFT(chain2rr);sig3rr=IFFT(chain3rr);sig4rr=IFFT(chain4rr);
sig5rr=IFFT(chain5rr);sig6rr=IFFT(chain6rr);sig7rr=IFFT(chain7rr);sig8rr=IFFT(chain8rr);

	az1=LFNoise1.ar(1).range(pi,pi.neg);
	el1=LFNoise1.ar(1).range((pi/2),(pi/2).neg);
	az2=LFNoise1.ar(1).range(pi,pi.neg);
	el2=LFNoise1.ar(1).range((pi/2),(pi/2).neg);
	az3=LFNoise1.ar(1).range(pi,pi.neg);
	el3=LFNoise1.ar(1).range((pi/2),(pi/2).neg);
	az4=LFNoise1.ar(1).range(pi,pi.neg);
	el4=LFNoise1.ar(1).range((pi/2),(pi/2).neg);
	az5=LFNoise1.ar(1).range(pi,pi.neg);
	el5=LFNoise1.ar(1).range((pi/2),(pi/2).neg);
	az6=LFNoise1.ar(1).range(pi,pi.neg);
	el6=LFNoise1.ar(1).range((pi/2),(pi/2).neg);
	az7=LFNoise1.ar(1).range(pi,pi.neg);
	el7=LFNoise1.ar(1).range((pi/2),(pi/2).neg);
	az8=LFNoise1.ar(1).range(pi,pi.neg);
	el8=LFNoise1.ar(1).range((pi/2),(pi/2).neg);


	sph1=Spherical(1,az1,el1);
	sph2=Spherical(1,az2,el2);
	sph3=Spherical(1,az3,el3);
	sph4=Spherical(1,az4,el4);
	sph5=Spherical(1,az5,el5);
	sph6=Spherical(1,az6,el6);
	sph7=Spherical(1,az7,el7);
	sph8=Spherical(1,az8,el8);


anglex1=exp(Complex(0,1)*sph1.theta).real*exp(Complex(0,1)*sph1.phi).real;
angley1=exp(Complex(0,1)*sph1.theta).imag*exp(Complex(0,1)*sph1.phi).real;
anglez1=exp(Complex(0,1)*sph1.phi).imag;
anglex2=exp(Complex(0,1)*sph2.theta).real*exp(Complex(0,1)*sph2.phi).real;
angley2=exp(Complex(0,1)*sph2.theta).imag*exp(Complex(0,1)*sph2.phi).real;
anglez2=exp(Complex(0,1)*sph2.phi).imag;
anglex3=exp(Complex(0,1)*sph3.theta).real*exp(Complex(0,1)*sph3.phi).real;
angley3=exp(Complex(0,1)*sph3.theta).imag*exp(Complex(0,1)*sph3.phi).real;
anglez3=exp(Complex(0,1)*sph3.phi).imag;
anglex4=exp(Complex(0,1)*sph4.theta).real*exp(Complex(0,1)*sph4.phi).real;
angley4=exp(Complex(0,1)*sph4.theta).imag*exp(Complex(0,1)*sph4.phi).real;
anglez4=exp(Complex(0,1)*sph4.phi).imag;
anglex5=exp(Complex(0,1)*sph5.theta).real*exp(Complex(0,1)*sph5.phi).real;
angley5=exp(Complex(0,1)*sph5.theta).imag*exp(Complex(0,1)*sph5.phi).real;
anglez5=exp(Complex(0,1)*sph5.phi).imag;
anglex6=exp(Complex(0,1)*sph6.theta).real*exp(Complex(0,1)*sph6.phi).real;
angley6=exp(Complex(0,1)*sph6.theta).imag*exp(Complex(0,1)*sph6.phi).real;
anglez6=exp(Complex(0,1)*sph6.phi).imag;
anglex7=exp(Complex(0,1)*sph7.theta).real*exp(Complex(0,1)*sph7.phi).real;
angley7=exp(Complex(0,1)*sph7.theta).imag*exp(Complex(0,1)*sph7.phi).real;
anglez7=exp(Complex(0,1)*sph7.phi).imag;
anglex8=exp(Complex(0,1)*sph8.theta).real*exp(Complex(0,1)*sph8.phi).real;
angley8=exp(Complex(0,1)*sph8.theta).imag*exp(Complex(0,1)*sph8.phi).real;
anglez8=exp(Complex(0,1)*sph8.phi).imag;

	pan1=Cartesian(anglex1,angley1,anglez1);
	pan2=Cartesian(anglex2,angley2,anglez2);
	pan3=Cartesian(anglex3,angley3,anglez3);
	pan4=Cartesian(anglex4,angley4,anglez4);
	pan5=Cartesian(anglex5,angley5,anglez5);
	pan6=Cartesian(anglex6,angley6,anglez6);
	pan7=Cartesian(anglex7,angley7,anglez7);
	pan8=Cartesian(anglex8,angley8,anglez8);


Out.ar(0,VBAP.ar(8,LeakDC.ar(sig1rl),~b.bufnum,pan1.theta.raddeg,pan1.phi.raddeg,spread));
Out.ar(0,VBAP.ar(8,LeakDC.ar(sig2rl),~b.bufnum,pan2.theta.raddeg,pan2.phi.raddeg,spread));
Out.ar(0,VBAP.ar(8,LeakDC.ar(sig3rl),~b.bufnum,pan3.theta.raddeg,pan3.phi.raddeg,spread));
Out.ar(0,VBAP.ar(8,LeakDC.ar(sig4rl),~b.bufnum,pan4.theta.raddeg,pan4.phi.raddeg,spread));
Out.ar(0,VBAP.ar(8,LeakDC.ar(sig5rl),~b.bufnum,pan5.theta.raddeg,pan5.phi.raddeg,spread));
Out.ar(0,VBAP.ar(8,LeakDC.ar(sig6rl),~b.bufnum,pan6.theta.raddeg,pan6.phi.raddeg,spread));
Out.ar(0,VBAP.ar(8,LeakDC.ar(sig7rl),~b.bufnum,pan7.theta.raddeg,pan7.phi.raddeg,spread));
Out.ar(0,VBAP.ar(8,LeakDC.ar(sig8rl),~b.bufnum,pan8.theta.raddeg,pan8.phi.raddeg,spread));

Out.ar(0,VBAP.ar(8,LeakDC.ar(sig1rr),~b.bufnum,pan1.theta.raddeg,pan1.phi.raddeg,spread));
Out.ar(0,VBAP.ar(8,LeakDC.ar(sig2rr),~b.bufnum,pan2.theta.raddeg,pan2.phi.raddeg,spread));
Out.ar(0,VBAP.ar(8,LeakDC.ar(sig3rr),~b.bufnum,pan3.theta.raddeg,pan3.phi.raddeg,spread));
Out.ar(0,VBAP.ar(8,LeakDC.ar(sig4rr),~b.bufnum,pan4.theta.raddeg,pan4.phi.raddeg,spread));
Out.ar(0,VBAP.ar(8,LeakDC.ar(sig5rr),~b.bufnum,pan5.theta.raddeg,pan5.phi.raddeg,spread));
Out.ar(0,VBAP.ar(8,LeakDC.ar(sig6rr),~b.bufnum,pan6.theta.raddeg,pan6.phi.raddeg,spread));
Out.ar(0,VBAP.ar(8,LeakDC.ar(sig7rr),~b.bufnum,pan7.theta.raddeg,pan7.phi.raddeg,spread));
Out.ar(0,VBAP.ar(8,LeakDC.ar(sig8rr),~b.bufnum,pan8.theta.raddeg,pan8.phi.raddeg,spread));

}).add;
)




(
Synth(\re);
//s.record(numChannels:8,duration:(8*60));
)


