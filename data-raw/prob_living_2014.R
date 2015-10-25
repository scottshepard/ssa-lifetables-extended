probLiving2014 <- function(YEAR, SEX) {
  lt <- ssalifetablesextended::lifetables_extended
  lt$sx <- 1-lt$qx
  lt <- dplyr::filter(lt, sex == SEX)
  prod(sapply(0:(2013-YEAR), function(i) {
    lt[lt$year == (YEAR+i) & lt$x == i, "sx"]
  }))
}

prob_living_2014 <- plyr::ldply(1900:2013, function(year) {
  plyr::ldply(c("M", "F"), function(gender) {
    data.frame(year = year, sex = gender, px = probLiving2014(year, gender))
  })
})

save(prob_living_2014, file = "data/prob_living_2014.rdata", compress = "xz")
