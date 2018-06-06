context("New")

test_that("New up", {
  cur <-  c(2, 5, 10)
  mi <- c(1, 4, 8)
  ma <- c(3, 7, 20)

  set.seed(135)
  new <- updown(current_solution = cur, max_solution = ma, min_solution = mi,
         cost = rep(1, 20), ISO = c(1, 1, 2), budget = c(100, 100), free = 0)
  expect_equal(new, c(1, 6, 10))

  new2 <- up(current_solution = cur, max_solution = ma,
                cost = rep(1, 20), ISO = c(1, 1, 2), budget = c(100, 100), free = 0)
  expect_equal(new2, c(2, 6, 10))

  new3 <- up(current_solution = cur, max_solution = ma,
                cost = rep(10, 20), ISO = c(1, 1, 2), budget = c(1, 1), free = 0)
  expect_equal(new3, cur)

})
