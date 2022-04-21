marcar_punto <- function(x, y, linetype="dashed") {
  list(
    geom_segment(x=x, y=0, xend=x, yend=y, color="gray50",
                 linetype="dotted", inherit.aes = FALSE),
    geom_segment(x=0, y=y, xend=x, yend=y,  color="gray50",
                 linetype="dotted", inherit.aes = FALSE),
    geom_point(x=x, y=y, inherit.aes = FALSE)
  )
}

sombrear_area <- function(f_1, f_2, x_min, x_max, by=1, alpha=.3) {
  df <- data.frame(
    x=seq(from=x_min, to=x_max, by=by)
  ) %>% 
    mutate(y_1=f_1(x),
           y_2=f_2(x))
  
  geom_ribbon(data=df, aes(x=x, ymin=y_1, ymax=y_2), alpha=alpha)
}