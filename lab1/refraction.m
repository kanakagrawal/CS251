x = linspace(0,pi/2,100);						% x stores reflection angle(i)
function y = f(x)								% by Snells' Law, we could conclude that solution of this equation is the required answer
	data = load("input_inlab_task_A1.txt");
	nx = data(1);
	ny = data(2);
	y = sin(x)-(nx*cos(x)+ny*sin(x)).*sin(x/3);
	endfunction;
%plot(x,f(x));
%figure
fun = @f;
x0 = [0.0001 pi/2];
z = fzero(fun,x0);								% stores the root of f closest to x0 in z
out = fopen("output inlab task 01.txt",'w');
fdisp(out,z);									% writes ans in output file
fclose(out);
