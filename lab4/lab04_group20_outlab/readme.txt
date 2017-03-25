********************************************************************************************************************************************
Group Number : 20
Group Members : (Kanak Agrawal,150050016),(Yash Wagh,150050023),(Ajay Yadav,150050056)

Honour Code :
	I, Kanak Agrawal, pledge to my honour that I have not given or taken any unauthorized assisstance in this or any previous assignment.
	I, Yash Wagh, pledge to my honour that I have not given or taken any unauthorized assisstance in this or any previous assignment.
	I, Ajay Yadav, pledge to my honour that I have not given or taken any unauthorized assisstance in this or any previous assignment.

Contribution :
	Kanak : 100%
	Yash : 40%
	Ajay : 100%
***********************************************************************************************************************************************
Task_A:
	A1.
		Commit number : 8c9333372d630bb5d4136de8cda7e7ff492a06a7
		Commit Message: Stored movie rating and took user input
	A2.
		Commands:
			git branch euclidean
			git checkout euclidean
			git add collab-filter.py
			git commit -m'Euclidean based similarity distance added'
			git checkout master
			git branch pearson
			git checkout pearson
			git add collab-filter.py
			git commit -m'Pearson correlation implemented'
			git checkout master
			git merge pearson
			git branch -d pearson		
		Commits:
		(i)
			commit number : d385b4ec1098d08abfbe62969081047104daf14e
			commit Message: Euclidean based similarity distance added
		(ii)
			commit number : bc469dca5fcaa0220eb24e7252e2af9a0eb1336b
			commit Message: Pearson correlation implemented
		(iii)	Latest commit from master:
			commit number : bc469dca5fcaa0220eb24e7252e2af9a0eb1336b
			commit Message: Pearson correlation implemented
	A3.
		commit number : 28ff06d671d8e64e6cdc5735dcfd7215ee6ac89c
		commit Message: Modified code to give movie recommendations		
***********************************************************************************************************************************************
Task_B:
	B1.		Commit number : 4068b1a6ca2f9779569de9ba8500b1ab7a40d4f5
			Commit Message: Complex number class with basic mathematical functionalities

	B2.		No, the sum function doesnot work on complexnumbers. The simple reason is the __add__method in other types like int or float are not defined to accept complexnumbers as their arguments.We can make sum function work with int and float by defining __radd__() method	and also redefining __add__()method of complexnumbers such that the argument which it gets, if it is not a complenumber then convert to complex and then add.
			//It was not asked to commit trytypes.py here. So we have commited it in the end.
	B3.		Commit on representation branch:
				Commit number : aca4b3d99d20a54c89422afa639298c5815f858c
				Commit Message: Added repr functionality to Complexnumber class
			Commit on master branch:
				Commit number : 06fd46a79a258703b99ffbde91fd031cb8e6f26f
				Commit Message: Added mysquare function
			Commit for merge:				//There was conflict so we have to commit to resolve conflict.
				Commit number : 102d960f299219c1c0f3911d3318592353660dc8
				Commit Message: Conflict Solved while merging representation
	
	B4.		Commit on electricity! branch:
				Commit number : 7b08b6fc7f7c59416112f2c6cc2a495f63e196e4
				Commit Message: a+jb is on!
			Commit on master branch:
				Commit number : 53bd6e97d4c4876b8d62c33724c1c923553d6692
				Commit Message: Algebraist's choice!
			Commit on merge solving:
				Commit number : 21a7476112ba4dadd0e1871ecc6970c79caff6ed
				Commit Message: Merge Conflict solved. Algebra retained
		Steps Taken to solve Merge Conflict:
			Open the file in any editor in which there is merge conflict.
			Git has added few lines in the file indicating where exactly is the conflict.
			Make changes in file to so as to retain one of the two cases.
			save the file
			add the file to git then commit it
	Commit while adding trytypes:
		Commit number : 6ab04e43ead8fda9dcaa851bf85b47c8cf0f1641
		Commit Message: Added trytypes.py
	Also, after doing the task we added a few more functionalities to our Complexnumber class (__invert__(),__eq__(),norm(),etc.). Here is the commit for it:
		Commit number : cfc9f30e4b00b7d3132a0bdafa91c859699e76e7
		Commit Message: Added extra functionalities to Complexnumber class
************************************************************************************************************************************************
citations:
	Read paper on below link about collaborative filtering and implemented weighted ranking as per algorithm given there.
		https://www.google.co.in/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&ved=0ahUKEwiJ59393eLOAhWIv48KHQ9tCm8QFggbMAA&url=http%3A%2F%2Fdl.acm.org%2Fft_gateway.cfm%3Fid%3D312682&usg=AFQjCNEjJfy1-mLHPYavqaBFwBXJeAE8gg&sig2=LTA59ikULG-KnPAeknoxNA&bvm=bv.131286987,d.c2I&cad=rja
************************************************************************************************************************************************
Reflection Essay:
	Pythonic Way!
		Python makes things so simple and short as compare to C++. Easy to code.