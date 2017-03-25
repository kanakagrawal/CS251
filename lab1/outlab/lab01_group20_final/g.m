function y = g(x)											%equation whose root gives the incidence angle for B2 
	data = load('input_outlab_task_A2.txt');				%taking input
	xTIE = data(1);
	yTIE = data(2);
	xWING = data(3);
	yWING = data(4);
	v2 = data(5);
	vlaser = data(6);
	d = data(7);
	w = data(8);
	n = data(9);
	t1 = data(10);
	x_initial = xWING-xTIE;
	y_initial = yWING-yTIE;

	y = x - atan(( x_initial - v2*tan(x)*(t1+((y_initial+v2*t1-w+(w*n*cos(x)/cos(asin(sin(x)/n))))/(vlaser*cos(x)-v2))) - w*tan(asin(sin(x)/n)))/(y_initial-w));
endfunction;