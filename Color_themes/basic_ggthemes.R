if (!require(ggthemes)){
  devtools::install_github("jrnold/ggthemes")}
library("ggthemes")
p1_th1 <- p1 + 
  theme_hc() +
  scale_colour_hc()
p2_th2 <- p2 + 
  theme_hc(bgcolor = "darkunica") +
  scale_fill_hc("darkunica")
grid.arrange(p1_th1, p2_th2, ncol = 2)
