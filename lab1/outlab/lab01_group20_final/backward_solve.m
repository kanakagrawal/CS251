function action = backward_solve(Input)
	rows = length(Input(:,1));
	columns = length(Input(1,:));
	B = [];
	for i = 1:rows
		B = [B Input(i,:)];								% converting input to a 1xmn matrix and taking transpose later
	end
	B = B';									
	A = zeros(rows*columns,rows*columns);
	test = zeros(rows,columns);							
	for i = 1:rows
		test(i,:) = [columns*(i-1)+1 : 1 : columns*i];		% creating a test matrix which will help in constructing matrix A(mnxmn) 
	end
	for i = 1:rows
		for j = 1:columns
			A(test(i,j),test(i,j)) = 1;
			if(i!=1)
				A(test(i-1,j),test(i,j)) = 1;
			end
			if(i!=rows)
				A(test(i+1,j),test(i,j)) = 1;
			end
			if(j!=columns)
				A(test(i,j+1),test(i,j)) = 1;
			end
			if(j!=1)
			A(test(i,j-1),test(i,j)) = 1;
			end
		end
	end
	C = [A B];											% augmented matrix for gaussian elimination row transformations
	n = rows*columns;
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
	ans = zeros(n,1);									% defining vector to store answer
	ans(n,1) = C(n,n+1);									% the last row of C after gaussian elimination will have all zeros except last to one. Hence last variable can be directly calculated
	for i = n-1:-1:1
		temp = C(i,n+1) - C(i,i+1:n)*ans(i+1:n,1);		% to calculate xi, we will multiply ith row of new A(hidden in C) with x and equate to B(precaution about mod2)
		ans(i,1) = temp - floor(temp/2)*2;
	end
	action=[];
	for i = 1:rows
		action = [action ans((i-1)*columns+1:i*columns)];	%making answer in nxm matrix whose transpose is taken later
	end
	action = action';
endfunction