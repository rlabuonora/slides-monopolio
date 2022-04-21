# Monopolio

library(ggplot2)
library(ragg)
library(tidyverse)
library(extrafont)

#font_import(pattern="Montserrat")
loadfonts()

theme_set(
  theme_minimal(base_family = 'Montserrat') + 
    theme(plot.title = element_text(hjust=.5),
          plot.subtitle = element_text(hjust=.5)))

source(here::here("utils.R"))

demanda <- function(q) {
  3000 - 1/100 * q
}

img <- function(q) {
  3000 - 1/50 * q
}

cmg <- function(q) {
  1e3
}

colors <- c(cmg="#440154FF", img="#FDE725FF", demanda="#21908CFF")


# highlights



p1 <- ggplot(data.frame(x=seq(from=0, to=3e5, by=100)), aes(x)) + 
  geom_function(fun=demanda, aes(color="demanda")) + 
  geom_function(fun=img, aes(color="img")) + 
  geom_function(fun=cmg, aes(color="cmg")) + 
  scale_y_continuous(limits = c(-200, 3250)) +
  marcar_punto(100e3, 2e3) +
  marcar_punto(100e3, 1e3) +
  sombrear_area(demanda, cmg, 100e3, 200e3) +
  geom_vline(xintercept = 0) + 
  geom_hline(yintercept=0) + 
  scale_x_continuous(labels=scales::number_format()) +
  scale_color_manual("", values=colors, 
                     labels=c( "Costo Marginal",
                               "Demanda",
                               "Ingreso Marginal")) +
  annotate(
    geom = "curve", 
    x = 175e3, y = 2000, 
    xend = 155e3, yend = 1600, 
    curvature = -.1, arrow = arrow(length = unit(2, "mm"))
  ) +
  annotate(
    geom="text",
    size=3.5,
    x=175e3,y=2100, label="Pérdida de Eficiencia"
  ) +
  labs(x="Q", y="P", title="Ejercicio 2") 

ggsave("imgs/ejercicio_1.png", 
       dpi=300,
       height=5, width=6)


