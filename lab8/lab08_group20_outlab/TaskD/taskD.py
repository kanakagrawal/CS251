import matplotlib.pyplot as plt
x=[]
y=[]
resx1=[]
resx2=[]
resy1=[]
resy2=[]
with open('Mines') as data:
	for line in data:
		parts = line.split()
		if(int(parts[0])%2==int(parts[1])%2):
			resx1.append(int(parts[0]))
			resy1.append(int(parts[1])) 
		else:
			resx2.append(int(parts[0]))
			resy2.append(int(parts[1])) 
fig = plt.figure()
a = fig.add_subplot(111)
a.scatter(resx2, resy2, s=5, c="red", alpha = 0.5)
a.scatter(resx1, resy1, s=5, c="green", alpha = 1)
# plt.show()
plt.savefig('TaskD.png')