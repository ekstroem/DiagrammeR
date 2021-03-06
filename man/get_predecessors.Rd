% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_predecessors.R
\name{get_predecessors}
\alias{get_predecessors}
\title{Get node IDs for predecessor nodes to the specified
node}
\usage{
get_predecessors(graph, node)
}
\arguments{
\item{graph}{a graph object of class
\code{dgr_graph}.}

\item{node}{a node ID for the selected node.}
}
\value{
a vector of node ID values.
}
\description{
Provides a vector of node IDs for all
nodes that have a connection to the given node.
}
\examples{
# Set a seed
set.seed(23)

# Create a node data frame (ndf)
ndf <- create_node_df(26)

# Create an edge data frame (edf)
edf <-
  create_edge_df(
    from = sample(1:26, replace = TRUE),
    to = sample(1:26, replace = TRUE))

# From the ndf and edf, create a graph object
graph <-
  create_graph(
    nodes_df = ndf,
    edges_df = edf)

# Get predecessors for node `23` in the graph
get_predecessors(graph, node = 23)
#> [1] 6

# If there are no predecessors, `NA` is returned
get_predecessors(graph, node = 26)
#> [1] NA
}
