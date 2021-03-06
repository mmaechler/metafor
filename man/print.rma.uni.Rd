\name{print.rma.uni}
\alias{print.rma.uni}
\alias{print.rma.mh}
\alias{print.rma.peto}
\alias{print.rma.glmm}
\alias{print.rma.mv}
\alias{summary.rma}
\alias{print.summary.rma}
\title{Print and Summary Methods for 'rma' Objects}
\description{
   Print and summary methods for objects of class \code{"rma.uni"}, \code{"rma.mh"}, \code{"rma.peto"}, \code{"rma.glmm"}, and \code{"rma.glmm"}.
}
\usage{
\method{print}{rma.uni}(x, digits, showfit=FALSE, signif.stars=getOption("show.signif.stars"),
      signif.legend=signif.stars, \dots)

\method{print}{rma.mh}(x, digits, showfit=FALSE, \dots)

\method{print}{rma.peto}(x, digits, showfit=FALSE, \dots)

\method{print}{rma.glmm}(x, digits, showfit=FALSE, signif.stars=getOption("show.signif.stars"),
      signif.legend=signif.stars, \dots)

\method{print}{rma.mv}(x, digits, showfit=FALSE, signif.stars=getOption("show.signif.stars"),
      signif.legend=signif.stars, \dots)

\method{summary}{rma}(object, digits, showfit=TRUE, \dots)

\method{print}{summary.rma}(x, digits, showfit=TRUE, signif.stars=getOption("show.signif.stars"),
      signif.legend=signif.stars, \dots)
}
\arguments{
   \item{x}{an object of class \code{"rma.uni"}, \code{"rma.mh"}, \code{"rma.peto"}, \code{"rma.glmm"}, \code{"rma.mv"}, or \code{"summary.rma"} (for \code{print}).}
   \item{object}{an object of class \code{"rma"} (for \code{summary}).}
   \item{digits}{integer specifying the number of decimal places to which the printed results should be rounded (if unspecified, the default is to take the value from the object).}
   \item{showfit}{logical indicating whether the fit statistics and information criteria should be printed (the default is \code{FALSE} for \code{print} and \code{TRUE} for \code{summary}).}
   \item{signif.stars}{logical indicating whether p-values should be encoded visually with \sQuote{significance stars}. Defaults to the \code{show.signif.stars} slot of \code{\link{options}}.}
   \item{signif.legend}{logical indicating whether the legend for the \sQuote{significance stars} should be printed. Defaults to the value for \code{signif.stars}.}
   \item{\dots}{other arguments.}
}
\details{
   The output includes:
   \itemize{
   \item the log-likelihood, deviance, AIC, BIC, and AICc value (when setting \code{showfit=TRUE} or by default for \code{summary}).
   \item for objects of class \code{"rma.uni"} and \code{"rma.glmm"}, the amount of (residual) heterogeneity in the random/mixed-effects model (i.e., the estimate of \if{latex}{\eqn{\tau^2}}\if{html}{\eqn{\tau²}}\if{text}{\eqn{\tau^2}} and its square root). Suppressed for fixed-effects models. The (asymptotic) standard error of the estimate of \if{latex}{\eqn{\tau^2}}\if{html}{\eqn{\tau²}}\if{text}{\eqn{\tau^2}} is also provided (where possible).
   \item for objects of \code{"rma.mv"}, a table providing information about the variance components and correlations in the model. For \if{latex}{\eqn{\sigma^2}}\if{html}{\eqn{\sigma²}}\if{text}{\eqn{\sigma^2}} components, the estimate and its square root are provided, in addition to the number of values/levels, whether the component was fixed or estimated, and the name of the grouping variable/factor. If the \code{R} argument was used to specify known correlation matrices, this is also indicated. For models with an \code{~ inner | outer} formula term, the name of the inner and outer grouping variable/factor are given and the number of values/levels of these variables/factors. In addition, for each \if{latex}{\eqn{\tau^2}}\if{html}{\eqn{\tau²}}\if{text}{\eqn{\tau^2}} component, the estimate and its square root are provided, the number of effects or outcomes observed at each level of the inner grouping variable/factor (only for \code{struct="HCS"}, \code{struct="DIAG"}, \code{struct="HAR"}, and \code{struct="UN"}), and whether the component was fixed or estimated. Finally, either the estimate of \eqn{\rho} (for \code{struct="CS"}, \code{struct="AR"}, \code{struct="HAR"}, or \code{struct="HCS"}) or the entire estimated correlation matrix (for \code{struct="UN"}) between the levels of the inner grouping variable/factor is provided, again with information whether a particular correlation was fixed or estimated, and how often each combination of levels of the inner grouping variable/factor was observed across the levels of the outer grouping variable/factor. If there is a second \code{~ inner | outer} formula term, the same information as described above will be provided, but now for the \if{latex}{\eqn{\gamma^2}}\if{html}{\eqn{\gamma²}}\if{text}{\eqn{\gamma^2}} and \eqn{\phi} components.
   \item for objects of class \code{"rma.uni"} and \code{"rma.glmm"}, the \if{latex}{\eqn{I^2}}\if{html}{\eqn{I²}}\if{text}{\eqn{I^2}} statistic. For a random-effects model, \if{latex}{\eqn{I^2}}\if{html}{\eqn{I²}}\if{text}{\eqn{I^2}} estimates (in percent) how much of the total variability in the effect size estimates (which is composed of heterogeneity plus sampling variability) can be attributed to heterogeneity among the true effects. For a mixed-effects model, \if{latex}{\eqn{I^2}}\if{html}{\eqn{I²}}\if{text}{\eqn{I^2}} estimates how much of the unaccounted variability (which is composed of residual heterogeneity plus sampling variability) can be attributed to residual heterogeneity. See \sQuote{Note} for how \if{latex}{\eqn{I^2}}\if{html}{\eqn{I²}}\if{text}{\eqn{I^2}} is computed.
   \item for objects of class \code{"rma.uni"} and \code{"rma.glmm"}, the \if{latex}{\eqn{H^2}}\if{html}{\eqn{H²}}\if{text}{\eqn{H^2}} statistic. For a random-effects model, \if{latex}{\eqn{H^2}}\if{html}{\eqn{H²}}\if{text}{\eqn{H^2}} estimates the ratio of the total amount of variability in the effect size estimates to the amount of sampling variability. For a mixed-effects model, \if{latex}{\eqn{H^2}}\if{html}{\eqn{H²}}\if{text}{\eqn{H^2}} estimates the ratio of the unaccounted variability in the effect size estimates to the amount of sampling variability. See \sQuote{Note} for how \if{latex}{\eqn{H^2}}\if{html}{\eqn{H²}}\if{text}{\eqn{H^2}} is computed.
   \item for objects of class \code{"rma.uni"}, the \if{latex}{\eqn{R^2}}\if{html}{\eqn{R²}}\if{text}{\eqn{R^2}} statistic, which estimates the amount of heterogeneity accounted for by the moderators included in the model and can be regarded as a pseudo \if{latex}{\eqn{R^2}}\if{html}{\eqn{R²}}\if{text}{\eqn{R^2}} statistic (Raudenbush, 2009). Only provided when fitting a mixed-effects models (i.e., for models including moderators). This is suppressed (and set to \code{NULL}) for models without moderators, fixed-effects models, or if the model does not contain an intercept. \code{NA} if the amount of heterogeneity is equal to zero to begin with. See \sQuote{Note} for how \if{latex}{\eqn{R^2}}\if{html}{\eqn{R²}}\if{text}{\eqn{R^2}} is computed.
   \item for objects of class \code{"rma.glmm"}, the amount of study level variability (only when using a model that models study level differences as a random effect).
   \item the results of the test for (residual) heterogeneity. This is the usual \eqn{Q}-test for heterogeneity when not including moderators in the model and the \eqn{Q_E}-test for residual heterogeneity when moderators are included. For objects of class \code{"rma.glmm"}, the results from a Wald-type test and a likelihood ratio test are provided (see \code{\link{rma.glmm}} for more details).
   \item the results of the omnibus (Wald-type) test of the coefficients in the model (the indices of the coefficients tested are also indicated). Suppressed if the model includes only one coefficient (e.g., only an intercept, like in the fixed- and random-effects model).
   \item a table with the estimated coefficients, corresponding standard errors, test statistics, p-values, and confidence interval bounds.
   \item the Cochran-Mantel-Haenszel test and Tarone's test for heterogeneity (only when analyzing odds ratios using the Mantel-Haenszel method, i.e., \code{"rma.mh"}).
   }
}
\value{
   The \code{print} functions do not return an object. The \code{summary} function returns the object passed to it (with additional class \code{"summary.rma"}).
}
\note{
   For random-effects models, the \if{latex}{\eqn{I^2}}\if{html}{\eqn{I²}}\if{text}{\eqn{I^2}} statistic is computed with \if{latex}{\deqn{I^2 = 100\% \times \frac{\hat{\tau}^2}{\hat{\tau}^2 + s^2},}}\if{html}{\deqn{I² = 100% hat(\tau)² / (hat(\tau)² + s²),}}\if{text}{\deqn{I² = 100% hat(\tau)^2 / (hat(\tau)^2 + s^2),}} where \if{latex}{\eqn{\hat{\tau}^2}}\if{html}{\eqn{hat(\tau)²}}\if{text}{\eqn{hat(\tau)^2}} is the estimated value of \if{latex}{\eqn{\tau^2}}\if{html}{\eqn{\tau²}}\if{text}{\eqn{\tau^2}} and \if{latex}{\deqn{s^2 = \frac{(k-1) \sum w_i}{(\sum w_i)^2 - \sum w_i^2},}}\if{html}{\deqn{s² = ((k-1) \sum wᵢ) / ((\sum wᵢ)² - \sum wᵢ²),}}\if{text}{\deqn{s^2 = ((k-1) \sum w_i) / ((\sum w_i)^2 - \sum w_i^2),}} where \if{latex}{\eqn{w_i}}\if{html}{\eqn{wᵢ}}\if{text}{\eqn{w_i}} is the inverse of the sampling variance of the \eqn{i}th study (\if{latex}{\eqn{s^2}}\if{html}{\eqn{s²}}\if{text}{\eqn{s^2}} is equation 9 in Higgins & Thompson, 2002, and can be regarded as the \sQuote{typical} within-study variance of the observed effect sizes or outcomes). The \if{latex}{\eqn{H^2}}\if{html}{\eqn{H²}}\if{text}{\eqn{H^2}} statistic is computed with \if{latex}{\deqn{H^2 = \frac{\hat{\tau}^2 + s^2}{s^2}.}}\if{html}{\deqn{H² = (hat(\tau)² + s²) / s².}}\if{text}{\eqn{H^2 = (hat(\tau)^2 + s^2) / s^2.}} Analogous equations are used for mixed-effects models.

   Therefore, depending on the estimator of \if{latex}{\eqn{\tau^2}}\if{html}{\eqn{\tau²}}\if{text}{\eqn{\tau^2}} used, the values of \if{latex}{\eqn{I^2}}\if{html}{\eqn{I²}}\if{text}{\eqn{I^2}} and \if{latex}{\eqn{H^2}}\if{html}{\eqn{H²}}\if{text}{\eqn{H^2}} will change. For random-effects models, \if{latex}{\eqn{I^2}}\if{html}{\eqn{I²}}\if{text}{\eqn{I^2}} and \if{latex}{\eqn{H^2}}\if{html}{\eqn{H²}}\if{text}{\eqn{H^2}} are typically computed in practice with \if{latex}{\eqn{I^2 = (Q-(k-1))/Q}}\if{html}{\eqn{I² = (Q-(k-1))/Q}}\if{text}{\eqn{I^2 = (Q-(k-1))/Q}} and \if{latex}{\eqn{H^2 = Q/(k-1)}}\if{html}{\eqn{H² = Q/(k-1)}}\if{text}{\eqn{H^2 = Q/(k-1)}}, where \eqn{Q} denotes the statistic for the test of heterogeneity and \eqn{k} the number of studies (i.e., observed effects or outcomes) included in the meta-analysis. The equations used in the metafor package to compute these statistics are more general and have the advantage that the values of \if{latex}{\eqn{I^2}}\if{html}{\eqn{I²}}\if{text}{\eqn{I^2}} and \if{latex}{\eqn{H^2}}\if{html}{\eqn{H²}}\if{text}{\eqn{H^2}} will be consistent with the estimated value of \if{latex}{\eqn{\tau^2}}\if{html}{\eqn{\tau²}}\if{text}{\eqn{\tau^2}} (i.e., if \if{latex}{\eqn{\hat{\tau}^2 = 0}}\if{html}{\eqn{hat(\tau)² = 0}}\if{text}{\eqn{hat(\tau)^2 = 0}}, then \if{latex}{\eqn{I^2 = 0}}\if{html}{\eqn{I² = 0}}\if{text}{\eqn{I^2 = 0}} and \if{latex}{\eqn{H^2 = 1}}\if{html}{\eqn{H² = 1}}\if{text}{\eqn{H^2 = 1}} and if \if{latex}{\eqn{\hat{\tau}^2 > 0}}\if{html}{\eqn{hat(\tau)² > 0}}\if{text}{\eqn{hat(\tau)^2 > 0}}, then \if{latex}{\eqn{I^2 > 0}}\if{html}{\eqn{I² > 0}}\if{text}{\eqn{I^2 > 0}} and \if{latex}{\eqn{H^2 > 1}}\if{html}{\eqn{H² > 1}}\if{text}{\eqn{H^2 > 1}}).

   The two definitions of \if{latex}{\eqn{I^2}}\if{html}{\eqn{I²}}\if{text}{\eqn{I^2}} and \if{latex}{\eqn{H^2}}\if{html}{\eqn{H²}}\if{text}{\eqn{H^2}} actually coincide when using the DerSimonian-Laird estimator of \if{latex}{\eqn{\tau^2}}\if{html}{\eqn{\tau²}}\if{text}{\eqn{\tau^2}} (i.e., the commonly used equations are actually special cases of the more general definitions given above). Therefore, if you prefer the more conventional definitions of these statistics, use \code{method="DL"} when fitting the random/mixed-effects model with the \code{\link{rma.uni}} function.

   The pseudo \if{latex}{\eqn{R^2}}\if{html}{\eqn{R²}}\if{text}{\eqn{R^2}} statistic (Raudenbush, 2009) is computed with \if{latex}{\deqn{R^2 = \frac{\hat{\tau}_{RE}^2 - \hat{\tau}_{ME}^2}{\hat{\tau}_{RE}^2},}}\if{html}{\deqn{R² = (hat(\tau)²_RE - hat(\tau)²_ME) / hat(\tau)²_RE,}}\if{text}{\deqn{R^2 = (hat(\tau)^2_RE - hat(\tau)^2_ME) / hat(\tau)^2_RE,}} where \if{latex}{\eqn{\hat{\tau}_{RE}^2}}\if{html}{\eqn{hat(\tau)²_RE}}\if{text}{\eqn{hat(\tau)^2_RE}} denotes the estimated value of \if{latex}{\eqn{\tau^2}}\if{html}{\eqn{\tau²}}\if{text}{\eqn{\tau^2}} based on the random-effects model (i.e., the total amount of heterogeneity) and \if{latex}{\eqn{\hat{\tau}_{ME}^2}}\if{html}{\eqn{hat(\tau)²_ME}}\if{text}{\eqn{hat(\tau)^2_ME}} denotes the estimated value of \if{latex}{\eqn{\tau^2}}\if{html}{\eqn{\tau²}}\if{text}{\eqn{\tau^2}} based on the mixed-effects model (i.e., the residual amount of heterogeneity). It can happen that \if{latex}{\eqn{\hat{\tau}_{RE}^2 < \hat{\tau}_{ME}^2}}\if{html}{\eqn{hat(\tau)²_RE < hat(\tau)²_ME}}\if{text}{\eqn{hat(\tau)^2_RE < hat(\tau)^2_ME}}, in which case \if{latex}{\eqn{R^2}}\if{html}{\eqn{R²}}\if{text}{\eqn{R^2}} is set to zero. Again, the value of \if{latex}{\eqn{R^2}}\if{html}{\eqn{R²}}\if{text}{\eqn{R^2}} will change depending on the estimator of \if{latex}{\eqn{\tau^2}}\if{html}{\eqn{\tau²}}\if{text}{\eqn{\tau^2}} used. Also note that this statistic is only computed when the mixed-effects model includes an intercept (so that the random-effects model is clearly nested within the mixed-effects model). You can also use the \code{\link{anova.rma}} function to compute \if{latex}{\eqn{R^2}}\if{html}{\eqn{R²}}\if{text}{\eqn{R^2}} for any two models that are known to be nested. Note that the pseudo \if{latex}{\eqn{R^2}}\if{html}{\eqn{R²}}\if{text}{\eqn{R^2}} statistic may not be very accurate unless \eqn{k} is large (Lopez-Lopez et al., 2014).
}
\author{
   Wolfgang Viechtbauer \email{wvb@metafor-project.org} \cr
   package website: \url{http://www.metafor-project.org/} \cr
   author homepage: \url{http://www.wvbauer.com/}
}
\references{
   Higgins, J. P. T., & Thompson, S. G. (2002). Quantifying heterogeneity in a meta-analysis. \emph{Statistics in Medicine}, \bold{21}, 1539--1558.

   Lopez-Lopez, J. A., Marin-Martinez, F., Sanchez-Meca, J., Van den Noortgate, W., & Viechtbauer, W. (2014). Estimation of the predictive power of the model in mixed-effects meta-regression: A simulation study. \emph{British Journal of Mathematical and Statistical Psychology}, \bold{67}, 30--48.

   Raudenbush, S. W. (2009). Analyzing effect sizes: Random effects models. In H. Cooper, L. V. Hedges, & J. C. Valentine (Eds.), \emph{The handbook of research synthesis and meta-analysis} (2nd ed., pp. 295--315). New York: Russell Sage Foundation.

   Viechtbauer, W. (2010). Conducting meta-analyses in R with the metafor package. \emph{Journal of Statistical Software}, \bold{36}(3), 1--48. \url{http://www.jstatsoft.org/v36/i03/}.
}
\seealso{
   \code{\link{rma.uni}}, \code{\link{rma.mh}}, \code{\link{rma.peto}}, \code{\link{rma.glmm}}, \code{\link{rma.mv}}
}
\keyword{print}
