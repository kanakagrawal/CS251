%This code uses final_state_3 function which is the solution of task B2.
%So make sure to keep that in same directory while running this.

function action = lookup_solve_3(Input)
	action = zeros(3,3);							% action has been initialized to 0 and during algorithm whenever a button is pressed its value is incremented
	for j = 2:3
		temp = action;								% temp stores the value of action during start of iterating each row
		for i = 1:3
			if(Input(j-1,i)==1)
				action(j,i) = action(j,i) + 1;
			end
		end
		temp = action - temp;						% after this expression temp stores the buttons pressed during iterating this row 
		Input = final_state_3(Input,temp);			% changes pressed during this row are executed on input using final_state_3 function
	end
	temp = action;							
	switch Input(3,:)								% lookup table is used as per given algorithm
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
	Input = final_state_3(Input,temp);			% changes pressed during this row are executed on input using final_state_3 function
	for j = 2:3									% the process above is repeated
		temp = action;
		for i = 1:3
			if(Input(j-1,i)==1)
				action(j,i) = action(j,i) + 1;
			end
		end
		temp = action - temp;
		Input = final_state_3(Input,temp);
	end
	for i = 1:3									% button pressed twice is same as not pressed.
		for j = 1:3
			if(floor(action(i,j)/2)==action(i,j)/2)	
				action(i,j) = 0;
			else
				action(i,j) = 1;
			end
		end
	end
endfunction