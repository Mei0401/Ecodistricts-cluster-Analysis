options(scipen=999)
# load the library
library(caret)
library(randomForest)
library(rgdal)
library(dplyr)
# load the data
sp_data <- readOGR("C:\\Users\\Mei\\OneDrive - University of Toronto\\ggr376\\a3\\ecodistricts.geojson")
raw_data <- as.data.frame(sp_data)
raw_data <- select(raw_data,-Shape_Area,-Shape_Leng) # remove usless variable


# Simple comparing correlation

# calculate correlation matrix
correlationMatrix <- cor(raw_data)
# find attributes that are highly corrected (ideally >0.75)
highlyCorrelated <- findCorrelation(correlationMatrix, cutoff=0.55)
# print indexes of highly correlated attributes
print(highlyCorrelated)
# using cor function to double check
fixed_data_cor <- raw_data[c(3,4,7,10,13,17)]
cor_mat_cor <- cor(fixed_data_cor)
corrplot::corrplot(cor_mat_cor, cl.pos = "b", tl.pos = "d")

################################################################
# Recursive Feature Elimination

# removing significant high correlation variables
veryHighlyCorrelated <- findCorrelation(correlationMatrix, cutoff=0.7)
print(veryHighlyCorrelated)
# select columns that not in the result
test_data <- raw_data[c(2,3,4,7,8,9,10,13,17)]
# define the control using a random forest selection function with cross-validation RMSE to check error
control <- rfeControl(functions=rfFuncs, method="cv", number=10)
# run the RFE algorithm
results <- rfe(test_data[,1:8], test_data[,9], sizes=c(1:6), rfeControl=control)
# summarize the results
print(results)
# list the chosen features
predictors(results)
# plot the results
plot(results, type=c("g", "o"))
# check correaltion
fixed_data_fre <- select(raw_data,EVM,LKS,EVS,HGA,RZD,AGR)
cor_mat_fre <- cor(fixed_data_fre)
corrplot::corrplot(cor_mat_fre, cl.pos = "b", tl.pos = "d")

