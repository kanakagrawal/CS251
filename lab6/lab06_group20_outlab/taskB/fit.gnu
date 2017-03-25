f1(x)= (x *  exp( -1*(x**2) / (2*b1*b1) )     /   (b1*b1) ) + 0.05* exp( -1*(x**2) / (2*a1*a1) ) / (sqrt( 2*pi*a1*a1))
b1=11.3001;
a1=10.67;
fit f1(x) 'data.dat' using 1:2 via  b1, a1
set title 'lab06_gnuplot'
set ylabel 'y-axis'
set xlabel 'x-axis'
plot 'data.dat' title "original data" , f1(x) title "best fit"
