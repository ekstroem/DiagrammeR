context("Get aggregate degree values")

test_that("Getting aggregated indegree values is possible", {

  # Create a random graph
  graph <-
    create_random_graph(
      n = 10, m = 22,
      set_seed = 23)

  # Expect a certain value for the
  # mean indegree value from all
  # nodes in the graph
  expect_equal(
    get_agg_degree_in(
      graph = graph,
      agg = "mean"),
    2.2)

  # Expect a certain value for the
  # minimum indegree value from all
  # nodes in the graph
  expect_equal(
    get_agg_degree_in(
      graph = graph,
      agg = "min"),
    0)

  # Expect a certain value for the
  # maximum indegree value from all
  # nodes in the graph
  expect_equal(
    get_agg_degree_in(
      graph = graph,
      agg = "max"),
    5)

  # Expect a certain value for the
  # maximum indegree value from all
  # nodes in the graph
  expect_equal(
    get_agg_degree_in(
      graph = graph,
      agg = "median"),
    2.5)

  # Expect a certain value for the sum
  # of indegree values from all
  # nodes in the graph
  expect_equal(
    get_agg_degree_in(
      graph = graph,
      agg = "sum"),
    22)

  # Expect a certain value for the
  # mean indegree value from all
  # nodes in the graph (considering
  # only nodes with `value > 5.0`)
  expect_equal(
    get_agg_degree_in(
      graph = graph,
      agg = "mean",
      conditions = "value > 5.0"),
    2.428571,
    tolerance = 0.002)

  # Expect a certain value for the
  # minimum indegree value from all
  # nodes in the graph (considering
  # only nodes with `value > 5.0`)
  expect_equal(
    get_agg_degree_in(
      graph = graph,
      agg = "min",
      conditions = "value > 5.0"),
    0,
    tolerance = 0.002)

  # Expect a certain value for the
  # maximum indegree value from all
  # nodes in the graph (considering
  # only nodes with `value > 5.0`)
  expect_equal(
    get_agg_degree_in(
      graph = graph,
      agg = "max",
      conditions = "value > 5.0"),
    5,
    tolerance = 0.002)

  # Expect a certain value for the
  # maximum indegree value from all
  # nodes in the graph (considering
  # only nodes with `value > 5.0`)
  expect_equal(
    get_agg_degree_in(
      graph = graph,
      agg = "median",
      conditions = "value > 5.0"),
    3,
    tolerance = 0.002)

  # Expect a certain value for the sum
  # of indegree values from all
  # nodes in the graph (considering
  # only nodes with `value > 5.0`)
  expect_equal(
    get_agg_degree_in(
      graph = graph,
      agg = "sum",
      conditions = "value > 5.0"),
    17,
    tolerance = 0.002)
})

test_that("Getting aggregated outdegree values is possible", {

  # Create a random graph
  graph <-
    create_random_graph(
      n = 10, m = 22,
      set_seed = 23)

  # Expect a certain value for the
  # mean outdegree value from all
  # nodes in the graph
  expect_equal(
    get_agg_degree_out(
      graph = graph,
      agg = "mean"),
    2.2)

  # Expect a certain value for the
  # minimum outdegree value from all
  # nodes in the graph
  expect_equal(
    get_agg_degree_out(
      graph = graph,
      agg = "min"),
    0)

  # Expect a certain value for the
  # maximum outdegree value from all
  # nodes in the graph
  expect_equal(
    get_agg_degree_out(
      graph = graph,
      agg = "max"),
    5)

  # Expect a certain value for the
  # maximum outdegree value from all
  # nodes in the graph
  expect_equal(
    get_agg_degree_out(
      graph = graph,
      agg = "median"),
    2.5)

  # Expect a certain value for the sum
  # of outdegree values from all
  # nodes in the graph
  expect_equal(
    get_agg_degree_out(
      graph = graph,
      agg = "sum"),
    22)

  # Expect a certain value for the
  # mean outdegree value from all
  # nodes in the graph (considering
  # only nodes with `value > 5.0`)
  expect_equal(
    get_agg_degree_out(
      graph = graph,
      agg = "mean",
      conditions = "value > 5.0"),
    1.571429,
    tolerance = 0.002)

  # Expect a certain value for the
  # minimum outdegree value from all
  # nodes in the graph (considering
  # only nodes with `value > 5.0`)
  expect_equal(
    get_agg_degree_out(
      graph = graph,
      agg = "min",
      conditions = "value > 5.0"),
    0,
    tolerance = 0.002)

  # Expect a certain value for the
  # maximum outdegree value from all
  # nodes in the graph (considering
  # only nodes with `value > 5.0`)
  expect_equal(
    get_agg_degree_out(
      graph = graph,
      agg = "max",
      conditions = "value > 5.0"),
    4,
    tolerance = 0.002)

  # Expect a certain value for the
  # maximum outdegree value from all
  # nodes in the graph (considering
  # only nodes with `value > 5.0`)
  expect_equal(
    get_agg_degree_out(
      graph = graph,
      agg = "median",
      conditions = "value > 5.0"),
    1,
    tolerance = 0.002)

  # Expect a certain value for the sum
  # of outdegree values from all
  # nodes in the graph (considering
  # only nodes with `value > 5.0`)
  expect_equal(
    get_agg_degree_out(
      graph = graph,
      agg = "sum",
      conditions = "value > 5.0"),
    11,
    tolerance = 0.002)
})

test_that("Getting aggregated total degree values is possible", {

  # Create a random graph
  graph <-
    create_random_graph(
      n = 10, m = 22,
      set_seed = 23)

  # Expect a certain value for the
  # mean total degree value from all
  # nodes in the graph
  expect_equal(
    get_agg_degree_total(
      graph = graph,
      agg = "mean"),
    4.4)

  # Expect a certain value for the
  # minimum total degree value from all
  # nodes in the graph
  expect_equal(
    get_agg_degree_total(
      graph = graph,
      agg = "min"),
    2)

  # Expect a certain value for the
  # maximum total degree value from all
  # nodes in the graph
  expect_equal(
    get_agg_degree_total(
      graph = graph,
      agg = "max"),
    7)

  # Expect a certain value for the
  # maximum total degree value from all
  # nodes in the graph
  expect_equal(
    get_agg_degree_total(
      graph = graph,
      agg = "median"),
    4.5)

  # Expect a certain value for the sum
  # of total degree values from all
  # nodes in the graph
  expect_equal(
    get_agg_degree_total(
      graph = graph,
      agg = "sum"),
    44)

  # Expect a certain value for the
  # mean total degree value from all
  # nodes in the graph (considering
  # only nodes with `value > 5.0`)
  expect_equal(
    get_agg_degree_total(
      graph = graph,
      agg = "mean",
      conditions = "value > 5.0"),
    4,
    tolerance = 0.002)

  # Expect a certain value for the
  # minimum total degree value from all
  # nodes in the graph (considering
  # only nodes with `value > 5.0`)
  expect_equal(
    get_agg_degree_total(
      graph = graph,
      agg = "min",
      conditions = "value > 5.0"),
    2,
    tolerance = 0.002)

  # Expect a certain value for the
  # maximum total degree value from all
  # nodes in the graph (considering
  # only nodes with `value > 5.0`)
  expect_equal(
    get_agg_degree_total(
      graph = graph,
      agg = "max",
      conditions = "value > 5.0"),
    5,
    tolerance = 0.002)

  # Expect a certain value for the
  # maximum total degree value from all
  # nodes in the graph (considering
  # only nodes with `value > 5.0`)
  expect_equal(
    get_agg_degree_total(
      graph = graph,
      agg = "median",
      conditions = "value > 5.0"),
    4,
    tolerance = 0.002)

  # Expect a certain value for the sum
  # of total degree values from all
  # nodes in the graph (considering
  # only nodes with `value > 5.0`)
  expect_equal(
    get_agg_degree_total(
      graph = graph,
      agg = "sum",
      conditions = "value > 5.0"),
    28,
    tolerance = 0.002)
})
