import csv
import math

class reviewer:
	def __init__(self,name):
		self.name = name
		self.watched_movies={}

	def give_rating(self,movie,rating):
		if(rating!=-1):
			self.watched_movies[movie]=rating

	def display(self):
		print("Following are ratings of %s"%self.name)
		for key,value in self.watched_movies.items():
			print("%s - %s"%(key,value))
	def similarity(self,user):
		a = set(user.watched_movies.keys())
		b = set(self.watched_movies.keys())
		common_moviename = a&b
		self.commonmovies = len(common_moviename)
		mean_user = 0
		mean_self = 0
		for movie in common_moviename:
			mean_user = mean_user + user.watched_movies[movie]
			mean_self = mean_self + self.watched_movies[movie]
		mean_self = mean_self/self.commonmovies
		mean_user = mean_user/self.commonmovies
		num,den1,den2=0,0,0
		for movie in common_moviename:
			num = num + (self.watched_movies[movie]-mean_self)*(user.watched_movies[movie]-mean_user)
			den1 = den1 + (self.watched_movies[movie]-mean_self)**2
			den2 = den2 + (user.watched_movies[movie]-mean_user)**2
		if(den1*den2!=0):
			self.relation = num/math.sqrt(den1*den2)
		else:
			self.relation = 1
		self.relation = (self.relation+1)/2
	def average(self):
		return sum(self.watched_movies.values())/len(self.watched_movies)

reviewers_list = []
movies = {}
file = open("movie-ratings.csv")
reader = csv.reader(file)
data=list(reader)
for j in range(1,len(data[0])):
	movies[data[0][j]]=[]
for i in range(1,len(data)):
	reviewers_list.append(reviewer(data[i][0]))
	for j in range(1,len(data[i])):
		reviewers_list[i-1].give_rating(data[0][j],float(data[i][j]))
		movies[data[0][j]].append(reviewers_list[i-1])
file.close()
file = open("user_preference.csv")
reader = csv.reader(file)
data = list(reader)
user = reviewer("Kanak")
for i in range(len(data[0])):
	user.give_rating(data[0][i],float(data[1][i]))
for u in reviewers_list:
	u.similarity(user)
	# print(u.relation)
movie_weighted_rating={}
for movie,critics in movies.items():
	w = 0
	n = 0
	for critic in critics:
		if(movie in critic.watched_movies.keys()):
			w = w + (critic.watched_movies[movie]-critic.average())*critic.relation
			n = n + critic.relation
	w = user.average() + (w/n)
	movie_weighted_rating[movie] = w
	if(movie not in user.watched_movies.keys()):
		print("%s : %s"%(movie,movie_weighted_rating[movie]))
