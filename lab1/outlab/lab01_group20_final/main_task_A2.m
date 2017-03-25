fun = @g;
x0 = pi/4;
angle = fsolve(fun,x0);					
pos = output(angle);
answer = [angle*180/pi pos];
file_id = fopen('output_outlab_task_A2.txt','w');
answer
fdisp(file_id,answer);								%printing answer in output file
fclose(file_id);