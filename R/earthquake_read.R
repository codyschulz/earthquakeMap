##############################
# earthquake_read() function #
##############################

#' Read earthquake data
#'
#' This function reads in the earthquake file and turns into a dplyr tbl_df
#'
#' @importFrom readr read_csv
#' @importFrom dplyr tbl_df
#'
#' @return A dplyr tbl_df of the raw earthquake data
#'
#' @examples
#' \dontrun{
#' earthquake_read()
#' }
#'
#' @export
earthquake_read <- function() {
  data <- suppressMessages(
    readr::read_delim(system.file("extdata", "signif.txt", package = "earthquakeMap"), delim = "\t")
  )
  dplyr::tbl_df(data)
}

