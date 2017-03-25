import csv
import matplotlib.pyplot as plt
import numpy as np

a1=[]
a2=[]
a3=[]
a4=[]
a5=[]
a6=[]
with open("plot.tsv") as tsvfile:
	tsvreader = csv.reader(tsvfile, delimiter="\t")
	for line in tsvreader:
	    a1.append(line[9])
	    a2.append(line[10])
	    a3.append(line[11])
	    a4.append(line[12])
	    a5.append(line[13])
	    a6.append(line[14])
	N = len(a1)
	b1=[0,0,0,0,0]
	b2=[0,0,0,0,0]
	b3=[0,0,0,0,0]
	b4=[0,0,0,0,0]
	b5=[0,0,0,0,0]
	b6=[0,0,0,0,0]
	for i in range(1,N):
		b1[int(a1[i])-1]=b1[int(a1[i])-1]+1
		b2[int(a2[i])-1]=b2[int(a2[i])-1]+1
		b3[int(a3[i])-1]=b3[int(a3[i])-1]+1
		b4[int(a4[i])-1]=b4[int(a4[i])-1]+1
		b5[int(a5[i])-1]=b5[int(a5[i])-1]+1
		b6[int(a6[i])-1]=b6[int(a6[i])-1]+1

	x = [0.75,1.75,2.75,3.75,4.75]
	width = 0.5
	plt.bar(x, b1, width, color="blue")
	plt.xlabel('Rating', fontsize=18)
	plt.ylabel('Number of Responses', fontsize=16)
	plt.show()
	plt.bar(x, b2, width, color="red")
	plt.xlabel('Rating', fontsize=18)
	plt.ylabel('Number of Responses', fontsize=16)
	plt.show()
	plt.bar(x, b3, width, color="black")
	plt.xlabel('Rating', fontsize=18)
	plt.ylabel('Number of Responses', fontsize=16)
	plt.show()
	plt.bar(x, b4, width, color="cyan")
	plt.xlabel('Rating', fontsize=18)
	plt.ylabel('Number of Responses', fontsize=16)
	plt.show()
	plt.bar(x, b5, width, color="green")
	plt.xlabel('Rating', fontsize=18)
	plt.ylabel('Number of Responses', fontsize=16)
	plt.show()
	plt.bar(x, b6, width, color="yellow")
	plt.xlabel('Rating', fontsize=18)
	plt.ylabel('Number of Responses', fontsize=16)
	plt.show()