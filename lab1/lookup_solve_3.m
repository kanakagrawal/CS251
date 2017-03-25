%This code uses final_state_3 function which is the solution of task B2.
%So make sure to keep that in same directory while running this.

function action = lookup_solve_3(Input)
	action = zeros(3,3);
	for j = 2:3
		temp = action;
		for i = 1:3
			if(Input(j-1,i)==1)
				action(j,i) = action(j,i) + 1;
			end
		end
		temp = action - temp;
		Input = final_state_3(Input,temp);
	end
	temp = action;
	switch Input(3,:)
	case [0 0 1],
		action(1,:) = [0 1 1];
	case [0 1 0],
		action(1,:) = [1 1 1];
	case [0 1 1],
		action(1,:) = [1 0 0];
	case [1 0 0],
		action(1,:) = [1 1 0];
	case [1 0 1],
		action(1,:) = [1 0 1];
	case [1 1 0],
		action(1,:) = [0 0 1];
	case [1 1 1],
		action(1,:) = [0 1 0];
	otherwise,
		action(1,:) = [0 0 0];
	end
	temp = action - temp;
	Input = final_state_3(Input,temp);
	for j = 2:3
		temp = action;
		for i = 1:3
			if(Input(j-1,i)==1)
				action(j,i) = action(j,i) + 1;
			end
		end
		temp = action - temp;
		Input = final_state_3(Input,temp);
	end
	for i = 1:3
		for j = 1:3
			if(floor(action(i,j)/2)==action(i,j)/2)
				action(i,j) = 0;
			else
				action(i,j) = 1;
			end
		end
	end
endfunction