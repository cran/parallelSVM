\name{parallelSVM}
\alias{parallelSVM}
\alias{parallelSVM.default}
\alias{parallelSVM.formula}
\alias{summary.parallelSVM}
\alias{print.parallelSVM}
\encoding{UTF-8}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Parallel-voting version of Support-Vector-Machine
}
\description{
By sampling your data, running the Support-Vector-Machine algorithm on these samples in parallel on your own machine and letting your models vote on a prediction, we return much faster predictions than the regular Support-Vector-Machine and possibly even more accurate predictions.
}
\usage{
## S3 method for class 'formula'
\method{parallelSVM}{formula}(formula, data= NULL, numberCores = detectCores(),
			samplingSize = 0.2, ..., 
			subset, na.action = na.omit, scale = TRUE)
## Default S3 method
\method{parallelSVM}{default}(x, y = NULL, numberCores = detectCores(), 
			samplingSize = 0.2, scale = TRUE, type = NULL, 
			kernel = "radial", degree = 3, 
			gamma = if (is.vector(x)) 1 else 1/ncol(x), 
			coef0 = 0, cost = 1, nu = 0.5, class.weights = NULL, 
			cachesize = 40, tolerance = 0.001, epsilon = 0.1, 
			shrinking = TRUE, cross = 0, probability = FALSE, 
			fitted = TRUE, seed = 1L, ..., subset, na.action = na.omit)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
	\item{formula}{
a symbolic description of the model to be fit
}
  \item{data}{
An optional data frame containing the variables in the model. By default the variables are taken from the environment which 'svm' is called from.
}
  \item{x}{
A data matrix, a vactor ar a sparse matrix.
}
  \item{y}{
A response vector with one label for each row/component of x. Can be either a factor (for calssification tasks) or a numeric vector (for regression).
}
  \item{numberCores}{
Number of cores of your machine you want to use.  Is set equal to the number of samples you take.
}
  \item{samplingSize}{
Size of your data or of x you will take in each sample.
}
  \item{scale}{
A logical vector indicating the variables to be scaled. If scale is of length 1, the value is recycled as many times as needed. Per default, data are scaled internally (both x and y variables) to zero mean and unit variance. The center and scale values are returned and used for later predictions.
}
  \item{type}{
Support-Vector-Machine can be used as a classification machine, as a regression machine, or for novelty detection. Depending of whether y is a factor or not, the default setting for type is C-classification or eps-regression, respectively, but may be overwritten by setting an explicit value.
Valid options are:
	- C-classification
	- nu-classification
	- one-classification (for novelty detection)
	- eps-regression 
	- nu-regression

}
  \item{kernel}{
the kernel used in training and predicting. You might consider changing some of the following parameters, depending on the kernel type.
	- linear
	- polynomial
	- radial basis
	- sigmoid
}
  \item{degree}{
parameter needed for kernel of type polynomial (default: 3)
}
  \item{gamma}{
parameter needed for all kernels except linear (default: 1/(data dimension))
}
  \item{coef0}{
parameter needed for kernels of type polynomial and sigmoid (default: 0)
}
  \item{cost}{
cost of constraints violation (default: 1)—it is the ‘C’-constant of the regularization term in the Lagrange formulation.
}
  \item{nu}{
parameter needed for nu-classification, nu-regression, and one-classification
}
  \item{class.weights}{
a named vector of weights for the different classes, used for asymmetric class sizes. Not all factor levels have to be supplied (default weight: 1). All components have to be named.
}
  \item{cachesize}{
cache memory in MB (default 40)
}
  \item{tolerance}{
tolerance of termination criterion (default: 0.001)
}
  \item{epsilon}{
epsilon in the insensitive-loss function (default: 0.1)
}
  \item{shrinking}{
option whether to use the shrinking-heuristics (default: TRUE)
}
  \item{cross}{
if a integer value k>0 is specified, a k-fold cross validation on the training data is performed to assess the quality of the model: the accuracy rate for classification and the Mean Squared Error for regression
}
  \item{probability}{
logical indicating whether the model should allow for probability predictions.
}
  \item{fitted}{
logical indicating whether the fitted values should be computed and included in the model or not (default: TRUE)
}
  \item{seed}{
integer seed for libsvm (used for cross-validation and probability prediction models).
}
  \item{\dots}{
additional parameters for the low level fitting function svm.default
}
  \item{subset}{
An index vector specifying the cases to be used in the training sample. (NOTE: If given, this argument must be named.)
}
  \item{na.action}{
A function to specify the action to be taken if NAs are found. The default action is na.omit, which leads to rejection of cases with missing values on any required variable. An alternative is na.fail, which causes an error if NA cases are found. (NOTE: If given, this argument must be named.)
}
}
\value{
A list containing of numberCores Support Vector Machine models.
}
\author{
Wannes Rosiers
}
\note{
Usage is just like \code{\link[e1071]{svm}}, the only difference is the numberCores you want to use (equal to the number of models you build), and the sampleSize (the size of the sample you want to use to create each model)
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
This package can be regarded as a parallel extension of \code{\link[e1071]{svm}}.
}
\examples{
\dontrun{
# Load the normal svm function
library(e1071)

# Example with formula
# load trainData and testData
data(magicData)

# Calculate the model
# Here we use it on bigger data
system.time(serialSvm   <- svm(V11 ~ ., trainData[,-1], 
						probability=TRUE, cost=10, gamma=0.1))
system.time(parallelSvm <- parallelSVM(V11 ~ ., data = trainData[,-1],
						numberCores = 8, samplingSize = 0.2, 
						probability = TRUE, gamma=0.1, cost = 10))
                                       
# Calculate predictions
system.time(serialPredictions <- predict(serialSvm, testData))
system.time(parallelPredicitions <- predict(parallelSvm, testData))

# Check for quality
table(serialPredictions,testData[,"V11"])
table(parallelPredicitions,testData[,"V11"])

# Example without formula
# load data
data(iris)
x <- subset(iris, select = -Species)
y <- iris$Species

# estimate model and predict input values
system.time(model       <- parallelSVM(x, y))
system.time(serialmodel <- svm(x, y))

fitted(model)
fitted(serialmodel)

# Calculate predictions
system.time(serialPredictions <- predict(serialmodel, x))
system.time(parallelPredicitions <- predict(model, x))

# Check for quality
table(serialPredictions,y)
table(parallelPredicitions,y)
}
}
