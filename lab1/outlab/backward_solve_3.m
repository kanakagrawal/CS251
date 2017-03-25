function action = backward_solve_3(Input)
	B = [Input(1,:) Input(2,:) Input(3,:)]';
	A =[ 1 1 0 1 0 0 0 0 0 ;								% 9x9 matrix A = aij, where aij = 1 if ith light is affeactionted on pressing jth light else aij = 0
		 1 1 1 0 1 0 0 0 0 ;
		 0 1 1 0 0 1 0 0 0 ;
		 1 0 0 1 1 0 1 0 0 ;
		 0 1 0 1 1 1 0 1 0 ;
		 0 0 1 0 1 1 0 0 1 ;
		 0 0 0 1 0 0 1 1 0 ;
		 0 0 0 0 1 0 1 1 1 ;
		 0 0 0 0 0 1 0 1 1 ];
	C = [A B];
	n = 9;
	i = 1;
	while i<=n
		if(C(i,i)!=0)
			for j = i+1:n
				if(C(j,i)!=0)
					C(j,:) = C(j,:) + C(j,i).*C(i,:);
					for k = i:n+1
						C(j,k) = C(j,k) - floor(C(j,k)/2)*2;
					end
				end
			end
			i++;
		else
			for j = i+1:n
				if(C(j,i)!=0)
					break;
				end
			end
			temp = C(i,:);
			C(i,:) = C(j,:);
			C(j,:) = temp;
		end
	end
	action = zeros(n,1);
	action(n,1) = C(n,n+1);
	for i = n-1:-1:1
		temp = C(i,n+1) - C(i,i+1:n)*action(i+1:n,1);
		action(i,1) = temp - floor(temp/2)*2;
	end
	action = [action(1:3,1) action(4:6,1) action(7:9,1)]';
endfunction