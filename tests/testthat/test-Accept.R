context("Accept")

test_that("Accept", {
  expect_true(accept_reject(2, 1, 100))
  expect_true(accept_reject(2, 1, 0))
  expect_false(accept_reject(1, 2, 0))
  expect_true(accept_reject(1, 2, Inf))
})
