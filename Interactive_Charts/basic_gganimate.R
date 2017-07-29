# gganimate
# http://www.gapminder.org/world/
# 움직이는 차트 그리기
devtools::install_github("dgrtwo/gganimate")
if (!require("magick")){install.packages("magick")}
library(magick)
library(gganimate)

# for mac
# brew install ghostscript imagemagick

# for ubuntu
# sudo apt-get install ghostscript imagemagick

# for windows
# http://www.imagemagick.org/script/binary-releases.php
# https://www.ghostscript.com/download/gsdnld.html

p <- ggplot(gapminder, aes(gdpPercap, lifeExp, size = pop, color = continent, frame = year)) +
  geom_point() +
  scale_x_log10()
p

# for windows
magickPath <- shortPathName("C:\\Program Files\\ImageMagick-7.0.5-Q16\\magick.exe")
animation::ani.options(convert=magickPath)
gganimate(p,interval = .2)

dir.create("./animate",showWarnings = F)
gganimate(p, "./animate/output.gif")
gganimate(p, "./animate/output.mp4")
gganimate(p, "./animate/output.html")
