% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/netmatrix.R
\name{netmatrix}
\alias{netmatrix}
\title{Create a matrix with additional information for pairwise
comparisons}
\usage{
netmatrix(x, var, levels, labels = levels, func = "mode",
  ties.method = "random")
}
\arguments{
\item{x}{A \code{\link{netmeta}} object.}

\item{var}{Variable with additional information.}

\item{levels}{An optional vector of the values that \code{var}
might have taken (see \code{\link{factor}}).}

\item{labels}{An optional vector with labels for \code{var} (see
\code{\link{factor}}).}

\item{func}{A character string with the function name to summarize
values within pairwise comparisons; see Details.}

\item{ties.method}{A character string describing how ties are
handled if \code{func = "mode"}; see Details.}
}
\value{
A matrix with the same row and column names as the adjacency matrix
\code{x$A.matrix}.
}
\description{
Auxiliary function to create a matrix with additional information
for pairwise comparisons
}
\details{
For each pairwise comparison, unique values will be calculated for
the variable \code{var} based on the argument \code{func}: "mode"
(most common value), "min" (minimum value), "max", "mean",
"median", and "sum". In order to determine the most common value,
the argument \code{ties.method} can be used in the case of ties
with "first" meaning that the first / smallest value will be
selected; similar for "last" (last / largest value) and "random"
(random selection).
}
\examples{
data(smokingcessation)
# Add variable with (fictious) risk of bias values
# with 1 = "low risk" and 2 = "high risk"
#
smokingcessation$rob <- rep(1:2, 12)

p1 <- pairwise(list(treat1, treat2, treat3),
               event = list(event1, event2, event3),
               n = list(n1, n2, n3),
               data = smokingcessation,
               sm = "OR")
net1 <- netmeta(p1, comb.fixed = FALSE, ref = "A")

# Generate network graph with information on risk of bias
#
col.rob <- netmatrix(net1, rob, ties.method = "last",
                     levels = 1:2,
                     labels = c("green", "yellow"))
#
netgraph(net1, col = col.rob,
         plastic = FALSE, thickness = "number.of.studies", multi = FALSE)

n.trts <- net1$n.trts
labs <- paste(net1$trts, " (n=", n.trts, ")", sep = "")
#
netgraph(net1, col = col.rob,
         plastic = FALSE, thickness = "number.of.studies", multi = FALSE,
         points = TRUE, col.points = "blue",
         cex.points = 6 * sqrt(n.trts / max(n.trts)),
         labels = labs)

}
\seealso{
\code{\link{netmeta}}, \code{\link{netgraph.netmeta}}
}
\author{
Guido Schwarzer \email{sc@imbi.uni-freiburg.de}
}
