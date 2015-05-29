#' @importFrom parallel makeCluster
#' @importFrom doParallel registerDoParallel
#' @importFrom doMC registerDoMC
#' @export
registerCores <- function(numberCores){
  
  if (Sys.info()[['sysname']]=="Windows"){
    # Run in parallel on Windows using doParallel
    cluster <- makeCluster(numberCores)
    registerDoParallel(cluster)
  } else {
    # Run in parallel on Linux using doMC
    registerDoMC(cores=numberCores)
  }
}