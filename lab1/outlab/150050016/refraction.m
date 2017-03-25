x = linspace(0,pi/2,100);						% x stores reflection angle(i)
function y = f(x)								% by Snells' Law, we could conclude that solution of this equation is the required answer
	x1 = 76.63;
	y1 = 27;
	v2 = 0.027;
	vlaser = 0.0555;
	d = 7;
	w = 5;
	n = 3.5;
	t1 = 5;
	y = x - atan(( x1 - v2*tan(x)*(t1+((y1+v2*t1-w+(w*n*cos(x)/cos(asin(sin(x)/n))))/(vlaser*cos(x)-v2))) - w*tan(asin(sin(x)/n)))/(y1-w));
	endfunction;
fun = @f;
x0 = 0;
z = fzero(fun,x0);
z*180/pi