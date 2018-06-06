context("Move")

test_that("Sample", {
  set.seed(12345)
  expect_equal(sample1(1:100), 73)
  expect_equal(sample1(1:1000), 876)
  expect_equal(sample1(10), 10)
})

test_that("Move up", {
  expect_equal(move_up(1, 2), 2)
  set.seed(54321)
  expect_equal(move_up(1:5, 101:105), c(1, 2, 53, 4, 5))
})

test_that("Move up", {
  set.seed(6789)
  x <- c(2, 10, 20)
  expect_equal(move_up_down(x, c(1, 5, 15), c(4, 14, 30)), c(1, 10, 26))
  for(i in 1:10){
    new <- move_up_down(x, c(1, 5, 15), c(4, 14, 30))
    dif <-  new - x
    dif
    expect_equal(sum(dif > 0), 1)
    expect_equal(sum(dif < 0), 1)
    expect_equal(sum(dif == 0), 1)
  }
})
