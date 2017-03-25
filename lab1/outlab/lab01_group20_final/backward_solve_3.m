function action = backward_solve_3(Input)
	B = [Input(1,:) Input(2,:) Input(3,:)]';				% converting input to a 9x1 matrix
	A =[ 1 1 0 1 0 0 0 0 0 ;								% 9x9 matrix A = aij, where aij = 1 if ith light is affeactionted on pressing jth light else aij = 0
		 1 1 1 0 1 0 0 0 0 ;
		 0 1 1 0 0 1 0 0 0 ;
		 1 0 0 1 1 0 1 0 0 ;
		 0 1 0 1 1 1 0 1 0 ;
		 0 0 1 0 1 1 0 0 1 ;
		 0 0 0 1 0 0 1 1 0 ;
		 0 0 0 0 1 0 1 1 1 ;
		 0 0 0 0 0 1 0 1 1 ];
	C = [A B];												% 9x10 [A|B] augmented matrix for doing row operations 
	n = 9;
	i = 1;
	while i<=n
		if(C(i,i)!=0)										% the pivot element for each row should be on the diagonal
			for j = i+1:n	
				if(C(j,i)!=0)
					C(j,:) = C(j,:) + C(j,i).*C(i,:);		% applying row operation to make all entries below pivot entries zero;
					for k = i:n+1
						C(j,k) = C(j,k) - floor(C(j,k)/2)*2; % after each row operation we can applt mod 2 to coefficients because (summation(ai1*xi))mod2 =summation((ai1mod2)*xi) 
					end
				end
			end
			i++;											% move to next row
		else
			for j = i+1:n
				if(C(j,i)!=0)								
					break;
				end
			end
			temp = C(i,:);									% exchange rows so as to maintain pivot element for each row in diagonal entries
			C(i,:) = C(j,:);
			C(j,:) = temp;
		end
	end
	action = zeros(n,1);									% defining vector to store answer
	action(n,1) = C(n,n+1);									% the last row of C after gaussian elimination will have all zeros except last to one. Hence last variable can be directly calculated
	for i = n-1:-1:1
		temp = C(i,n+1) - C(i,i+1:n)*action(i+1:n,1);		% to calculate xi, we will multiply ith row of new A(hidden in C) with x and equate to B(precaution about mod2)
		action(i,1) = temp - floor(temp/2)*2;
	end
	action = [action(1:3,1) action(4:6,1) action(7:9,1)]';	% making answer in a matrix form
endfunction