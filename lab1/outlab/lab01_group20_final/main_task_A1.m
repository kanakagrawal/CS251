fun = @f;
x0 = 0;
z = fsolve(fun,x0);									%storing angle in z in radians
z = z*180/pi;			
file_id = fopen('output_outlab_task_A1.txt','w');
fdisp(file_id,z);									%printing answer in output file
fclose(file_id);
z