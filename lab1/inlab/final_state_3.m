function output = final_state_3(Initial,Action)
	b = [Initial(1,:) Initial(2,:) Initial(3,:)]';			% b is a 9x1 matrix of initial state of lights(9 different lights are marked 1 to 9 row by row)
	x = [Action(1,:) Action(2,:) Action(3,:)]';				% x is a 9x1 matrix of action on the lights
	A = [    1 1 0 1 0 0 0 0 0 ];								% 9x9 matrix A = aij, where aij = 1 if ith light is affected on pressing jth light else aij = 0
	A = [A ; 1 1 1 0 1 0 0 0 0 ];
	A = [A ; 0 1 1 0 0 1 0 0 0 ];
	A = [A ; 1 0 0 1 1 0 1 0 0 ];
	A = [A ; 0 1 0 1 1 1 0 1 0 ];
	A = [A ; 0 0 1 0 1 1 0 0 1 ];
	A = [A ; 0 0 0 1 0 0 1 1 0 ];
	A = [A ; 0 0 0 0 1 0 1 1 1 ];
	A = [A ; 0 0 0 0 0 1 0 1 1 ];
	c = A*x;												% c contains the entire effect of action on the lights,i.e, if ci1 = 3 then ith light was affected thrice
	for n = 1:9
		if(floor(c(n,1)/2)==c(n,1)/2)						% Since '%' operator can't be used for mod 2, floor function of octave was used
			c(n,1) = 0;
		else
			c(n,1) = 1;
		end
	end
	for n = 1:9
		if(c(n,1)==1)										% for lights which have to be changed either on or off are done
			if(b(n,1)==1)
				b(n,1)=0;
			else
				b(n,1)=1;
			end
		end
	end
	output = [b(1:3,1) b(4:6,1) b(7:9,1)]';					% required output is a 3x3 matrix
endfunction