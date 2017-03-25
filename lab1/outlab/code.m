Input=[ 0 0 0 1 0 1 1; 
		1 0 1 0 1 1 0; 
		1 1 0 1 1 0 1;
		0 0 0 1 0 0 0;
		1 1 1 0 1 0 1;
		0 0 0 0 0 0 1];
Action = backward_solve(Input)
% Action = backward_solve_3(Input);
 B = final_state(Input,Action);
B
