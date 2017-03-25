Group 20

Team Members : (Kanak Agrawal,150050016),(Yash Wagh,150050023),(Ajay Yadav,150050056)

Honor Code:
I, Kanak Agrawal, pledge to my honour that I have not given or used any unauthorized assisstance in this or any previous assignment.
I, Yash Wagh, pledge to my honour that I have not given or used any unauthorized assisstance in this or any previous assignment.
I, Ajay Yadav, pledge to my honour that I have not given or used any unauthorized assisstance in this or any previous assignment.

Percentage Contribution : 
Kanak   : 100%
Yash   : 100%
Ajay   : 100%

taskD : 

ART -> Average running time

dataset		ART mergesort		ART bubblesort		ART selectionsort
input1			0.03				0.00				13.81
input2			0.03				37.70				13.79

For input1:
	From the above values we can conclude that bubblesort is the fastest for this input and selectionsort is very slow.

For input2:
	From the above values we can conclude that mergesort is the fastest for this input and bubblesort is very slow.

As a whole the time value verifies the fact that mergesort is fastest and selectionsort and bubblesort are slow(input1 has bubblesort fastest because that is the best case for bubblesort while in input2 it takes very very more time)


sequence of commands used to figure out the call graph of Merge sort:
	./mergeSort < input1.txt					###This will generate gmon.out
	gprof mergesort > mergesort_input1.txt		###This will create a .txt file containing the call graph

EXTRA CREDIT : 
	Sir asked to include the gprof file containing information about call graph. Thye file name 'sort.txt' is that file. Also there were many functions in sort call graph so sir told to draw only first 2-3 layers. So we have dispalyed only those functions which are taking significant time during execution. Also as we are submitting the 'sort.txt' along with it so we have not displayed % time in each function in call graph.