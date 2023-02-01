#Masterfile from Rao et al_2023_transects.csv 
#For more details on data formats, refer to Miller et al. (2019)
data<- read.csv("data.csv")
head(data, n=2)
tail(data,n=2)
summary(data$distance)
hist(data$distance, xlab="Distance (m)")
library(Distance)
#To different detection functions, change the key and adjustment arguments.
#Try multiple models, truncation for bettter fit. For more details, refer to Miller et al. 2019)
Cong.model1<-ds(data, key="hn", adjustment="cos",convert.units=0.001)
summary(Cong.model1)
Cong.model2<- ds(data, key="unif", adjustment="cos", convert.units= 0.001)
summary(Cong.model2)
Cong.model3<- ds(data, key="hr", adjustment="poly", convert.units= 0.001)
summary(Cong.model3)
#Plot the detection function with the histogram having 12 bins:
plot(Cong.model1, n=4)
plot(Cong.model2, n=4)
plot(Cong.model3, n=4)

#Goodness of Fit
gof_ds(Cong.model1)
gof_ds(Cong.model2)
gof_ds(Cong.model3)
