Input = [0 0 0; 1 0 1; 1 1 0];
Action = lookup_solve_3(Input);
Action
%Action = [0 0 0 ; 0 0 1 ; 1 0 0 ];
B = final_state_3(Input,Action);
B