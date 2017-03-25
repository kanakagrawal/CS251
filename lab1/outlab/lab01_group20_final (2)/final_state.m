function output = final_state(Input,Action)
	rows = length(Input(:,1));
	columns = length(Input(1,:));
	b = [];
	for i = 1:rows
		b = [b Input(i,:)];
	end
	b = b';
	x = [];
	for i = 1:rows
		x = [x Action(i,:)];
	end
	x = x';
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
	c = A*x;				
	for n = 1:rows*columns
		c(n,1) = c(n,1) - floor(c(n,1)/2)*2;
		if(c(n,1)==1)
			if(b(n,1)==1)
				b(n,1)=0;
			else
				b(n,1)=1;
			end
		end
	end
	output=[];
	for i = 1:rows
		output = [output b((i-1)*columns+1:i*columns)];
	end
	output = output';
endfunction