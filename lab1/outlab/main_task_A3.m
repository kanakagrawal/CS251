x = linspace(0,100,10000);

function y = pos_circle(x)
	data = load('input_outlab_task_A3.txt');
xTIE = data(1);
yTIE = data(2);
xWING = data(3);
yWING = data(4);
vTIE = data(5);
vWING = data(6);
vlaser = data(7);
d = data(8);
w = data(9);
n = data(10);
t1 = data(11);
xc = data(12);
yc = data(13);
%x_initial = xWING-xTIE;
%y_initial = yWING-yTIE;
r = sqrt((xTIE-xc)^2+(yTIE-yc)^2);
%input_circle = [r xTIE yTIE vTIE t1];
	angle = vTIE*t1/(2*pi*r);
	m1 = (yc-yTIE)/(xc-xTIE);
y(1) = r - sqrt((x(1)-xc)^2+(x(2)-yc)^2);
y(2) = tan(angle) - ((m1-((x(2)-yc)/(x(1)-xc)))/(1+m1*(x(2)-yc)/x(1)-xc));
endfunction


fun = @pos_circle;
x0 = [0,0];
out = fsolve(fun,x0)
% file_id = fopen('output_outlab_task_A3.txt','w');
% fdisp(file_id,out);
% fclose(file_id);