## IRIC： Integrated R Library for imbalanced classification
### Introduction
   There are several packages available to users which contain many techniques deal with imbalanced classification. However, there are still some algorithms are not implemented in R. Moreover, the existing techniques devoted to imbalanced classification are distributed in different R packages. These brings much inconvenience to users. In IRIC, we provide a set of implementations of 8 approaches for imbalanced classification and integrate another 10 existing popular approaches from data level, algorithm level and ensemble-based learning strategy into MM. In addition, we provide implementation of parallel of Bagging-based learning to improve the efficiency of model building. Specifically, we integrate the Bagging-based or Boosting-based models into one model separately named BalanceBagging and BalanceBoost.
### Installation
R version >= 3.1. Download the repository from GitHub before apply the techniques.
### An Example
RBBagging
### Installation
R version >= 3.1. Download the repository from GitHub before apply the techniques.
### An Example
RBBagging
#### Arguments
form: a formula, as in the lm function.
data: a data frame in which to interpret the variables named in the formula
numBag: an integer, the number of trees to use.
base: base learner
type: type of learning, one of the SMOTEBagging, RUSBagging, RBBagging. See details below.
allowParallel: whether generates subsets for base classifiers in parallel way or not. Take value true and false.
#### Details
Depending on the speciﬁed type one of the following ensemble classification methods is executed.
**SMOTEBagging**: an ensemble-based learning which embeds the SMOTE into the Bagging learning framework.
**RUSBagging**: an ensemble-based learning which embeds the random under sampling into the Bagging learning framework.
**RBBaging**: Rougly Balanced Bagging it generates the subsets for base classifier by sampling based on binominal negative distribution.
#### List of returned values
An object of class bagging, which is a list with the following components:
  call: the function used
  base: the base learner
  type: type of algorithm
  numBag: the number of trees used 
  classLabels: classLabels of training set.
  fits: the fitting result.
  class: bbag, type of ensemble learning
### Sample R code
```
#Example of RBBagging 
#Load the package caret for data partitioning library ( caret ) 
#Load data set load(”Korean.RDa”) 
#Run the script file of RBBagging 
source(”BalanceBagging.R”)
 #Data split sub<−createDataPartition (Korean$Churn,p=0.75, list=FALSE) 
trainset<−Korean [sub, ] 
testset<−Korean[−sub, ] 
#call the RBBaging for model training train 
RB<−bbagging (Churn˜. , trainset , type=”RBBagging”)
#prediction
pre RB<−predict. bbag( train RB, testset )
```


