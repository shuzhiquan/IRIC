#Copyright (C) 2018 Bing Zhu
#================================================================
# BalanceCascade
#========================================================================
# Reference
# Xu-Ying, L., W. Jianxin, et al. (2009). "Exploratory # Undersampling 
# for Class-Imbalance Learning."  Systems, Man, and Cybernetics, Part B: 
# Cybernetics, IEEE Transactions on 39(2): 539-550.
#========================================================================
BalanceCascade <-
  function(x, ...)
    UseMethod("BalanceCascade")


BalanceCascade.formula  <-
  function (form, data, iter = 4)
  {
    # Input:
    #    form: model formula
    #    data: training dataset
    #    iter: iterations to train base classifiers
    source("BalanceBoost.R")
    funcCall <- match.call(expand.dots = FALSE)
    tgt <- which(names(data) == as.character(form[[2]]))
    classTable   <- table(data[, tgt])
    classTable   <- sort(classTable, decreasing = TRUE)
    classLabels  <- names(classTable)
    indexMaj <- which(data[, tgt] == classLabels[1])
    indexMin <- which(data[, tgt] == classLabels[2])
    numMin <- length(indexMin)
    numMaj <- length(indexMaj)
    FP <- (numMin/numMaj)^(1/(iter-1))
    
    #initialization
    H      <- list()
    thresh <- rep(NA, iter)
    
    for (i in seq(iter)){
      if (length(indexMaj) < numMin)
        numMin  <- length(indexMaj)
      indexMajSampling <- sample(indexMaj, numMin)
      dataCurrent <- data[c(indexMin, indexMajSampling),]      
      H[[i]] <- bboost(form, dataCurrent, type = "AdaBoost")
      pred   <- predict(H[[i]], data[c(indexMaj), ], type ="probability") 
      sortIndex   <- order(pred[, 2], decreasing = TRUE)
      numkeep     <- round(length(indexMaj)*FP)
      thresh[i]   <- pred[sortIndex[numkeep],2]*sum(H[[i]]$alpha)   
      indexMaj    <- indexMaj[sortIndex[1:numkeep]]    
    }
    
    iter   <- sum(sapply(H,"[[", 5))
    fits   <- unlist(lapply(H,"[[", 6), recursive = FALSE) 
    alphas <- unlist(lapply(H,"[[", 7))
    
    structure(
      list( call        = funcCall   ,
            iter        = iter       ,
            classLabels = classLabels, 
            base        = H[[1]]$base,
            alphas      = alphas      ,
            fits        = fits       ,
            thresh      = sum(thresh))  ,
      class = "BalanceCascade")
    
  }

predict.BalanceCascade<-    
  function(obj, data = NULL, type = "class")
  {
    if(is.null(data)) 
      stop("please provide a data set for prediction")
    if (!type %in% c("class", "probability"))
      stop("wrong setting with type")
    classLabels <- obj$classLabels
    numClass    <- length(classLabels)
    numIns      <- dim(data)[1]
    weight      <- obj$alphas
    btPred      <- sapply(obj$fits, obj$base$pred, data = data, type ="class")    
    classfinal  <- matrix(0, ncol = numClass, nrow = numIns)
    colnames(classfinal) <- classLabels
    for (i in 1:numClass){
      classfinal[, i] <- matrix(as.numeric(btPred == classLabels[i]), nrow = numIns)%*%weight
    }
    if (type == "class")
    {
      classfinal <- classfinal - obj$thresh
      out <- factor(classLabels[apply(classfinal, 1, which.max)], levels = classLabels)
     
    } else {
      out <- data.frame(classfinal/rowSums(classfinal))  
      
    }
    out
  }








