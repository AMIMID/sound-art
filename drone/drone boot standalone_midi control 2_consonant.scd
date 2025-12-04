
(
(
s.options.numWireBufs = 1024*4;
s.options.numOutputBusChannels=8;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(1);
s.options.memSize = 8192*16;
s.options.blockSize = 64;
s.options.maxNodes = 1024 * 4;
//s.options.sampleRate= 44100;
//s.recHeaderFormat="aiff";
//s.recSampleFormat ="int16";
//s.recChannels = 8;
s.boot;
MIDIClient.init;
MIDIIn.connectAll;
s.meter;
s.freqscope;
);

(
s.waitForBoot{
	Tdef(\cmrc, {
(
SynthDef.new(\drone2,{

		arg gain=1,low=7168,high=0,tone=0,mix=0,room=0,cell;
	var freqa,freqb,funda,fundb,n=0,m,ph,linex,liney,interval=2.pow(6/12),n1,n2,amp1,amp2,m1,m2,alpha;
	var goldenR=45,silverR=45,sig1,sig2,sig3,sig4,note=56*2.pow(18/12),bank=7,sig,copperR=0,out1,out2,out3,out4,fm1,fm2;


bank.do{

n1=2.pow(tone/56).round(0.0001);
//n2=2.pow((tone*(1/1))/992).round(0.0001);
n2=2.pow((tone)/992).round(0.0001);

funda=note*n1;
fundb=note*n2;
					alpha= 8;
	n=n+1;
	m1=n*interval;
	m2=n*interval;


														ph=goldenR.degrad;
linex=exp(Complex(0,1)*silverR.degrad).real.round(0.0001).abs;
liney=exp(Complex(0,1)*silverR.degrad).imag.round(0.0001).abs.neg;

	copperR=(copperR+(360/bank)).round(0.0001);
		goldenR=(goldenR+(360-(360/((1+5.sqrt)/2)))).wrap(180.neg,180).round(0.0001);
		silverR=(silverR+(360-(360/(1+2.sqrt)))).wrap(180.neg,180).round(0.0001);

	freqa=funda*m1;
	freqb=fundb*m2;

	amp1=m1.reciprocal*n1.reciprocal;
	amp2=m2.reciprocal*n2.reciprocal;

	fm1=LFNoise1.ar(amp1,amp1.reciprocal);
	fm2=LFNoise1.ar(amp2,amp2.reciprocal);


	sig1=(LPF.ar(Pulse.ar((freqa)+fm1,width:0.5,mul:amp1).abs,low/8)*SinOsc.ar((freqa/3)+fm1,ph,amp1));
	sig2=(LPF.ar(Pulse.ar((freqb)+fm2,width:0.5,mul:amp2).abs,low/8)*SinOsc.ar((freqb/3)+fm2,ph,amp2));
	sig3=(LPF.ar(Pulse.ar((freqa)+fm1+alpha,width:0.5,mul:amp1).abs,low/8)*SinOsc.ar((freqa/3)+fm1+alpha,ph,amp1));
	sig4=(LPF.ar(Pulse.ar((freqb)+fm2+alpha,width:0.5,mul:amp2).abs,low/8)*SinOsc.ar((freqb/3)+fm2+alpha,ph,amp2));

sig1=LPF.ar(sig1,low);sig2=LPF.ar(sig2,low);
sig1=HPF.ar(sig1,high);sig2=HPF.ar(sig2,high);
sig3=LPF.ar(sig3,low);sig4=LPF.ar(sig4,low);
sig3=HPF.ar(sig3,high);sig4=HPF.ar(sig4,high);

out1=FreeVerb.ar(sig1,mix,room,mul:mix*2);
out2=FreeVerb.ar(sig2,mix,room,mul:mix*2);
out3=FreeVerb.ar(sig3,mix,room,mul:mix*2);
out4=FreeVerb.ar(sig4,mix,room,mul:mix*2);

Out.ar(0,Pan2.ar(out1,linex,gain));Out.ar(0,Pan2.ar(out1,liney,gain));
Out.ar(0,Pan2.ar(out2,linex,gain));Out.ar(0,Pan2.ar(out2,liney,gain));
Out.ar(0,Pan2.ar(out3,linex,gain*room));Out.ar(0,Pan2.ar(out3,liney,gain*room));
Out.ar(0,Pan2.ar(out4,linex,gain*room));Out.ar(0,Pan2.ar(out4,liney,gain*room));
			}
}).add;);

1.wait;
	~synth1=Synth.new(\drone2,[\gain,1,\tone,56*2,\low,16256/2,\high,56,\mix,0.5,\room,0]).register;//s.record
1.wait;

	(
MIDIClient.init;
MIDIIn.connectAll;
		(
MIDIdef.cc(\midi1,{ |val, num, chan, src|
		var l;
	//[val, num, chan, src].postln;
		l=val.linlin(0,127,16256,56).round(0.0001);
		l.postln;
		if(~synth.isPlaying,{~synth.set(\low,l)});
		if(~synth1.isPlaying,{~synth1.set(\low,l)});
},25);
	);
	(
MIDIdef.cc(\midi2,{ |val, num, chan, src|
		 var h;
	//[val, num, chan, src].postln;
	h=val.linlin(0,127,56,992).round(0.0001);
		h.postln;
		if(~synth.isPlaying,{~synth.set(\high,h)});
		if(~synth1.isPlaying,{~synth1.set(\high,h)});
},24);
	);
		(
MIDIdef.cc(\midi3,{ |val, num, chan, src|
		var g;
	//[val, num, chan, src].postln;
	g=val.linlin(0,127,0,1).round(0.0001);
		g.postln;
		if(~synth.isPlaying,{~synth.set(\gain,g)});
		if(~synth1.isPlaying,{~synth1.set(\gain,g)});
},23);
	);

	(
MIDIdef.cc(\midi4,{ |val, num, chan, src|
		var m;
	//[val, num, chan, src].postln;
	m=val.linlin(0,127,0.1,1).round(0.1);
		m.postln;
		if(~synth.isPlaying,{~synth.set(\mix,m)});
		if(~synth1.isPlaying,{~synth1.set(\mix,m)});
},22);
	);
		(
MIDIdef.cc(\midi5,{ |val, num, chan, src|
		var r;
	//[val, num, chan, src].postln;
	r=val.linlin(0,127,(0.0001),1).round(0.0001);
		r.postln;
		if(~synth.isPlaying,{~synth.set(\room,r)});
		if(~synth1.isPlaying,{~synth1.set(\room,r)});
},21);
	);
					(
MIDIdef.cc(\midi6,{ |val, num, chan, src|
		var t;
	//[val, num, chan, src].postln;
		t=val.linlin(0,127,0,56*2).round(1).asInteger;
		t.postln;
		if(~synth.isPlaying,{~synth.set(\tone,t)});
		if(~synth1.isPlaying,{~synth1.set(\tone,t)});
},20);
	);

)
});
	Tdef(\cmrc).play;
}
)
)