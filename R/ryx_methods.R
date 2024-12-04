#' Print method for ryx objects
#'
#' @param x An object of class ryx.
#'
#' @export
#' @examples
#' library(MASS)
#' x <- ryx(Boston, y = "medv")
#' print(x)

print.ryx <- function(x, ...) {
  x$df$p <- signif(x$df$p, 3)

  x$df$p <- ifelse(x$df$p < 2e-16, "< 2e-16", format(x$df$p, scientific = TRUE))

  cat("Correlations of", x$y, "with\n")
  print(x$df, row.names = FALSE)
}


#' Summary method for ryx objects
#'
#' @param object An object of class ryx.
#'
#' @import stats
#'
#' @examples
#' library(MASS)
#' x <- ryx(Boston, y = "medv")
#' summary(x)
#'
#' @export
summary.ryx <- function(object, ...) {
  cat("Correlating", object$y, "with", paste(object$x, collapse = " "), "\n")
  median_r <- median(abs(object$df$r))
  cat("The median absolute correlation was", format(median_r, digits = 3),
      "with a range from", format(min(object$df$r), digits = 3),
      "to", format(max(object$df$r), digits = 3), "\n")
  significant <- sum(object$df$p < 0.05)
  cat(significant, "out of", nrow(object$df), "variables were significant at the p < 0.05 level.\n")
}

#' Plot method for ryx objects
#'
#' @param x An object of class ryx.
#'
#' @import ggplot2
#' @import dplyr
#'
#' @examples
#' library(MASS)
#' x <- ryx(Boston, y = "medv")
#' plot(x)
#'
#' @export

plot.ryx <- function(x, ...) {
  library(ggplot2)
  library(dplyr)

  x$df <- x$df %>%
    mutate(direction = ifelse(r > 0, "positive", "negative"),
           abs_r = abs(r)) %>%
    arrange(abs_r)

  ggplot(data = x$df, aes(y = reorder(variable, abs_r), x = abs_r)) +
    geom_segment(aes(x = 0, xend = abs_r, yend = variable), color = "gray") +
    geom_point(aes(color = direction), size = 3) +
    scale_color_manual(values = c("negative" = "red", "positive" = "blue"),
                       name = "Direction") +
    labs(x = "Correlation (absolute value)",
         y = "Variables",
         title = paste("Correlations with", x$y)) +
    theme_minimal() +
    theme(
      axis.text.y = element_text(size = 10),
      axis.title.y = element_text(size = 12),
      axis.title.x = element_text(size = 12)
    )
}
