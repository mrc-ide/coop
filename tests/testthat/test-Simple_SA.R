context("SA")

test_that("Small data SA", {
  sa1 <- sa(small_data, small_data_budget, outer = 1000, inner = 10, frozen = 100)
  expect_true(all(sa1$solution$y == 2))
  set.seed(123)
  sa2 <- sa(small_data, small_data_budget, outer = 1000, inner = 10,
            free = 1000, frozen = 100)
  expect_equal(sum(sa2$solution$y == 2), 15)
  expect_equal(sum(sa2$solution$y == 1), 1)
})

test_that("Large data SA", {
  set.seed(123)
  sa3 <- sa(large_data, large_data_budget, outer = 5000, inner = 100,
            free = 1000, frozen = 100)
  expect_equal(sum(sa3$solution$y == 2), 259)
  expect_equal(sum(sa3$solution$y == 1), 1)
})
