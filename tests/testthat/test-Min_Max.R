context("Min Max")

test_that("Min_max", {
  dc <- data.frame(budget_block = "A", solution_block = c(1, 1, 2, 3, 3, 3, 10, 10, 10, 11, 11, 5, 5))
  ms <- mins(dc)
  ma <- maxs(ms, nrow(dc))
  expect_true(all(ma >= ms))
  expect_true(all(diff(ms) > 0))
  expect_true(all(diff(ma) > 0))
  expect_equal(length(ms), length(ma))
})
