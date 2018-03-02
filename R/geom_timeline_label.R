#' Timeline Label Stat
#'
#' This stat prepares data for mapping by geom_timeline by subsetting the data
#' to the user-provided minimum and maximum dates as well as to the number of
#' earthquakes specified by the user in the n_max variable
#'
#' @importFrom ggplot2 ggproto
#'
#' @return a stat
#'
#' @examples
#' \dontrun{
#' ggplot(clean_earthquake_data, aes(
#' x = date,
#' y = COUNTRY,
#' color = TOTAL_DEATHS,
#' size = EQ_PRIMARY,
#' label = LOCATION_NAME
#' ),
#' n_max = 10) +
#' geom_timeline_label()
#' }
#'
#' @export
StatTimelineLabel <- ggplot2::ggproto("StatTimeline", Stat,
                                 compute_group = function(data, scales, n_max = Inf) {

                                   data1 <- data[data$x <= data$xmax & data$x >= data$xmin,]

                                   if(n_max == Inf) {
                                     n_max <- nrow(data1)
                                   } else {
                                     n_max <- n_max
                                   }

                                   data2 <- data1[order(-data1$size),]

                                   data2[1:n_max,]

                                 },
                                 required_aes = c("x", "xmin", "xmax")
)
#' stat_timeline_label
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
#' @param ... any other arguments passed to stat_timeline_label
#' @param n_max the maximum number of earthquakes to be plotted
#'
#' @return a stat
#'
#' @examples
#' \dontrun{
#' ggplot(clean_earthquake_data, aes(
#' x = date,
#' y = COUNTRY,
#' color = TOTAL_DEATHS,
#' size = EQ_PRIMARY,
#' label = LOCATION_NAME
#' ),
#' n_max = 10) +
#' geom_timeline_label()
#' }
#'
#' @export
stat_timeline_label <- function(mapping = NULL, data = NULL, geom = "timeline_label", position = "identity",
                          na.rm = FALSE, show.legend = NA, inherit.aes = TRUE, n_max = Inf, ...) {
  ggplot2::layer(
    stat = StatTimelineLabel,
    data = data,
    mapping = mapping,
    geom = geom,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(na.rm = na.rm, n_max = Inf, ...)
  )
}
#' Label Draw panel
#'
#' This further modifies the provided data for mapping within geom_timeline_label
#'
#' @importFrom grid segmentsGrob pointsGrob gpar gTree
#'
#' @param data the data.frame from the geom_timeline_label function call
#' @param panel_scales the panel_scales
#' @param coord the modified data.frame labeled by the parameters of aes()
#'
#' @return an object to be used in geom_timeline_label
#'
#' @examples
#' \dontrun{
#' ggplot(clean_earthquake_data, aes(
#' x = date,
#' y = COUNTRY,
#' color = TOTAL_DEATHS,
#' size = EQ_PRIMARY,
#' label = LOCATION_NAME
#' ),
#' n_max = 10) +
#' geom_timeline_label()
#' }
#'
#' @export
label_draw_panel_function <- function(data, panel_scales, coord) {
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
  label_segments <- grid::segmentsGrob(
    x0 = coords$x,
    x1 = coords$x,
    y0 = coords$y,
    y1 = coords$y + 0.1,
    gp = grid::gpar(
      col = "gray50",
      lwd = 1.5
    )
  )
  label_text <- grid::textGrob(
    label = coords$label,
    x = unit(coords$x, "npc"),
    y = unit(coords$y + 0.1, "npc"),
    rot = 45,
    vjust = -0.5,
    hjust = 0,
    check.overlap = TRUE,
    gp = grid::gpar(
      fontsize = 7
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
  grid::gTree(children = grid::gList(segment, label_segments, label_text, points))
}
#' GeomTimelineLabel
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
#' size = EQ_PRIMARY,
#' label = LOCATION_NAME
#' ),
#' n_max = 10) +
#' geom_timeline_label()
#' }
#'
#' @export
GeomTimelineLabel <- ggplot2::ggproto("GeomTimelineLabel", GeomPoint,
                                 required_aes = c("x", "xmin", "xmax", "label"),
                                 default_aes = ggplot2::aes(alpha = 0.4, y = 0.5, colour = "black",
                                                            size = 1, shape = 19, stroke = 1,
                                                            fill = "red"),
                                 draw_key = draw_key_point,
                                 draw_panel = label_draw_panel_function
)
#' geom_timeline_label
#'
#' This actually does the plotting
#'
#' @importFrom ggplot2 layer
#'
#' @param mapping NULL
#' @param data NULL
#' @param stat timeline_label
#' @param position identity
#' @param show.legend NA
#' @param na.rm FALSE
#' @param inherit.aes TRUE
#' @param ... any other arguments passed to geom_timeline_label
#'
#' @return a ggplot object
#'
#' @examples
#' \dontrun{
#' ggplot(clean_earthquake_data, aes(
#' x = date,
#' y = COUNTRY,
#' color = TOTAL_DEATHS,
#' size = EQ_PRIMARY,
#' label = LOCATION_NAME
#' ),
#' n_max = 10) +
#' geom_timeline_label()
#' }
#'
#' @export
geom_timeline_label <- function(mapping = NULL, data = NULL, stat = "timeline_label", position = "identity",
                          show.legend = NA, na.rm = FALSE, inherit.aes = TRUE, ...) {
  ggplot2::layer(
    data = data,
    mapping = mapping,
    stat = stat,
    geom = GeomTimelineLabel,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(na.rm = na.rm, ...)
  )
}
