#' Clean earthquake data
#'
#' This function cleans raw earthquake data. It creates a date column, cleans
#' the location column, and converts the latitute and longtitude columns to numeric
#'
#' @importFrom dplyr case_when between
#' @importFrom stringr str_pad
#'
#' @param raw_data The raw earthquake data.frame
#'
#' @return A cleaned earthquake data.frame
#'
#' @examples
#' \dontrun{
#' eq_clean_data(raw_earthquake_data)
#' }
#'
#' @note the function will throw an error if raw_data is not a data.frame
#'
#' @export
eq_clean_data <- function(raw_data) {

  if(!"data.frame" %in% class(raw_data)) {
    stop("raw_data must be a data.frame")
  } else {

    raw_data <- raw_data[raw_data$YEAR > 0,]

    raw_data$month0 <- ifelse(is.na(raw_data$MONTH), 01, raw_data$MONTH)
    raw_data$day0 <- ifelse(is.na(raw_data$DAY), 01, raw_data$DAY)

    raw_data$year0 <- dplyr::case_when(
      dplyr::between(raw_data$YEAR, 0, 999) ~ stringr::str_pad(as.character(raw_data$YEAR), 4, side = "left", pad = "0"),
      TRUE ~ as.character(raw_data$YEAR)
    )
    raw_data$date <- as.Date(paste(raw_data$year0, raw_data$month0, raw_data$day0, sep = "-"))

    raw_data$LATITUDE <- as.numeric(raw_data$LATITUDE)

    raw_data$LONGITUDE <- as.numeric(raw_data$LONGITUDE)

    raw_data$TOTAL_DEATHS <- as.numeric(raw_data$TOTAL_DEATHS)

    raw_data$EQ_PRIMARY <- as.numeric(raw_data$EQ_PRIMARY)

    eq_location_clean(raw_data)

  }
}
