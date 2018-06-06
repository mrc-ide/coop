context("Afford")

test_that("Fast tapply", {
  group <- as.numeric(factor(rep(letters[1:5], each = 3)))
  for(i in 10){
    inp <- runif(length(group))
    expect_true(all(tapplysum.fast(inp, group) == tapply(inp, group, sum)))
  }
})

test_that("Affordable", {
  solution <- c(1, 3, 5)
  cost <- rep(10, 6)
  ISO <- c(1, 1, 2)

  expect_true(affordable(solution, cost, ISO, budget = c(20, 10), free = 0))
  expect_false(affordable(solution, cost, ISO, budget = c(20, 9), free = 0))
  expect_false(affordable(solution, cost, ISO, budget = c(19, 10), free = 0))
  expect_true(affordable(solution, cost, ISO, budget = c(20, 9), free = 1))
  expect_true(affordable(solution, cost, ISO, budget = c(20, 9), free = 10))
  expect_true(affordable(solution, cost, ISO, budget = c(20, 10), free = 1))
  expect_false(affordable(solution, cost, ISO, budget = c(20, 8), free = 1))
})
