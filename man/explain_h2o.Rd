% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/explain_h2o.R
\name{explain_h2o}
\alias{explain_h2o}
\title{Create explainer from your h2o model}
\usage{
explain_h2o(model, data = NULL, y = NULL, predict_function = NULL,
  residual_function = NULL, ..., label = NULL, verbose = TRUE,
  precalculate = TRUE)
}
\arguments{
\item{model}{object - a model to be explained}

\item{data}{data.frame or matrix - data that was used for fitting. If not provided then will be extracted from the model. Data should be passed without target column (this shall be provided as the \code{y} argument). NOTE: If target variable is present in the \code{data}, some of the functionalities my not work properly.}

\item{y}{numeric vector with outputs / scores. If provided then it shall have the same size as \code{data}}

\item{predict_function}{function that takes two arguments: model and new data and returns numeric vector with predictions}

\item{residual_function}{function that takes three arguments: model, data and response vector y. It should return a numeric vector with model residuals for given data. If not provided, response residuals (\eqn{y-\hat{y}}) are calculated.}

\item{...}{other parameters (passed for example to predict function)}

\item{label}{character - the name of the model. By default it's extracted from the 'class' attribute of the model}

\item{verbose}{if TRUE (default) then diagnostic messages will be printed}

\item{precalculate}{if TRUE (default) then 'predicted_values' and 'residuals' are calculated when explainer is created. This will happenn also if 'verbose' is TRUE.}
}
\value{
explainer object (\code{\link[DALEX]{explain}}) ready to work with DALEX
}
\description{
DALEX is designed to work with various black-box models like tree ensembles, linear models, neural networks etc.
Unfortunately R packages that create such models are very inconsistent. Different tools use different interfaces to train, validate and use models.
One of those tools, we would like to make more accessible is H2O.
}
\examples{
\donttest{
library("DALEXtra")
titanic_test <- read.csv(system.file("extdata", "titanic_test.csv", package = "DALEXtra"))
titanic_train <- read.csv(system.file("extdata", "titanic_train.csv", package = "DALEXtra"))
h2o::h2o.init()
h2o::h2o.no_progress()
titanic_h2o <- h2o::as.h2o(titanic_train)
titanic_h2o["survived"] <- h2o::as.factor(titanic_h2o["survived"])
titanic_test_h2o <- h2o::as.h2o(titanic_test)
model <- h2o::h2o.gbm(
training_frame = titanic_h2o,
y = "survived",
distribution = "bernoulli",
ntrees = 500,
max_depth = 4,
min_rows =  12,
learn_rate = 0.001
)
explain_h2o(model, titanic_test[,1:17], titanic_test[,18])
}
}
