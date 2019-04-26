#Copyright (C) 2018 Bing Zhu
#========================================================================
# EasyEnsemble
#========================================================================
# Reference
# Xu-Ying, L., W. Jianxin, et al. (2009). "Exploratory # Undersampling 
# for Class-Imbalance Learning."  Systems, Man, and Cybernetics, Part B: 
# Cybernetics, IEEE Transactions on 39(2): 539-550.
#========================================================================
EasyEnsemble <-
  function(x, ...)
    UseMethod("EasyEnsemble")

EasyEnsemble.formula <-
  function(form, data, iter = 4, allowParallel = FALSE, ...)
  {
    # Input:
    #    form: model formula
    #    data: training dataset
    #    iter: number of iterations to train 
    library(foreach)
    if (allowParallel) library(doParallel) 

    funcCall <- match.call(expand.dots = FALSE)
    tgt <- which(names(data) == as.character(form[[2]]))
    classTable   <- table(data[, tgt])
    classTable   <- sort(classTable, decreasing = TRUE)
    classLabels  <- names(classTable)
    indexMaj <- which(data[, tgt] == classLabels[1])
    indexMin <- which(data[, tgt] == classLabels[2])
    numMin <- length(indexMin)
    numMaj <- length(indexMaj)
    H      <- list()
    
    fitter <- function(form, data, indexMaj, numMin, indexMin)
    {
      source("BalanceBoost.R")
      indexMajCurrent <- sample(indexMaj, numMin)
      dataCurrent <- data[c(indexMin, indexMajCurrent),]      
      out <- bboost(form, dataCurrent, type = "AdaBoost")
    }
    if (allowParallel) {
      `%op%` <- `%dopar%`
      cl <- makeCluster(2)
      registerDoParallel(cl)
    } else {
      `%op%` <- `%do%`
    }
    H  <- foreach(i = seq(1:iter),
                      .verbose = FALSE,
                      .errorhandling = "stop") %op% fitter(form, data , indexMaj, numMin, indexMin)
    
    if (allowParallel) stopCluster(cl)
    
    iter   <- sum(sapply(H,"[[", 5))
    fits   <- unlist(lapply(H,"[[", 6), recursive = FALSE) 
    alphas <- unlist(lapply(H,"[[", 7))
    structure(
      list(call       = funcCall    ,
           iter       = iter        ,
           fits       = fits        ,
           base       = H[[1]]$base ,
           alphas     = alphas      ,
           classLabels = classLabels),
      class = "EasyEnsemble")
  }


predict.EasyEnsemble <-
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
      out <- factor(classLabels[apply(classfinal, 1, which.max)], levels = classLabels)
    } else {
      out <- data.frame(classfinal/rowSums(classfinal))
    }
    out

  }




