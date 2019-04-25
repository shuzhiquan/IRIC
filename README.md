## IRIC： Integrated R Library for Imbalanced Classification
### Introduction
IRIC is an R repository which is specially used for imbalanced classification. In IRIC, we provide a set of implementations of 8 approaches for imbalanced classification and integrate another 11 existing popular approaches from data level, algorithm level and ensemble-based learning strategy into it. In addition, we provide implementation of parallel of Bagging-based learning to improve the efficiency of model building. Specifically, we integrate the Bagging-based or Boosting-based models into one model separately named BalanceBagging and BalanceBoost. The methods included in IRIC are presented in table below.  The motivation of implement IRIC is that though there are several packages available to users which contain many techniques deal with imbalanced classification. However, there are still some algorithms are not implemented in R. Moreover, the existing techniques devoted to imbalanced classification are distributed in different R packages. These brings much inconvenience to users.

   <table>
    <tr>
    <th>Strategy</th>
    <th>Methods</th>
    </tr>
    <tr>
    <td> Algorithm level </td>
    <td>CSC4.5</td>
    </tr>
    <tr>
      <td> Data level </td>
       <td> ADASYN, CLUS, SMOTE, MWMOTE, Random Over/Undersampling, SPIDER, SmoteENN, SmoteTL </td>
       </tr>
   <tr>
      <td> Ensemble-based learning </td>
      <td> AdaC2, RUSBagging, ROSBagging, RBBagging, SMOTEBagging, RUSBoost, SMOTEBoost, EasyEnsemble, BalanceCascade</td>
      </tr>
   </table>
   
### Installation
R version >= 3.1. Download the repository from GitHub before apply the techniques. The current version of IRIC is v1.1.
### Illustrative Examples
SMOTE, CSC4.5 and RBBagging 

### Sample R code

```
   #Example of SMOTE sampling
   #Load the package caret for data partitioning
   library(caret)
   #Load data set
   load("Korean.RDa")
   #Run the script file of SMOTE
   source("SMOTE.R")
   #data split
   sub<-createDataPartition(Korean$Churn,p=0.75,list=FALSE)
   #Training set without sampling
   trainset<-Korean[sub,]
   testset<-Korean[-sub,]
   #view the class ratio of the training set
   table(trainset$Churn)
   #call the SMOTE
   newtrainset<-SMOTE(Churn~.,trainset) 
   #view the class ratio of the new training set
   table(newtrain$Churn)  
```





```
#Example of CSC4.5 
#Training model
#load CSC4.5
source("CSC45.R")
csc45train<-CSC45(Churn~.,trainset)
csc45predict<-predict.CSC45(csc45predict,testset)
```

```
#Example of RBBagging 
#Load the package caret for data partitioning library ( caret ) 
#Load data set load(”Korean.RDa”) 
#Run the script file of RBBagging 
source(”BalanceBagging.R”)
#Data split
sub<−createDataPartition (Korean$Churn,p=0.75, list=FALSE) 
trainset<−Korean [sub, ] 
testset<−Korean[−sub, ] 
#call the RBBaging for model training train 
RB<−bbagging (Churn˜. , trainset , type=”RBBagging”)
#prediction
pre RB<−predict. bbag( RB, testset )
```


