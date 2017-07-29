library(ggplot2)
ggplot(mtcars) +
  geom_point(aes(wt, mpg), color = 'red') +
  geom_text(aes(wt, mpg, 
                label = rownames(mtcars))) +
  theme_classic(base_size = 16)

########################################3
if (!require(ggrepel)){
  devtools::install_github("slowkow/ggrepel")}
library(ggrepel)

ggplot(mtcars) +
  geom_point(aes(wt, mpg), color = 'red') +
  geom_text_repel(aes(wt, mpg, 
                      label = rownames(mtcars))) +
  theme_classic(base_size = 16)
