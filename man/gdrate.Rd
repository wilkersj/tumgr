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
     A data frame containing patient tumor measurement data to be analyzed.  This data frame should consist of the following three columns (with respective column names):  "name" which contains a numeric value that uniquely identifies the patient for the respective row data, "date" which contains a numeric value for the day of evaluation for the respective row data, and "size" which contains the numeric value for the tumor quantity measurement (i.e., CT scan, PSA, CTN, CEA, etc.) for the respective row data.  Each row of data for a patient should have a unique day of evaluation
(i.e., if there are multiple lesions with measurements for a patient on a given day, then the sum of those measurments should be used as the value of tumor quantity in the "size" column for that day of evaluation).
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

The Levenberg-Marquardt algorithm is used to solve these 4 non-linear least squares problems (using package \pkg{minpack.lm}) and among models where all parameters are significant predictors (given user supplied \code{pval}), the model which minimizes the AIC is the selected model for a given patient from which tumor growth rates are obtained (this output is contained in \code{results}).  The port algorithm is attempted where the \emph{gdphi} model does not converge.

Patients with insufficient or missing data, or patients with sufficient data where no model converged are excluded and noted individually in \code{results} and summarized in \code{models} with one of the following explanations: no data (cases with all missing data), only 1 or 2 data points (where the latter has less than 20 percent difference in tumor measurements), error data (where only one unique measurement value for a patient that is repeated 3 or more times, and/or where both the initial and final measurement value is zero), or not fit.  Patient data that does not fall into one of the categories listed above are labeled as included.  Plots can be generated for all included cases (cases fit by models) by setting the plot argument to TRUE, where the observed and predicted values from the selected model (labeled in plot legend) are depicted.


}
\value{
\item{models}{Data frame summarizing included (by model type selected), and excluded (by reason for exclusion) cases. Columns are described below:
\tabular{ll}{
\tab - Group = indicator of included or excluded status\cr
\tab - Analyzed = indicator of whether group was analyzed \cr
\tab - Type = either selected model or reason for exclusion \cr
\tab - N = number of cases \cr
\tab - Percentage = percentage of cases \cr
}}
\item{sumstats}{Data frame containing descriptive statistics of growth rate results (N, median, IQR, mean and SD). Columns are described below:
\tabular{ll}{
\tab - Parameter = parameter for the row data\cr
\tab - N = the number cases with parameter \cr
\tab - Median = median of parameter \cr
\tab - IQR = interquartile range of parameter \cr
\tab - Mean = mean of parameter \cr
}}
\item{results}{Data frame containing growth rate results (g,d,phi), an indicator of included or excluded status, and the number of evaluations for individual patients.  Columns are described below:
\tabular{ll}{
\tab - name = the patient identifier\cr
\tab - nobs = the number of data points analyzed \cr
\tab - type = included or excluded status \cr
\tab - selectedFit = model selected for patient \cr
\tab - g = growth rate estimate \cr
\tab - d = regression rate estimate \cr
\tab - phi = phi estimate (proportion of tumor killed by treatment)\cr
}}
\item{allest}{Data frame containing estimates (with respective SE, T value, and p-value) from all models that converged for each patient. Columns are described below:
\tabular{ll}{
\tab - name = the patient identifier\cr
\tab - type = included or excluded status \cr
\tab - selectedFit = model selected for patient \cr
\tab - fit = model for the row data \cr
\tab - parameter = parameter from the fit model \cr
\tab - Estimate = estimated parameter value \cr
\tab - StdError = standard error of the estimate \cr
\tab - t.value = T value for the estimated value \cr
\tab - p.value = p-value for the estimated value \cr
\tab - N = number of data points analyzed \cr
}}
}


\references{
\cite{Timur V. Elzhov, Katharine M. Mullen, Andrej-Nikolai Spiess and Ben Bolker (2013). minpack.lm: R interface to the Levenberg-Marquardt nonlinear least-squares algorithm found in MINPACK, plus support for bounds. R package version 1.1-8. http://CRAN.R-project.org/package=minpack.lm}

\cite{Stein WD et al. (2008). Bevacizumab reduces the growth rate constants of renal carcinomas: a novel algorithm suggests early discontinuation of bevacizumab resulted in a lack of survival advantage. Oncologist, 3:1055--62.}

\cite{Stein WD et al. (2008). Tumor growth rates derived from data for patients in a clinical trial correlate strongly with patient survival: a novel strategy for evaluation of clinical trial data. Oncologist, 13:1046--54.}

\cite{Stein WD et al. (2009). Other paradigms: growth rate constants and tumor burden determined using computed tomography data correlate strongly with the overall survival of patients with renal cell carcinoma. Cancer Journal, 15:441--7.}

\cite{Stein WD et al. (2012). Analyzing the pivotal trial that compared sunitinib and IFN-alpha in renal cell carcinoma, using a method that assesses tumor regression and growth.  Clinical Cancer Research, 18:2374--81.}

\cite{Stein WD et al. (2011). Tumor regression and growth rates determined in five intramural NCI prostate cancer trials: the growth rate as an indicator of therapeutic efficacy. Clinical Cancer Research, 17:907--14.}

\cite{Fojo A et al. (2010). Kinetic analysis of breast tumor decay and growth following ixabepilone plus capecitabine (IXA+CAP) versus capecitabine alone (CAP) to discern whether the superiority of the combination is a result of slower growth, enhanced tumor cell kill or both. Journal of Clinical Oncology, 28:137s.}

\cite{Wilkerson J et al. (2010). Validation of a kinetic analysis of renal cancer regression and growth following treatment with sunitinib and interferon-alfa (IFN-{alpha}): Analysis of the pivotal randomized trial. Journal of Clinical Oncology, 28:15s.}

\cite{Amiri-Kordestani L et al. (2011). Early assessment of efficacy of ixabepilone (IXA) by analysis of the rate of tumor growth and decay using data from phase II and phase III clinical trials in metastatic breast cancer (MBC) patients (Pts). Journal of Clinical Oncology, 29:15s.}

\cite{Manasanch EE et al. (2011). Assessment of tumor growth (g) and regression (d) rate constants in patients with Multiple Myeloma (MM) shows that the superiority of bortezomib with liposomal Doxorubicin (PLD + B) over Bortezomib alone (B) is a result of reduced growth of refractory tumor cells and not of higher regression rates, and provides an earlier efficacy endpoint that allows for comparison across trials. ASH Annual Meeting Abstracts, 118:21.}

\cite{Adesunloye B et al. (2012). Tumor regression and growth rates determined in two intramural NCI prostate cancer trials: The growth rate constant as an indicator of therapeutic efficacy. Journal of Clinical Oncology, 30:5s.}

\cite{Codesido MB et al. (2012). Assessment and comparison of treatment efficacy in patients with colorectal cancer (CRC), using a novel methodology to estimate the rate of tumor regression (d) and growth (g). Annals of Oncology, 23:198.}

\cite{Wood L et al. (2013). Autologous TARP peptide vaccination is associated with slowing in PSA velocity and a decrease in tumor growth rate in patients with Stage D0 prostate cancer. Cancer Research, 73:8s.}

\cite{Gully JL et al. (2013). Effect of PSA-tricom, a pox-viral vaccine in prostate cancer (PCa), on tumor growth rates within 80 days after initiation in non-metastatic PCa. Journal of Clinical Oncology, 31(6).}

\cite{Blageov et al. (2013). Sunitinib Does Not Accelerate Tumor Growth in Patients with Metastatic Renal Cell Carcinoma. Cell Reports, 3:277--81.}

\cite{O Sullivan et al. (2014). The VEGF inhibitor axitinib has limited effectiveness as a therapy for adrenocortical cancer. Journal of Clinical Endocrinology and Metabolism, 99:1291--7.}

\cite{Burotto et al. (2015). Phase II clinical trial of ixabepilone in metastatic cervical carcinoma. The Oncologist, 20:725-6.}
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
\keyword{ analysis }
\keyword{ models }
\keyword{ datagen }
