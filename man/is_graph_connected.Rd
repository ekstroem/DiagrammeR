% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/is_graph_connected.R
\name{is_graph_connected}
\alias{is_graph_connected}
\title{Is the graph a connected graph?}
\usage{
is_graph_connected(graph)
}
\arguments{
\item{graph}{a graph object of class
\code{dgr_graph}.}
}
\value{
a logical value.
}
\description{
Determines whether a graph is a
connected graph.
}
\examples{
\dontrun{
library(magrittr)

# This graph, created using `create_random_graph()`
# is almost fully connected but there is an
# isolated node with no edges
graph_1 <-
  create_random_graph(
    30, 50, set_seed = 1)

graph_1 \%>\% is_graph_connected
#> [1] FALSE

# The following graph is fully connected
graph_2 <-
  create_random_graph(
    36, 50, set_seed = 1)

graph_2 \%>\% is_graph_connected
#> [1] TRUE

# Modify `graph_2` so that there are two
# clusters of nodes (i.e., making the graph
# not connected)
graph_3 <-
  graph_2 \%>\%
  delete_edge(10, 36) \%>\%
  delete_edge(25, 27) \%>\%
  delete_edge(28, 29) \%>\%
  delete_edge(4, 29) \%>\%
  delete_edge(24, 32)

graph_3 \%>\% is_graph_connected
#> [1] FALSE
}
}
