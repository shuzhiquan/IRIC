#Copyright (C) 2018 Bing Zhu
# ===================================================
# SmoteENN: Smote+ENN
# ===================================================

SmoteENN<-
  function(form, data, percOver = 1400, k1 = 5, k2 = 3, allowParallel= TRUE)
    # INPUTS
    #    form: model formula
    #    data: original  dataset 
    #    percOver/100: number of new instances generated for each minority instance 
    #    k1: number of nearest neighbours 
    #    k2: number of neighbours for ENN
  {
    source("SMOTE.R")
    newData <- SMOTE(form, data, percOver, k1)
    indexENN  <- ENN(form, newData, k2,allowParallel)
    newDataRemoved <-newData[!indexENN, ]
    return(newDataRemoved)
  }


# ===================================================
#  ENN: using ENN rule to find the noisy instances
# ===================================================

ENN <-
  function(form, data, k, allowParallel)
  {
    # find column of the target 
    tgt    <- which(names(data) == as.character(form[[2]]))
    numRow  <- dim(data)[1]
    indexENN <- rep(FALSE, numRow)
    
    # transform the nominal data into  binary 
    source("Numeralize.R")
    dataTransformed <- Numeralize(data[, -tgt])
    classMode<-matrix(nrow=numRow)
    library("RANN")
    indexOrder <- nn2(dataTransformed, dataTransformed, k+1)$nn.idx
    if  (allowParallel) {
      
      classMetrix <- matrix(data[indexOrder[,2:(k+1)], tgt], nrow = numRow)
      library("parallel")
      cl <- makeCluster(2)
      classTable   <- parApply (cl, classMetrix, 1, table)
      modeColumn   <- parLapply(cl, classTable, which.max)
      classMode    <- parSapply(cl, modeColumn, names)
      stopCluster(cl)
      indexENN[data[, tgt]!= classMode] <- TRUE
    } else {
      
      for (i in 1:numRow)
      {
        classTable    <- table(data[indexOrder[i, ], tgt])
        classMode[i]  <- names(which.max(classTable))
      } 
    }
    indexENN[data[, tgt]!= classMode] <- TRUE
    return(indexENN)
  }

