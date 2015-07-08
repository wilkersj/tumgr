\name{sampleData}
\alias{sampleData}
\docType{data}
\title{
Example Patient Tumor Data
}
\description{
Sample of control arm data for package examples from a phase 3, randomized, open-label study evaluating DN-101 in combination with Docetaxel in androgen-independent prostate cancer (AIPC) (ASCENT-2).  The data was obtained from Project Data Sphere (sponsor Novacea, Inc).
}
\usage{data("sampleData")}
\format{
  A data frame with 1250 observations on the following 3 variables.
  \describe{
    \item{\code{name}}{a numeric vector uniquely identifying patient}
    \item{\code{date}}{a numeric vector for the date of measurement}
    \item{\code{size}}{a numeric vector for the measurement}
  }
}
%%\details{
%%}
\source{
Project Data Sphere (sponsor Novacea, Inc). \url{https://www.projectdatasphere.org/projectdatasphere/html/content/89}
}
%%\references{
%%  ~~ possibly secondary sources and usages ~~
%%}
\examples{
data(sampleData)
%%%%## maybe str(sampleData) ; plot(sampleData) ...
}
\keyword{datasets}
