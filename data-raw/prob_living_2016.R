library(ssalifetablesextended)

probLiving2016 <- function(YEAR, SEX) {
  lt <- ssalifetablesextended::lifetables_extended
  lt$sx <- 1-lt$qx
  lt <- dplyr::filter(lt, sex == SEX)
  prod(sapply(0:(2015-YEAR), function(i) {
    lt[lt$year == (YEAR+i) & lt$x == i, "sx"]
  }))
}

prob_living_2016 <- plyr::ldply(1900:2015, function(year) {
  plyr::ldply(c("M", "F"), function(gender) {
    data.frame(year = year, sex = gender, px = probLiving2016(year, gender))
  })
})

prob_living_2016$age <- 2016 - prob_living_2016$year

save(prob_living_2016, file = "data/prob_living_2016.rdata", compress = "xz")
