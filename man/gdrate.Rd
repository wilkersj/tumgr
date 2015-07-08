\name{gdrate}
\alias{gdrate}
\docType{package}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Tumor Growth Rate Analysis
}
\description{
 Function to obtain tumor growth rates from clinical trial patient data. Output includes individual and summary data for tumor growth (g), decay (d) and phi (\eqn{\phi}) estimates as well as optional plots of the observed and predicted tumor quantity over time.  Tumor growth rates can be used to compare treatment efficacy and help predict overall survival in clinical trial datasets.
}
\usage{
gdrate(input, pval, plots)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{input}{
     A data frame containing patient tumor measurement data to be analyzed.  This data frame should consist of the following three columns (with respective column names):  "name" which contains a numeric value that uniquely identifies the patient for the respective row data. "date" which contains a numeric value for the day of evaluation for the respective row data, and "size" which contains the numeric value for the tumor quantity measurement (i.e., CT scan, PSA, CTN, CEA, etc.) for the respective row data.
}
  \item{pval}{
    A numerical value indicating the p-value level desired for analysis (e.g., 0.05 or 0.10).
}
  \item{plots}{
    A logical value for plot generation of the observed and predicted tumor quantity over time (use TRUE to generate plots).
}
}
\details{
The regression-growth models used to generate growth rates are based on the assumption that change in tumor quantity during therapy results from two independent component processes: an exponential decrease or regression, \emph{d}, and an exponential growth or regrowth of the tumor, \emph{g}.  The model for this is displayed below (labeled as \emph{gd}) where \emph{f(t)} is the tumor quantity at time \emph{t} in days, normalized to the tumor quantity at time 0, \emph{d} is the rate of decay, and \emph{g} is the rate of growth.
\deqn{f(t) = e^{-dt} + e^{gt} -1}
For data showing continuous decrease from the start of treatment, \emph{g} is eliminated as shown below (labeled as \emph{dx}).
\deqn{f(t) = e^{-dt}}
Similarly, \emph{d} is eliminated when data show a continuous growth from the start of treatment as shown below (labeled as \emph{gx}).
\deqn{f(t) = e^{gt}}
The fourth model (below) contains an additional parameter, \eqn{\phi}, which represents the proportion of tumor cells that undergo cell death due to therapy (labeled as \emph{gdphi}).
\deqn{f(t) = (\phi)e^{-dt} + (1-\phi){e^gt}}

The Levenberg-Marquardt algorithm is used to solve these 4 non-linear least squares problems (using package \pkg{minpack.lm}) and among models where all parameters are significant predictors (given user supplied \code{pval}), the model which minimizes the AIC is the selected model for a given patient from which tumor growth rates are obtained (this output is contained in \code{results}).

Patients with insufficient or missing data, or patients with sufficient data where no model converged are excluded and noted individually in \code{results} and summarized in \code{models} with one of the following explanations: no data (cases with all missing data), only 1 or 2 data points (where the latter has less than 20 percent difference in tumor measurements), error data (where only one unique measurement value for a patient that is repeated 3 or more times, and/or where both the initial and final measurement value is zero), or not fit.

%%\tabular{ll}{
%%Package: \tab gdRate\cr
%%Type: \tab Package\cr
%%Version: \tab 1.0.0\cr
%%Date: \tab 2015-05-18\cr
%%License: \tab GPL\cr
%%}


}
\value{
\item{models}{Data frame summarizing included (by model type selected), and excluded (by reason for exclusion) cases.}
\item{sumstats}{Data frame containing descriptive statistics of growth rate results (N, median, IQR, mean and SD).}
\item{results}{Data frame containing growth rate results (g,d,phi), an indicator of included or excluded status, and the number of evaluations for individual patients. }
\item{allest}{Data frame containing estimates (with respective SE, T value, and p-value) from all models that converged for each patient.  }
}


\references{
\cite{Timur V. Elzhov, Katharine M. Mullen, Andrej-Nikolai Spiess and Ben Bolker (2013). minpack.lm: R interface to the Levenberg-Marquardt nonlinear least-squares algorithm found in MINPACK, plus support for bounds. R package version 1.1-8. http://CRAN.R-project.org/package=minpack.lm}

\cite{Stein WD et al. (2008). Bevacizumab reduces the growth rate constants of renal carcinomas: a novel algorithm suggests early discontinuation of bevacizumab resulted in a lack of survival advantage. Oncologist, 3:1055--62.}

\cite{Stein WD et al. (2008). Tumor growth rates derived from data for patients in a clinical trial correlate strongly with patient survival: a novel strategy for evaluation of clinical trial data. Oncologist, 13:1046--54.}

\cite{Stein WD et al. (2009). Other paradigms: growth rate constants and tumor burden determined using computed tomography data correlate strongly with the overall survival of patients with renal cell carcinoma. Cancer Journal, 15:441--7.}

\cite{Stein WD et al. (2012). Analyzing the pivotal trial that compared sunitinib and IFN-alpha in renal cell carcinoma, using a method that assesses tumor regression and growth.  Clinical Cancer Research, 18:2374--81.}

\cite{Stein WD et al. (2011). Tumor regression and growth rates determined in five intramural NCI prostate cancer trials: the growth rate as an indicator of therapeutic efficacy. Clinical Cancer Research, 17:907--14.}

\cite{Fojo A et al. (2010). Kinetic analysis of breast tumor decay and growth following ixabepilone plus capecitabine (IXA+CAP) versus capecitabine alone (CAP) to discern whether the superiority of the combination is a result of slower growth, enhanced tumor cell kill or both. Journal of Clinical Oncology, 28:137s.}

\cite{Gully JL et al. (2013). Effect of PSA-tricom, a pox-viral vaccine in prostate cancer (PCa), on tumor growth rates within 80 days after initiation in non-metastatic PCa. Journal of Clinical Oncology, 31(6).}

\cite{Blageov et al. (2013). Sunitinib Does Not Accelerate Tumor Growth in Patients with Metastatic Renal Cell Carcinoma. Cell Reports, 3:277--81.}

\cite{O Sullivan et al. (2014). The VEGF inhibitor axitinib has limited effectiveness as a therapy for adrenocortical cancer. Journal of Clinical Endocrinology and Metabolism, 99:1291--7.}

\cite{Burotto et al. (2015). Phase II clinical trial of ixabepilone in metastatic cervical carcinoma. The Oncologist, 2015 Jun 3. [Epub ahead of print].}
}

\author{
Julia Wilkerson \email{ wilkersj@mail.nih.gov }
}
%%\note{
%%  ~~further notes~~
%%}

%% ~Make other sections like Warning with \section{Warning }{....} ~

%% \seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
%% }
\examples{

# example data
data(sampleData)

# generate plots and results
par(mfrow=c(3, 2))
out <- gdrate(sampleData, 0.05, TRUE)
par(mfrow=c(1, 1))

# summary of cases
out$models

# descriptive statistics
out$sumstats

# plot g and d distributions
res <- out$results
par(mfrow=c(2,1))
hist(res$g, col='blue', main=paste('Median g=', round(median(na.omit(res$g)), digits=6)), xlab="g")
hist(res$d, col='blue', main=paste('Median d=', round(median(na.omit(res$d)), digits=6)), xlab="d")


}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
%%\keyword{ ~kwd1 }
%%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
