install.packages('sas7bdat')
library('sas7bdat')
setwd("/Users/madelinecraft/Downloads/")
MSdata <- read.sas7bdat("longdata-3.sas7bdat")
head(MSdata)
summary(MSdata)
str(MSdata)
names(MSdata)
MSdata
max(MSdata$ID)
max(MSdata$YEAR)
mean(MSdata$qol, na.rm=TRUE)
sd(MSdata$qol, na.rm=TRUE)
mean(MSdata$funclim, na.rm=TRUE)
sd(MSdata$funclim, na.rm=TRUE)
mean(MSdata$exer, na.rm=TRUE)
sd(MSdata$exer, na.rm=TRUE)
sd(MSdata$funclim, na.rm=TRUE)
mean(MSdata$age, na.rm=TRUE)
sd(MSdata$age, na.rm=TRUE)


MSdata$add <-rep(0:10, times=606)
MSdata$AGE <-MSdata$age + MSdata$add
MSdata$age <- MSdata$add <- NULL

#empirical growth plots
install.packages('lattice')
library('lattice')

#random subsample
set.seed(100)
rand <- sample(1:606, 12)
rand
someID <- c(422, 539, 109, 380, 596, 79, 199, 519, 465, 494, 360, 293)
subset <- MSdata[MSdata$ID %in% someID, ]
subset

#empirical growth plots
min(subset$qol, na.rm=TRUE)
max(subset$qol, na.rm=TRUE)
#with loess lines
xyplot(qol~YEAR | ID, data=subset, 
	prepanel=function(x,y) prepanel.loess(x,y,
	family="gaussian"), 
	xlab="Measurement Occasion", ylab="Quality of Life",
	panel=function(x,y) {
	panel.xyplot(x,y) 
	panel.loess(x,y,family="gaussian")}, 								ylim=c(3,32), as.table=T)
#without loess lines
xyplot(qol~YEAR | ID, data=subset, 
	prepanel=function(x,y) prepanel.loess(x,y,
	family="gaussian"), 
	xlab="Measurement Occasion", ylab="Quality of Life",
	panel=function(x,y) {
	panel.xyplot(x,y)}, 
	ylim=c(3,32), as.table=T)
	
#interaction plot of OLS trajectories
interaction.plot(subset$YEAR, subset$ID, subset$qol, xlab='Time', ylab='Quality of Life', legend=FALSE)