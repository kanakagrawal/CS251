function y = f(x)									%equation whose root gives the incidence angle for B1
	data = load('input_outlab_task_A1.txt');		% taking input
	x1 = data(1);
	y1 = data(2);
	d = data(3);
	w = data(4);
	n = data(5);
	y = x - atan((x1-w*tan(asin(sin(x)/n)))/(y1-w));	% applying formulae
endfunction;