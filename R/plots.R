library(dplyr)
library(ggplot2)

plot_standards <- function(qpcrdata) {
  #' Parse the text output from a Statagene qPCR machine.
  #'
  #' @param qpcrdata dataframe
  #' @return a ggplot2 plot object with standard curves
  #' @examples
  #' \dontrun{
  #' plot_standards(df)
  #' }
  standards <- qpcrdata %>% filter(Well_Type == "Standard")
  standard_curve <- standards %>%
    ggplot(aes(y=Ct, x=Copies_PCR, colour = Assay)) +
    geom_point() +
    scale_x_log10() +
    geom_smooth(method = lm, se = FALSE) +
    labs(title = "Standards")
  standard_curve
}
