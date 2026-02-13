(
var data,run = true,w,b,xx,yy,zz,r;
var ot=0.degrad,sph,d=500,sc=20;


~data = [];

	xx=~controlBus_1.getSynchronous;
	yy=~controlBus_2.getSynchronous;
	zz=~controlBus_3.getSynchronous;


w = Window.new("3D Scatterplot", Rect(40,40, 800, 800)).front;

~v = UserView.new(w,Rect(0,0,800,800)).background_(Color.black);
b = ScatterView3d(~v, Rect(0,0, 800,800), ~data, [-1000, 1000].asSpec,[-1000, 1000].asSpec,[-1000, 1000].asSpec);
b.drawMethod = \fillOval;
b.symbolSize = 4;
b.symbolColor = Color.white;
b.background = Color.clear;

~v.animate;
~v.drawFunc ={
Pen.translate(400,400);


	//ot=	Cartesian(~controlBus_1.getSynchronous*sc,~controlBus_2.getSynchronous*sc,~controlBus_3.getSynchronous*sc);

	b.rot(ot,0.degrad,90.degrad+ot);
//	b.rot(ot.theta,ot.theta,ot.theta);
    ~v.refresh;
	ot=ot+(2pi/(16*(9/8)));

};

{ while { run } {~v.background_(Color.black); ~v.refresh; (1/100).wait } }.fork(AppClock);

  r= Routine({loop{

	sph=(Cartesian(d,d,d)+Cartesian(xx,yy,zz)).asSpherical;

	xx=~controlBus_1.getSynchronous*sc;
	yy=~controlBus_2.getSynchronous*sc;
	zz=~controlBus_3.getSynchronous*sc;

	~data=[[sph.x,sph.y,sph.z]];


 	b.data = ~data;            // Update ScatterView3d
0.001.wait
};

});

r.play;
)
