#' Create a leaflet map of earthquake data
#'
#' This function reads in a given file and turns into a table.
#'
#' @importFrom leaflet leaflet addTiles addCircleMarkers
#' @importFrom magrittr %>%
#'
#' @param x a clean earthquake data.frame
#' @param annot_col a character vector from the earthquake data.frame used to label the popups on the map
#'
#' @return A leaflet map
#'
#' @examples
#' \dontrun{
#' eq_map(clean_earthquake_data, "date")
#' eq_map(cleaned_earthquake_data, "TOTAL_DEATHS")
#' }
#'
#' @note the function will throw an error if x is not a data.frame
#' @note the function will throw an error if annot_col is not a non-null column of x
#'
#' @export
eq_map <- function(x, annot_col) {

  if(!"data.frame" %in% class(x)) {
    stop("x must be a data.frame")
  } else {

    col <- x[[annot_col]]

    if(is.null(col)) {
      stop("col is not a non-null column of x")
    } else {

        leaflet::leaflet() %>%
        leaflet::addProviderTiles("CartoDB.Positron") %>%
        leaflet::addCircleMarkers(data = x, lng = ~ LONGITUDE, lat = ~ LATITUDE, radius = ~ EQ_PRIMARY,
                                  stroke = TRUE, weight = 2, opacity = 0.4, fillOpacity = 0.2, popup = col)
    }
  }
}
