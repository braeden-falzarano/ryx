#' @title Calculate Correlations
#'
#' @description This function calculates the correlation of a target variable (`y`) with one or more numeric predictor variables (`x`).
#'
#' @param data A data frame containing the variables.
#' @param y A string specifying the name of the target variable.
#' @param x A character vector of predictor variable names. If not specified, all numeric variables except `y` are used.
#'
#' @return An object of class `ryx`, containing:
#' \describe{
#'   \item{y}{The target variable name.}
#'   \item{x}{The predictor variable names.}
#'   \item{df}{A data frame with the correlation results, including variables, correlations, p-values, and significance levels.}
#' }
#'
#' @examples
#' library(MASS)
#' ryx(Boston, y = "medv")
#'
#' @export


ryx <- function(data, y, x){
  if(missing(x)){
    x <- names(data)[sapply(data, class)=="numeric"]
    x <- setdiff(x, y)
  }
  df <- data.frame()
  for (var in x){
    res <- cor.test(data[[y]], data[[var]])
    df_temp <- data.frame(variable = var,
                          r = res$estimate,
                          p = res$p.value)
    df <- rbind(df, df_temp)
    df <- df[order(-abs(df$r)),]
  }

  df$sigif <- ifelse(df$p < .001, "***",
                     ifelse(df$p < .01, "**",
                            ifelse(df$p < .05, "*", " ")))
  results <- list(y=y, x=x, df=df)
  class(results) <- "ryx"
  return(results)
}
