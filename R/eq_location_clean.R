#' Clean earthquake data location column
#'
#' This function cleans the raw earthquake data location column, removing the
#' country part of the string
#'
#' @param raw_data1 The raw earthquake data.frame
#'
#' @return An earthquake data.frame with a cleaned LOCATION_NAME column
#'
#' @examples
#' \dontrun{
#' eq_location_clean(raw_earthquake_data)
#' }
#'
#' @note the function will throw an error if raw_data is not a data.frame
#'
#' @export
eq_location_clean <- function(raw_data1) {

  if(!"data.frame" %in% class(raw_data1)) {
    stop("raw_data must be a data.frame")
  } else {

    raw_data1$loc0 <- gsub("^[^:]*:", "", raw_data1$LOCATION_NAME)

    raw_data1$loc1 <- gsub("(?<=\\b)([a-z])", "\\U\\1", tolower(raw_data1$loc0), perl=TRUE)

    raw_data1$LOCATION_NAME <- sub("  ", " ", trimws(sub(",.*|:.*", "", raw_data1$loc1)))

    raw_data1

  }
}
