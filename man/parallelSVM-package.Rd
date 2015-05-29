\name{parallelSVM-package}
\docType{package}
\title{
Parallel voting version of Support Vector Machine
}
\description{
By sampling your data, running the Support Vector Machine algorithm on these samples in parallel on your own machine and letting your models vote on a prediction, we return much faster predictions than the regular Support Vector Machine and possibly even more accurate predictions.
}
\details{
\tabular{ll}{
Package: \tab parallelSVM\cr
Type: \tab Package\cr
Version: \tab 1.0\cr
Date: \tab 2015-02-09\cr
License: \tab GPL-2\cr
}
This package consists of two main functions:
\code{\link{parallelSVM}} A function which allows you to create multiple Support Vector Machine models: one for each core you provide.  It returns a list of Support Vector Machine models.
predict: An extension of the predict function, which uses the prediction of each Support Vector Machine model.  When probability is TRUE, it returns the average of all predictions, otherwise it returns the class most models agree upon.
}
\author{
Wannes Rosiers

Maintainer: Wannes Rosiers <wannes.rosiers@infofarm.be>
}
\keyword{ package }
\seealso{
This package can be regarded as a parallel extension of \code{\link[e1071]{svm}}
}
\examples{
\dontrun{
# Create your data
data(iris)
x <- subset(iris, select = -Species)
y <- iris$Species

# Create a model
model <- parallelSVM(x, y)

# Get prediction
predictions <- predict(model, x)

# Check the quality
table(predictions,y)
}
}
