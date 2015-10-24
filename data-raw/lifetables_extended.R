library(babynames)
library(dplyr)

extendLifeTable <- function(age, gender) {
  #' Given an age and gender, extend the lifetable for all decades
  l <- filter(babynames::lifetables, x == age, sex == gender)
  EXTRA = F
  plyr::ldply(decades(), function(d) {
    # Since there is no 2020 census data, we extend the trend from 2000 to 2010
    # three more years to 2013
    if(d == 2000) EXTRA <- T
    interpolateForADecade(filter(l, year %in% c(d, d+10)), EXTRA)
  })
}

interpolateForADecade <- function(lt_2_decades, extra = F) {
  #' Take a data.frame with two rows of data
  #' Create a linear interpolation for each column and add nine
  #' new rows of data before returning the data.frame back
  out <- data.frame(
    apply(dplyr::select(lt_2_decades, -sex), 2, function(col) interpolate(col[1], col[2], extra))
  )
  out$sex <- lt_2_decades$sex[1]
  out
}

interpolate <- function(n1, n2, extra3 = F) {
  #' Function takes two numbers and returns a vector of 11 numbers that
  #' fill in a decade of linear interpolation
  slope = (n2 - n1)/10
  if(extra3 == T) {
    c(n1, 1:9*slope + n1, n2, 1:3*slope + n2)
  } else {
    c(n1, 1:9*slope + n1, n2)
  }
}

decades <- function() {
  d <- unique(babynames::lifetables$year)
  d[1:(length(d)-1)]
}

ages = unique(lifetables$x)
genders = c("M", "F")

lifetables_extended <- plyr::ldply(genders, function(g) {
  plyr::ldply(ages, function(a) {
    extendLifeTable(a, g)
  })
})

lifetables_extended <- lifetables_extended[!duplicated(lifetables_extended), ]

save(lifetables_extended, file = "data/lifetables_extended.rdata", compress = "xz")
