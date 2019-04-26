## IRIC： Integrated R Library for Imbalanced Classification
### Introduction
IRIC is an R repository which is specially used for imbalanced classification. In IRIC, we provide a set of new implementations of 8 approaches in R for imbalanced classification and integrate another 11 existing popular approaches into it. All these approaches can be classfied into 3 strategies: data level, algorithm level and ensemble-based learning strategy. In addition, we provide parallel implementations of Bagging-based learning to improve the efficiency of model building. The approaches in IRIC are presented in the table below.  The motivation of building IRIC is that we want to bring convenience to users by integrating a wide set of imbalanced calibration approaches into one library.

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
R version >= 3.1. Download the repository from GitHub before applying the techniques. The current version of IRIC is v1.1.
### Illustrative Examples
SMOTE(Data level), CSC4.5 (Algorithm level) and RBBagging (Ensemble-based level) are presented as examples of IRIC's usage.

### Sample R code


#### SMOTE
```
#Example of SMOTE
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




#### CSC4.5
```
#Example of CSC4.5 
#Training model
#load CSC4.5
source("CSC45.R")
csc45train<-CSC45(Churn~.,trainset)
csc45predict<-predict.CSC45(csc45predict,testset)
```


#### RBBagging
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


