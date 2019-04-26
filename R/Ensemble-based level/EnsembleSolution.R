# =====================================================
#  Experimental comparision of Ensemble Learning
# =====================================================
EnsembleSolution<- 
  function(form, data, learner, type, ...)
  {
    require("caret")
    source("Numeralize.R")
    tgt <- which(names(data) == as.character(form[[2]]))
    EX<-list()
    
    for (i in 1:5)
    {
      print(i)
      #data division
      id <- createDataPartition(data[,tgt], p = 1/2, list = FALSE)
      fold1 <- data[id, ]
      fold2 <- data[-id, ]
      
      ModelFold1 <- learner$fit(form, fold1, type)
      trainingScoreFold1 <- learner$pred(ModelFold1, fold1)
      testingScoreFold1  <- learner$pred(ModelFold1, fold2)
      
      ModelFold2 <- learner$fit(form, fold2, type)
      trainingScoreFold2 <- learner$pred(ModelFold2, fold2)
      testingScoreFold2  <- learner$pred(ModelFold2, fold1)
      EX[[i]] <- 
        list(fold1Label = fold1[, tgt],
             fold2Label = fold2[, tgt],
             fold1TrainingScore = trainingScoreFold1,
             fold2TrainingScore = trainingScoreFold2,
             fold1TestingScore = testingScoreFold1,
             fold2TestingScore = testingScoreFold2      
        )
    }
    return(EX)
  }


#  Bagging

Bag <- list(
  fit = function (form, data, type) { 
    source("BalanceBagging.R")
    model  <- bbaging(form, data, type = type)
  },
  pred = function(object, data){
    out  <- predict(object, data, type = "probability") 
    out <- out[ ,2]
  }
)

# Boost
Boost<- list(
  fit = function (form, data, type) { 
    source("BalanceBoost.R")
    model  <- bboost(form, data, type = type)
  },
  pred = function(object, data){
    out  <- predict(object, data, type = "probability") 
    out <- out[ ,2]
  }
)

# BalanceCascade
BCa <- list(
  fit = function (form, data, type) { 
    source("BalanceCascade.R")
    model  <- BalanceCascade(form, data)
  },
  pred = function(object, data){
    out  <- predict(object, data, type = "probability") 
    out <- out[ ,2]
  }
)


# EasyEnsemble
Easy <- list(
  fit = function (form, data, type) { 
    source("EasyEnsemble.R")
    model  <- EasyEnsemble(form, data)
  },
  pred = function(object, data){
    out  <- predict(object, data, type = "probability") 
    out <- out[ ,2]
  }
)

# Balanced RandomForest
RF<- list(
  fit = function (form, data, type) { 
    source("BalanceRandomForest.R")
    model  <- BalanceRandomForest(form, data, type)
    return(model)
  },
  pred = function(object, data){
    out <- predict(object, data, type = "prob")
    out <- out[ ,2]
  }
)










