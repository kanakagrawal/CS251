function action = backward_solve(Input)
	rows = length(Input(:,1));
	columns = length(Input(1,:));
	B = [];
	for i = 1:rows
		B = [B Input(i,:)];
	end
	B = B';
	A = zeros(rows*columns,rows*columns);
	test = zeros(rows,columns);
	for i = 1:rows
		test(i,:) = [columns*(i-1)+1:1:columns*i];
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
	C = [A B];
	n = rows*columns;
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
	ans = zeros(n,1);
	ans(n,1) = C(n,n+1);
	for i = n-1:-1:1
		temp = C(i,n+1) - C(i,i+1:n)*ans(i+1:n,1);
		ans(i,1) = temp - floor(temp/2)*2;
	end
	action=[];
	for i = 1:rows
		action = [action ans((i-1)*columns+1:i*columns)];
	end
	action = action';
endfunction