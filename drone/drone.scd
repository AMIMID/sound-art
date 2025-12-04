(
({
~pell = { |n|
    var pell = [0, 1]; // start with P0 and P1
    n.do { |i|
        if (i > 1) {
            pell = pell.add(2 * pell[i - 1] + pell[i - 2]);
        };
    };
    pell.keep(n); // return the first n values
};

// Example: print the first 10 Pell numbers
~seq=1.collect{~pell.(6)}.postln;
}.value);

///fund F#/Gb 23.12Hz, 46.25Hz, 92.5Hz, 185Hz, 369.99Hz
({
	var freqa,freqb,funda=28*2.pow(6/12),fundb=28*2.pow(6.neg/12),n=0,m=(1+2.sqrt),m1,m2,m3,freq1,freq2,freq3,freq,ph,
	fund=23.12,linex,liney,golden=0,silver=0,sig1,sig2,sig3,sig;


(5).do{



	n=n+1;


		//m1=n*(1+2.sqrt);
		//m2=~seq.[0].[n];
		//m3=1+(n/(1+2.sqrt));

	ph=golden.degrad;

		linex=exp(Complex(0,1)*silver.degrad).real.wrap(0,1);   liney=exp(Complex(0,1)*silver.degrad).imag.wrap(0,1.neg);

	freqa=funda*m;
		freqb=fundb*m;
		//freq1=fund*m1;
		//freq2=fund*m2;
		//freq3=fund*m3;
		silver=(silver+(360/5)).wrap(0,360);
		golden=(golden+(360-(360/1.6180339887499))).wrap(0,360);

{sig1=SinOsc.ar(freqa,ph,m.reciprocal);Out.ar(0,Pan2.ar(sig1,linex,0.1));Out.ar(0,Pan2.ar(sig1,linex,0.1))}.play;
{sig2=SinOsc.ar(freqb,ph,m.reciprocal);Out.ar(0,Pan2.ar(sig2,linex,0.1));Out.ar(0,Pan2.ar(sig2,liney,0.1))}.play;

m=n*(1+2.sqrt);
	m.postln;

	};
s.record
}.value)
)

///make as boot file
///put low pass and high pass
//put reverb
///put midi in: 1 knob gain, 1knob fundamettnal *2.pow(n/56), 1 knob low pass 28/496, 1 knob highpass 496/8128, 1 knob reverb mix, 1 knob rewverb room size


