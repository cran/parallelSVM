\name{registerCores}
\alias{registerCores}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
registerCores
}
\description{
The registerCores function is used to register the multicore parallel backend via either the doMC or doSNOW package.
}
\usage{
registerCores(numberCores)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{numberCores}{
The number of cores to use for parallel execution. If not specified, the number of cores is set to the number of cores of your machine.
}
}
\details{
The multicore functionality, originally written by Simon Urbanek and subsumed in the parallel package in R 2.14.0, provides functions for parallel execution of R code on machines with multiple cores or processors, using the system fork call to spawn copies of the current process. The multicore functionality, and therefore registerCores, should not be used in a GUI environment, because multiple processes then share the same GUI.
}
\author{
Wannes Rosiers
}
