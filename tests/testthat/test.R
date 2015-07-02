test_that("gdrate output is as expected in each combination of user input data", {
  # empty dataset
  a <- data.frame(cbind(name = NaN, date = NaN, size = NaN))
  expect_error(gdrate(a, .1),
               "input contains no non-missing data", fixed=TRUE)

  # dataset with non-numeric data
  b <- data.frame(cbind(name = 'd', date = 4, size= 'd'))
  expect_error(gdrate(b, .1),
               "all input data must be numeric", fixed=TRUE)

  # input producing not fit data only
  name <- c(rep(1,5))
  date <- c(1, 30, 60, 90, 120)
  size <- c(1, 6, .2, 7, .1)
  c <- data.frame(cbind(name, date, size))
  expect_output(gdrate(c, .1)$allest, "no estimates when zero included cases",
                fixed=TRUE)
  expect_output(gdrate(c, .1)$sumstats, "no estimates when zero included cases",
                fixed=TRUE)

  # input producing non-analyzed excluded cases only
  name <- c(rep(1,2),2)
  date <- c(1, 30, 1)
  size <- c(1, .9, 1)
  d <- data.frame(cbind(name, date, size))
  expect_output(gdrate(d, .1)$allest, "no analyzable cases in input data",
                fixed=TRUE)
  expect_output(gdrate(d, .1)$sumstats, "no analyzable cases in input data",
                fixed=TRUE)

  # input producing not fit and non-analyzed excluded cases only
  e <- data.frame(rbind(c, d))
  expect_output(gdrate(e, .1)$allest, "no estimates when zero included cases",
                fixed=TRUE)
  expect_output(gdrate(e, .1)$sumstats, "no estimates when zero included cases",
                fixed=TRUE)

  # input producing included cases only, check that sumstats is data frame
  data("sampleData")
  snam <- c(500007, 500012, 510001, 520001, 530002)
  f <- sampleData[(sampleData$name %in% snam), ]
  expect_match(class(gdrate(f, .1)$sumstats), "data.frame")


  # input producing included and non-analyzed excluded cases
  g <- data.frame(rbind(d, f))
  expect_match(class(gdrate(g, .1)$sumstats), "data.frame")

  # input producing included and not fit cases
  h <- data.frame(rbind(c, f))
  expect_match(class(gdrate(h, .1)$sumstats), "data.frame")

  # input producing included, not fit, and non-analyzed excluded cases
  tall <- data.frame(rbind(c, d, f))
  expect_match(class(gdrate(tall, .1)$sumstats), "data.frame")
}
)
