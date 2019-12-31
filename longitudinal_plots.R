# Install packages
install.packages('sas7bdat')
library('sas7bdat')
install.packages('lattice')
library('lattice')

# Read in data
setwd("/Users/madelinecraft/Downloads/")
MSdata <- read.sas7bdat("longdata-3.sas7bdat")

# Create random subsample of individuals for plotting
set.seed(100)
rand <- sample(1:606, 12)
someID <- c(422, 539, 109, 380, 596, 79, 199, 519, 465, 494, 360, 293)
subset <- MSdata[MSdata$ID %in% someID, ]

# Empirical growth plots 
######################################
# with loess lines
xyplot(qol~YEAR | ID, data=subset, 
	prepanel=function(x,y) prepanel.loess(x,y,
	family="gaussian"), 
	xlab="Measurement Occasion", ylab="Quality of Life",
	panel=function(x,y) {
	panel.xyplot(x,y) 
	panel.loess(x,y,family="gaussian")}, 
        ylim=c(3,32), as.table=T)
# without loess lines
xyplot(qol~YEAR | ID, data=subset, 
	prepanel=function(x,y) prepanel.loess(x,y,
	family="gaussian"), 
	xlab="Measurement Occasion", ylab="Quality of Life",
	panel=function(x,y) {
	panel.xyplot(x,y)}, 
	ylim=c(3,32), as.table=T)
	
# Interaction (spaghetti) plot of OLS trajectories
##################################################
interaction.plot(subset$YEAR, subset$ID, subset$qol, xlab='Time', ylab='Quality of Life', legend=FALSE)
