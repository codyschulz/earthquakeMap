#' Create a Leaflet map label
#'
#' This function builds a label for the leaflet map popup based off of the
#' location, magnitude, and death toll of the earthquake represented in the
#' data
#'
#' @param x A clean earthquake data.frame
#'
#' @return The clean earthquake data.frame with a popup_text variable
#'
#' @examples
#' \dontrun{
#' clean_earthquake_data$popup_text <- eq_create_label(clean_earthquake_data)
#' }
#'
#' @note the function will throw an error if x is not a data.frame
#'
#' @export
eq_create_label <- function(x) {

  if(!"data.frame" %in% class(x)) {
    stop("x must be a data.frame")
  } else {

    x$popup_text0 <- ""
    x$popup_text1 <- ifelse(
      !is.na(x$LOCATION_NAME),
      paste(x$popup_text0, "<b>Location: </b>", x$LOCATION_NAME, "<br />"),
      x$popup_text0
    )
    x$popup_text2 <- ifelse(
      !is.na(x$EQ_PRIMARY),
      paste(x$popup_text1, "<b>Magnitude: </b>", x$EQ_PRIMARY, "<br />"),
      x$popup_text1
    )
    x$popup_text <- ifelse(
      !is.na(x$TOTAL_DEATHS),
      paste(x$popup_text2, "<b>Total deaths: </b>", x$TOTAL_DEATHS, "<br />"),
      x$popup_text2
  )
  }
}
