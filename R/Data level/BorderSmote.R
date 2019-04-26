# ===================================================
#  BorderLine-SMOTE
# ===================================================
# Reference:
# Han, H., W.-Y. Wang, et al. (2005). 
# "Borderline-SMOTE: a new over-sampling method in 
# imbalanced data sets learning."
# Advances in intelligent computing. Springer: 878-887.
# ---------------------------------------------------

BorderSmote <-
  function(form, data, classRatio = 1, k1 = 5, k2 = 5)
    # Input:
    #    form : a model formula
    #    data : original training set
    #    classRatio: Min Vs Maj
    #    k1:  number of nearest neighbours used to judge
    #    k2:  number of nearest neighbours in Smote 
  { 
    # the column of the class variable
    tgt  <- which(names(data) == as.character(form[[2]]))
    classTable <- table(data[, tgt])
    
    # find the minirty and majority class labels
    minCl <- names(which.min(classTable))
    majCl <- names(which.max(classTable))
    indexMin <- which(data[, tgt] == minCl)
    numMin  <- length(indexMin)  
    numMaj  <- sum(data[, tgt] == majCl)  
    
    # move the class attribute to the last column
    numRow <- dim(data)[1]
    numCol <- dim(data)[2]
    if (tgt < numCol)
    {
      cols <- 1:numCol
      cols[c(tgt, numCol)] <- cols[c(numCol, tgt)]
      data <- data[, cols]
    }
    
    # transform factors into integer
    nomatr <- c() 
    dataTransformed <- matrix(nrow = numRow, ncol = numCol-1)
    
    for (col in 1:(numCol-1))      
    {
      if (class(data[, col]) == "factor")
      {
        nomatr <- c(nomatr, col)
        dataTransformed[, col] <- as.integer(data[, col])
      }
      else dataTransformed[, col] <- data[, col] 
    } 
    
    # transform the dataset into numeric matrix  
    source("Numeralize.R")
    numerMatrix <- Numeralize(data[,  -numCol])
    indexDandger<- rep(FALSE, numMin)
    library("RANN")
    indexOrder <- nn2(numerMatrix, numerMatrix[indexMin, ], k1+1)$nn.idx
    for (i in 1:numMin)
    {
      numMajNN <- sum(data[indexOrder[i, 2:(k1+1)], numCol] == majCl)
      
      if (numMajNN < k1 & numMajNN >= round(k1/2))
      {
        indexDandger[i] <- TRUE
      }  
    }
    percOver <- round((numMaj*classRatio-numMin)/sum(indexDandger))*100
    source("SmoteExs.R")
    newExs <- SmoteExs(data[indexMin[indexDandger], ], percOver, k2)
    # move the class variable back to original position
    if (tgt < numCol) 
    {
      newExs <- newExs[, cols]
      data   <- data[, cols]
    }
    
    # unsample for the majority intances
    newData <- rbind(data, newExs)
    
    return(newData)
  }




