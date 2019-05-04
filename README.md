# IRIC： Integrated R Library for Imbalanced Classification
IRIC is an R library for imbalanced classification,  which will bring convenience to users by integrating a wide set of solutions into one library.



- [Introduction](#Introduction)
- [Installation](#Installation)
- [Examples](#Examples)

---

## Introduction
The current version of IRIC (v1.1) provides a set of 19 approaches for imbalanced classification, in which 8 approaches are new implementations in R. All these approaches can be classfied into 3 strategies: data level, algorithm level and ensemble-based strategy. In addition, we provide parallel implementations of Bagging-based soluction to improve the efficiency of model building. All approaches in IRIC are presented in the table below.
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:宋体;
	panose-1:2 1 6 0 3 1 1 1 1 1;
	mso-font-alt:SimSun;
	mso-font-charset:134;
	mso-generic-font-family:auto;
	mso-font-pitch:variable;
	mso-font-signature:3 680460288 22 0 262145 0;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;
	mso-font-charset:0;
	mso-generic-font-family:roman;
	mso-font-pitch:variable;
	mso-font-signature:-536869121 1107305727 33554432 0 415 0;}
@font-face
	{font-family:"\@宋体";
	panose-1:2 1 6 0 3 1 1 1 1 1;
	mso-font-charset:134;
	mso-generic-font-family:auto;
	mso-font-pitch:variable;
	mso-font-signature:3 680460288 22 0 262145 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-unhide:no;
	mso-style-qformat:yes;
	mso-style-parent:"";
	margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	mso-pagination:none;
	font-size:10.5pt;
	mso-bidi-font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ascii-font-family:Calibri;
	mso-ascii-theme-font:minor-latin;
	mso-fareast-font-family:宋体;
	mso-fareast-theme-font:minor-fareast;
	mso-hansi-font-family:Calibri;
	mso-hansi-theme-font:minor-latin;
	mso-bidi-font-family:"Times New Roman";
	mso-bidi-theme-font:minor-bidi;
	mso-font-kerning:1.0pt;}
.MsoChpDefault
	{mso-style-type:export-only;
	mso-default-props:yes;
	font-family:"Calibri",sans-serif;
	mso-bidi-font-family:"Times New Roman";
	mso-bidi-theme-font:minor-bidi;}
 /* Page Definitions */
 @page
	{mso-page-border-surround-header:no;
	mso-page-border-surround-footer:no;}
@page WordSection1
	{size:595.3pt 841.9pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;
	mso-header-margin:42.55pt;
	mso-footer-margin:49.6pt;
	mso-paper-source:0;
	layout-grid:15.6pt;}
div.WordSection1
	{page:WordSection1;}
-->
</style>
<body lang=ZH-CN style='tab-interval:21.0pt;text-justify-trim:punctuation'>

<div class=WordSection1 style='layout-grid:15.6pt'>

<p class=MsoNormal><span lang=EN-US style='font-family:"Arial",sans-serif;
color:#24292E'> The current version of IRIC (v1.1) provides a set of 19 approaches for imbalanced classification, in which 8 approaches are new implementations in R. All these approaches can be classified into 3 strategies: data level, algorithm level and ensemble-based strategy. In addition, we provide parallel implementations of Bagging-based solution to improve the efficiency of model building. All approaches in IRIC are presented in the table below.</span><span lang=EN-US style='font-family:"Arial",sans-serif'><o:p></o:p></span></p>

</div>

</body>



<table border=0 cellpadding=0 cellspacing=0 width=843 style='border-collapse:
 collapse;table-layout:fixed;width:632pt'>
 <col width=189 style='mso-width-source:userset;mso-width-alt:6048;width:142pt'>
 <col width=171 style='mso-width-source:userset;mso-width-alt:5472;width:128pt'>
 <col width=411 style='mso-width-source:userset;mso-width-alt:13152;width:308pt'>
 <col width=72 style='width:54pt'>
 <tr height=22 style='height:16.5pt'>
  <th height=22 class=xl70 width=189 style='height:16.5pt;width:142pt'>Strategy</th>
  <th class=xl70 width=171 style='width:128pt'>Submodule</th>
  <th class=xl70 width=411 style='width:308pt'>Method</th>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl70 style='height:16.5pt;border-top:none'>Algorithm
  level</td>
  <td class=xl70 style='border-top:none'>Cost-sensitive learning</td>
  <td class=xl70 style='border-top:none'>CSC4.5</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td rowspan=3 height=66 class=xl71 style='border-bottom:.5pt solid black;
  height:49.5pt;border-top:none'>Data level</td>
  <td class=xl66 style='border-top:none'>Oversampling</td>
  <td class=xl66 style='border-top:none'>SMOTE，MWMOTE，ADASYN，Random
  Oversampling</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl65 style='height:16.5pt'>Undersampling</td>
  <td class=xl65>CLUS，Random Undersampling</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl69 style='height:16.5pt'>Hybrid Sampling</td>
  <td class=xl69>SmoteENN, SmoteTL, SPIDER</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td rowspan=3 height=66 class=xl67 style='border-bottom:.5pt solid black;
  height:49.5pt'>Ensemble-based learning</td>
  <td class=xl65>BalanceBagging</td>
  <td class=xl65>RUSBagging, ROSBagging, RBBagging, SMOTEBagging</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl65 style='height:16.5pt'>BalanceBoost</td>
  <td class=xl65>RUSBoost, SMOTEBoost, AdaC2</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl69 style='height:16.5pt'>Hybrid Ensemble</td>
  <td class=xl69>EasyEnsemble, BalanceCascade</td>
 </tr>
</table>




## Installation
Download the code from GitHub repository before and then apply the techniques.  R version >= 3.1.
## Examples
SMOTE(Data level), CSC4.5 (Algorithm level) and RBBagging (Ensemble-based level) are presented as examples of IRIC's usage.
- [SMOTE](#SMOTE)
- [CSC4.5](#CSC4.5)
- [RBBagging](#RBBagging)
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
csc45train<-CSC45(Churn~., trainset)
csc45predict<-predict.CSC45(csc45predict, testset)
```
#### RBBagging
```
#Example of RBBagging 
#Load the package caret for data partitioning
library (caret) 
#Load data set 
load(”Korean.RDa”) 
#Run the script file of RBBagging 
source(”BalanceBagging.R”)
#Data split
sub<−createDataPartition (Korean$Churn,p=0.75, list=FALSE) 
trainset<−Korean [sub, ] 
testset<−Korean[−sub, ] 
#call the RBBaging for model training train 
RB<−bbagging (Churn˜., trainset, type=”RBBagging”)
#prediction
pre RB<−predict. bbag(RB, testset)
```


