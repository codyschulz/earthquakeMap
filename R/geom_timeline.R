#' Timeline Stat
#'
#' This stat prepares data for mapping by geom_timeline by subsetting the data
#' to the user-provided minimum and maximum dates
#'
#' @import ggplot2
#'
#' @return a stat
#'
#' @examples
#' \dontrun{
#' ggplot(clean_earthquake_data, aes(
#' x = date,
#' y = COUNTRY,
#' color = TOTAL_DEATHS,
#' size = EQ_PRIMARY
#' ),
#' n_max = 10) +
#' geom_timeline()
#' }
#'
#' @export
StatTimeline <- ggplot2::ggproto("StatTimeline", Stat,
                                  compute_group = function(data, scales) {

                                    data[data$x <= data$xmax & data$x >= data$xmin,]

                                  },
                                  required_aes = c("x", "xmin", "xmax")
)
#' stat_timeline
#'
#' This is the actual stat that prepares data for mapping by geom_timeline
#'
#' @importFrom ggplot2 layer
#'
#' @param mapping NULL
#' @param data NULL
#' @param geom polygon
#' @param position identity
#' @param na.rm FALSE
#' @param show.legend NA
#' @param inherit.aes TRUE
#' @param ... any other arguments passed to stat_timeline
#'
#' @return a stat
#'
#' @examples
#' \dontrun{
#' ggplot(clean_earthquake_data, aes(
#' x = date,
#' y = COUNTRY,
#' color = TOTAL_DEATHS,
#' size = EQ_PRIMARY
#' ),
#' n_max = 10) +
#' geom_timeline()
#' }
#'
#' @export
stat_timeline <- function(mapping = NULL, data = NULL, geom = "timeline", position = "identity",
                           na.rm = FALSE, show.legend = NA, inherit.aes = TRUE, ...) {
  ggplot2::layer(
    stat = StatTimeline,
    data = data,
    mapping = mapping,
    geom = geom,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(na.rm = na.rm, ...)
  )
}
#' Draw panel
#'
#' This further modifies the provided data for mapping within geom_timeline
#'
#' @importFrom grid segmentsGrob pointsGrob gpar gTree gList
#'
#' @param data the data.frame from the geom_timeline function call
#' @param panel_scales the panel_scales
#' @param coord the modified data.frame labeled by the parameters of aes()
#'
#' @return an object to be used in geom_timeline
#'
#' @examples
#' \dontrun{
#' ggplot(clean_earthquake_data, aes(
#' x = date,
#' y = COUNTRY,
#' color = TOTAL_DEATHS,
#' size = EQ_PRIMARY
#' ),
#' n_max = 10) +
#' geom_timeline()
#' }
#'
#' @export
draw_panel_function <- function(data, panel_scales, coord) {
  coords <- coord$transform(data, panel_scales)
  segment <- grid::segmentsGrob(
    x0 = coords$xmin,
    x1 = coords$xmax,
    y0 = coords$y,
    y1 = coords$y,
    gp = grid::gpar(
      col = "gray50",
      lwd = 1.5
    )
  )
  points <- grid::pointsGrob(
    x = coords$x,
    y = coords$y,
    size = unit(coords$size/4, "char"),
    pch = coords$shape,
    gp = grid::gpar(
      col = coords$colour,
      alpha = coords$alpha
    )
  )
  grid::gTree(children = grid::gList(segment, points))
}
#' GeomTimeline
#'
#' This function maps user-provided earthquake data
#'
#' @importFrom ggplot2 ggproto aes
#'
#' @return a geom
#'
#' @examples
#' \dontrun{
#' ggplot(clean_earthquake_data, aes(
#' x = date,
#' y = COUNTRY,
#' color = TOTAL_DEATHS,
#' size = EQ_PRIMARY
#' ),
#' n_max = 10) +
#' geom_timeline()
#' }
#'
#' @export
GeomTimeline <- ggplot2::ggproto("GeomTimeline", GeomPoint,
                                  required_aes = c("x", "xmin", "xmax"),
                                  default_aes = ggplot2::aes(alpha = 0.4, y = 0.5, colour = "black",
                                                             size = 1, shape = 19, stroke = 1,
                                                             fill = "red"),
                                  draw_key = draw_key_point,
                                  draw_panel = draw_panel_function
)
#' geom_timeline
#'
#' This actually does the plotting
#'
#' @importFrom ggplot2 layer
#'
#' @param mapping NULL
#' @param data NULL
#' @param stat timeline
#' @param position identity
#' @param show.legend NA
#' @param na.rm FALSE
#' @param inherit.aes TRUE
#' @param ... any other arguments passed to geom_timeline
#'
#' @return a ggplot object
#'
#' @examples
#' \dontrun{
#' ggplot(clean_earthquake_data, aes(
#' x = date,
#' y = COUNTRY,
#' color = TOTAL_DEATHS,
#' size = EQ_PRIMARY
#' ),
#' n_max = 10) +
#' geom_timeline()
#' }
#'
#' @export
geom_timeline <- function(mapping = NULL, data = NULL, stat = "timeline", position = "identity",
                           show.legend = NA, na.rm = FALSE, inherit.aes = TRUE, ...) {
  ggplot2::layer(
    data = data,
    mapping = mapping,
    stat = stat,
    geom = GeomTimeline,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(na.rm = na.rm, ...)
  )
}
