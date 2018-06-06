context("Simple SA")

test_that("Small data SA", {
  sa1 <- sa(small_data, small_data_budget, outer = 1000, inner = 10)
  expect_true(all(small_data[sa1[[1]],"y"] == 2))

  sa2 <- sa(small_data, small_data_budget, outer = 1000, inner = 10, free = 1000)
  expect_equal(sum(small_data[sa2[[1]],"y"] == 2), 15)
  expect_equal(sum(small_data[sa2[[1]],"y"] == 1), 1)
})
