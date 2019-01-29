context("Simple SA")

test_that("Small data SA", {
  sa1 <- sa(small_data, small_data_budget, outer = 1000, inner = 10, frozen = 100)
  expect_true(all(sa1$solution$y == 2))

  sa2 <- sa(small_data, small_data_budget, outer = 1000, inner = 10,
            free = 1000, frozen = 100)
  expect_equal(sum(sa2$solution$y == 2), 15)
  expect_equal(sum(sa2$solution$y == 1), 1)
})
