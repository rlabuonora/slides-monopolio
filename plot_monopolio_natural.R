library(ggplot2)
library(tidyverse)
library(extrafont)
source(here::here("utils.R"))
loadfonts()



theme_set(
  theme_minimal(base_family = 'Montserrat') +
    theme(plot.title=element_text(hjust=.5)))

# Figure 13.3
cme_df <- tibble(x=c(4,  5,  6,  7,  8,  9,  10), 
                 y=c(50, 40, 35, 32, 30, 29, 28))

d_df <- tibble(x=c(0,   5),
               y=c(110, 60))

img_df <- tibble(x=c(0,   5),
                 y=c(110, 10))

cmg_df <- tibble(x=c(0, 5),
                 y=c(10, 10))

cme_fun <- splinefun(cme_df$x, cme_df$y)
d_fun <- splinefun(d_df$x, d_df$y)
img_fun <- splinefun(img_df$x, img_df$y)
cmg_fun <- splinefun(cmg_df$x, cmg_df$y)


# x_highlight <- uniroot(function(x) lrac_fun(x)-d_fun(x), c(0, 5))$root
# y_highlight <- lrac_fun(x_highlight)

ggplot(data.frame(x=0, y=0)) + 
  geom_function(fun=cme_fun, xlim=c(3, 10)) +
  geom_function(fun=d_fun, xlim=c(0, 12)) +
  geom_function(fun=img_fun, xlim=c(0, 5.5)) +
  geom_function(fun=cmg_fun, xlim=c(0, 14)) +
  scale_y_continuous(limits = c(0, 120),
                     breaks=c(0, 10, 30, 40, 60)) +
  scale_x_continuous(limits = c(0, 12.5),
                     breaks=c(0, 5, 8, 10)) +
  geom_vline(xintercept = 0) +
  geom_hline(yintercept = 0) +
  marcar_punto(5, 10) +
  marcar_punto(5, 40) +
  marcar_punto(5, 60) +
  marcar_punto(8, 30) +
  marcar_punto(10, 10) +
  annotate("text", label="CMg", x=11, y=16) +
  annotate("text", label="CMe", x=10.8, y=30) +
  annotate("text", label="D", x=11.25, y=4.8) +
  annotate("text", label="Img", x=6.25, y=4.8) +
  labs(title="Monopolio Natural", x="Q", y="Precio y Costos")

ggsave("imgs/monopolio_natural.png", 
       dpi=300,
       height=5, width=4)
