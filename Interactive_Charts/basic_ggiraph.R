# ggiraph
# http://davidgohel.github.io/ggiraph/
# javescript 기반 동적 차트 생성 패키지
devtools::install_github("davidgohel/ggiraph")
install.packages("ggiraph")
library(ggiraph)
# 기본 그래프 그리기
g <- ggplot(mpg, aes( x = displ, y = cty, color = hwy) ) + theme_minimal()
g + geom_point(size = 2) 

# 폰트가 여기서 나오지 않으면 ggiraph가 출력되지 않습니다.
gdtools::sys_fonts()
# if data NUll try below for mac
# brew install cairo
# tooltip 기능을 활용한 동적 차트 예
my_gg <- g + geom_point_interactive(aes(tooltip = model), size = 2) 
ggiraph(code = print(my_gg), width = .7)
