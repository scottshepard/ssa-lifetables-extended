#' Lifetables Extended
#'
#' Cohort life tables data as provided by SSA and extended.
#' Original table only includes data for each decade. This extended
#' table has data for each year 1900-2013
#'
#' @format A data frame with nine variables:
#' \describe{
#' \item{\code{x}}{age in years}
#' \item{\code{qx}}{probability of death at age \code{x}}
#' \item{\code{lx}}{number of survivors, of birth cohort of 100,000, at next integral age}
#' \item{\code{dx}}{number of deaths that would occur between integral ages}
#' \item{\code{Lx}}{Number of person-years lived between \code{x} and \code{x+1}}
#' \item{\code{Tx}}{Total number of person-years lived beyond age \code{x}}
#' \item{\code{ex}}{Average number of years of life remaining for members of cohort alive at age \code{x}}
#' \item{\code{sex}}{Sex}
#' \item{\code{year}}{Year}
#' }
#'
#' For further details, see \url{http://www.ssa.gov/oact/NOTES/as120/LifeTables_Body.html#wp1168594}
#'
"lifetables_extended"

#' Probability of Living in 2014
#'
#' The probabily that someone was born in a given year is alive today.
#' Derived from the extended life tables
#'
#' @format A data frame with three variables:
#' \describe{
#' \item{\code{year}}{year born}
#' \item{\code{sex}}{Sex}
#' \item{\code{px}}{Probability that someone born in year x is alive as of Jan 1, 2014}
#' }
#'
"prob_living_2014"
