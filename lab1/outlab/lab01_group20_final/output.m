function y = output(angle)					% function to return relative position of X-Wing wrt TIE for a given incidence angle when laser hits X-Wing
	data = load('input_outlab_task_A2.txt');
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
	y = y_initial + v2*(t1+((y_initial+v2*t1-w+(w*n*cos(angle)/cos(asin(sin(angle)/n)))))/(vlaser*cos(angle)-v2));
	y = [x_initial y];
endfunction