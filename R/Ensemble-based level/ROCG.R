#=================================================================
# ROCG: generating ROC cureve data point
#================================================================
ROCG<- 
  function(label, score)
  {
    ROC  <-list()
    source("FindLabel.R")
    num <- length(label)
    classLabel <- FindLabel(label)
    ind <- order(score, decreasing = TRUE)
    score <- score[ind]
    label <- label[ind]
    tp   <- cumsum(label == classLabel$pos)
    fp   <- cumsum(label == classLabel$neg)
    ROC$classratio <- fp[num]/tp[num]
    dups <- duplicated(score, fromLast = TRUE)
    tp   <- c(0, tp[!dups])
    fp   <- c(0, fp[!dups])
    ROC$cutoffs <- c(Inf, score[!dups])
    ROC$fpr     <- fp /sum(label == classLabel$pos)
    ROC$tpr     <- tp /sum(label == classLabel$neg)
    return(ROC)
  }