

M <- list()
source("EnsembleSolution.R")

load("D:/R/RStudio/MyProject/ChurnData/UCI.RData")
M[[1]] <- EnsembleSolution(class~., Churn.data, Boost, type = "AdaBoost")

load("D:/R/RStudio/MyProject/ChurnData/Korean2.RData")
M[[2]] <- EnsembleSolution(TARGET~., Churn.data, Boost, type = "AdaBoost")

load("D:/R/RStudio/MyProject/ChurnData/Korean3.RData")
M[[3]] <- EnsembleSolution(TARGET~., Churn.data, Boost, type = "AdaBoost")

load("D:/R/RStudio/MyProject/ChurnData/Korean4.RData")
M[[4]] <- EnsembleSolution(Churn~., Churn.data, Boost, type = "AdaBoost")

load("D:/R/RStudio/MyProject/ChurnData/Korean5.RData")
levels(Churn.data[,9]) <- c("N","Y")
M[[5]] <- EnsembleSolution(TARGET~., Churn.data, Boost, type = "AdaBoost")

load("D:/R/RStudio/MyProject/ChurnData/Korean6.RData")
M[[6]] <- EnsembleSolution(TARGET~., Churn.data, Boost, type = "AdaBoost")

load("D:/R/RStudio/MyProject/ChurnData/Duke_future.RData")
Churn.data <- Churn.data_s
M[[7]] <- EnsembleSolution(churn~., Churn.data, Boost, type = "AdaBoost")

load("D:/R/RStudio/MyProject/ChurnData/Duke_current.RData")
Churn.data <- Churn.data_s
M[[8]] <- EnsembleSolution(churn~., Churn.data, Boost, type = "AdaBoost")

load("D:/R/RStudio/MyProject/ChurnData/KDD.RData")
Churn.data <- Churn.data_s
M[[9]] <- EnsembleSolution(churn~., Churn.data, Boost, type = "AdaBoost")

load("D:/R/RStudio/MyProject/ChurnData/Chile.RData")
Churn.data <- Churn.data_s
M[[10]] <- EnsembleSolution(churn~., Churn.data, Boost, type = "AdaBoost")


load("D:/R/RStudio/MyProject/ChurnData/Tele1.RData")
levels(Churn.data[,31]) <- c("N","Y")
M[[11]] <- EnsembleSolution(Churn~., Churn.data, Boost, type = "AdaBoost")


