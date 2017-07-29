# ggally
# http://ggobi.github.io/ggally/index.html
# 분석 결과 보고용 출력 수준 차트 생성 패키지 2
devtools::install_github("ggobi/ggally")
if (!require("network")){install.packages("network")}
if (!require("sna")){install.packages("sna")}
library(network)
library(sna)
library(GGally)
airports <- read.csv("http://datasets.flowingdata.com/tuts/maparcs/airports.csv", header = TRUE)
rownames(airports) <- airports$iata

# 무작위로 일부 비행기만 선택
flights <- data.frame(
  origin = sample(airports[200:400, ]$iata, 200, replace = TRUE),
  destination = sample(airports[200:400, ]$iata, 200, replace = TRUE)
)

# network 자료형으로 변환
flights <- network(flights, directed = TRUE)

# 위경도 정보 추가 %v%는 각 노드 정보라는 뜻의 연산자
flights %v% "lat" <- airports[ network.vertex.names(flights), "lat" ]
flights %v% "lon" <- airports[ network.vertex.names(flights), "long" ]
flights

# 혼자 있는 노드 제거
delete.vertices(flights, which(degree(flights) < 2))

# 중심성 계산
flights %v% "degree" <- degree(flights, gmode = "digraph")

# 랜덤으로 4개의 집단으로 구분
flights %v% "mygroup" <- sample(letters[1:4], network.size(flights), replace = TRUE)

# 미국지도만 생성
usa <- ggplot(map_data("usa"), aes(x = long, y = lat)) +
  geom_polygon(aes(group = group), color = "grey65",
               fill = "#f9f9f9", size = 0.2)

# 미국내 정보 이외에 제거
delete.vertices(flights, which(flights %v% "lon" < min(usa$data$long)))
delete.vertices(flights, which(flights %v% "lon" > max(usa$data$long)))
delete.vertices(flights, which(flights %v% "lat" < min(usa$data$lat)))
delete.vertices(flights, which(flights %v% "lat" > max(usa$data$lat)))

# 미국 지도 위에 비행기 layer 추가하기
ggnetworkmap(usa, flights, size = 4, great.circles = TRUE,
             node.group = mygroup, segment.color = "steelblue",
             ring.group = degree, weight = degree)
