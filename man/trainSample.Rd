\name{trainSample}
\alias{trainSample}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Sample data in parallel
}
\description{
Sample data or data and output in parallel: each core provides one sample of your desired size.
}
\usage{
trainSample(x, y = NULL, numberCores = detectCores(), samplingSize = 0.2)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{
A data frame, or structure convertable to a data frame, which you want to sample upon.
}
  \item{y}{
An vector containing a target variable for predictions later on.  This target variable could be contained in x as well, then y is set to NULL.
}
  \item{numberCores}{
In this setting equal to number of different training samples you are creating: one for each core you are using.
}
  \item{samplingSize}{
Size of your training sample in percentage.
}
}
\value{
If y is null, you get a list of length numberCores.  Each core has created one item of your list, namely a data frame containing a a samplingSize size sample of x.
If y is not null, again you get a list of length numberCores.  Each core has created one item of your list, namely:
\item{xSample}{A data frame containing a samplingSize size sample of x.}
\item{ySample}{A vector with the corresponding y values (corresponding indices with x).}
}
\author{
Wannes Rosiers
}

\seealso{
Under the hood this function uses \code{\link[foreach]{foreach}}, and \code{\link[base]{sample}}
}

\examples{
\dontrun{
# Create your data
x <- data.frame(1:10,10:1)
y <- 1:10

# Sampling with provided y
trainSample(x,y,numberCores=2,samplingSize = 0.5)

# Sampling without provided y
trainSample(x,numberCores=2,samplingSize = 0.5)
}
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
