#' Recode a set of edge attribute values
#' @description Within a graph's internal edge data
#' frame (edf), recode character or numeric edge
#' attribute values. Optionally, one can specify a
#' replacement value for any unmatched mappings.
#' @param graph a graph object of class
#' \code{dgr_graph}.
#' @param edge_attr_from the name of the edge attribute
#' column from which values will be recoded.
#' @param ... single-length character vectors with
#' the recoding instructions. The first component should
#' have the value to replace and the second should have
#' the replacement value (in the form
#' \code{"[to_replace] -> [replacement]", ...}).
#' @param otherwise an optional single value for
#' recoding any unmatched values.
#' @param edge_attr_to an optional name of a new edge
#' attribute to which the recoded values will be
#' applied. This will retain the original edge
#' attribute and its values.
#' @return a graph object of class
#' \code{dgr_graph}.
#' @examples
#' # Create a random graph
#' graph <-
#'   create_random_graph(
#'     4, 6, set_seed = 23) %>%
#'   set_edge_attrs(
#'     "rel",
#'     c("a", "b", "a",
#'       "c", "b", "d"))
#'
#' # Get the graph's internal edf to show which
#' # edge attributes are available
#' get_edge_df(graph)
#' #>   id from to rel
#' #> 1  1    2  4   a
#' #> 2  2    1  4   b
#' #> 3  3    2  3   a
#' #> 4  4    3  4   c
#' #> 5  5    1  3   b
#' #> 6  6    1  2   d
#'
#' # Recode the `rel` node attribute, creating a
#' # new edge attribute called `penwidth`; here,
#' # `a` is recoded to `1.0`, `b` maps to `1.5`, and
#' # all other values become `0.5`
#' graph <-
#'   graph %>%
#'   recode_edge_attrs(
#'     edge_attr_from = "rel",
#'     "a -> 1.0",
#'     "b -> 1.5",
#'     otherwise = 0.5,
#'     edge_attr_to = "penwidth")
#'
#' # Get the graph's internal edf to show that the
#' # node attribute values had been recoded and
#' # copied into a new node attribute
#' get_edge_df(graph)
#' #>   id from to rel penwidth
#' #> 1  1    2  4   a      1.0
#' #> 2  2    1  4   b      1.5
#' #> 3  3    2  3   a      1.0
#' #> 4  4    3  4   c      0.5
#' #> 5  5    1  3   b      1.5
#' #> 6  6    1  2   d      0.5
#' @importFrom stringr str_split
#' @export recode_edge_attrs

recode_edge_attrs <- function(graph,
                              edge_attr_from,
                              ...,
                              otherwise = NULL,
                              edge_attr_to = NULL) {

  # Get the time of function start
  time_function_start <- Sys.time()

  # Validation: Graph object is valid
  if (graph_object_valid(graph) == FALSE) {
    stop("The graph object is not valid.")
  }

  # Validation: Graph contains edges
  if (graph_contains_edges(graph) == FALSE) {
    stop("The graph contains no edges, so, no edges can be recoded.")
  }

  # Get list object from named vectors
  replacements <- list(...)

  # Extract the graph's edf
  edges <- get_edge_df(graph)

  # Get column names from the graph's edf
  column_names_graph <- colnames(edges)

  # Stop function if `edge_attr_from` is not one
  # of the graph's edge attributes
  if (!any(column_names_graph %in% edge_attr_from)) {
    stop("The edge attribute to recode is not in the edf.")
  }

  # Get the column number for the edge attr to recode
  col_num_recode <-
    which(colnames(edges) %in% edge_attr_from)

  # Get the column class for the edge attr to recode
  edge_attr_class <- class(edges[, col_num_recode])

  # Extract the vector to recode from the `edges` df
  vector_to_recode <- edges[, col_num_recode]

  # Initialize the `indices_stack` vector
  indices_stack <- vector("numeric")

  # Parse the recoding pairs
  for (i in 1:length(replacements)) {

    pairing <-
      trimws(unlist(stringr::str_split(replacements[[i]], "->")))

    if (edge_attr_class == "numeric") {
      pairing <- as.numeric(pairing)
    }

    indices <- which(vector_to_recode %in% pairing[1])

    vector_to_recode[setdiff(indices, indices_stack)] <- pairing[2]

    indices_stack <- c(indices_stack, indices)
  }

  # If a value is supplied for `otherwise`, apply
  # that value to all unmatched
  if (!is.null(otherwise)) {

    otherwise_indices <-
      which(!(1:nrow(edges) %in% indices_stack))

    if (length(otherwise_indices) > 0) {
      vector_to_recode[otherwise_indices] <-
        otherwise
    }
  }

  # Rename the `vector_to_recode` object
  recoded_vector <- vector_to_recode

  if (!is.null(edge_attr_to)) {

    # Stop function if `edge_attr_to` is
    # `from` or `to`
    if (any(c("from", "to") %in% edge_attr_to)) {
      stop("You cannot use those names.")
    }

    if (any(column_names_graph %in% edge_attr_to)) {

      # Edge attribute exists and values will be
      # overwritten in this case
      col_num_write_to <-
        which(column_names_graph %in% edge_attr_to)

      edges[, col_num_write_to] <-
        recoded_vector
    }

    if (!any(column_names_graph %in% edge_attr_to)) {

      # Edge attribute does not exist and values be
      # part of a new edge attribute
      edges <-
        cbind(edges,
              data.frame(recoded_vector,
                         stringsAsFactors = FALSE))

      # Set the column name for the copied attr
      colnames(edges)[ncol(edges)] <- edge_attr_to
    }
  } else {
    # The edge attribute values will be overwritten
    # by the recoded value (no new edge attrs)
    edges[, col_num_recode] <- recoded_vector
  }

  # Replace the `edges_df` object in the graph
  # with the `edges` object
  graph$edges_df <- edges

  # Update the `graph_log` df with an action
  graph$graph_log <-
    add_action_to_log(
      graph_log = graph$graph_log,
      version_id = nrow(graph$graph_log) + 1,
      function_used = "recode_edge_attrs",
      time_modified = time_function_start,
      duration = graph_function_duration(time_function_start),
      nodes = nrow(graph$nodes_df),
      edges = nrow(graph$edges_df))

  # Write graph backup if the option is set
  if (graph$graph_info$write_backups) {
    save_graph_as_rds(graph = graph)
  }

  return(graph)
}
