if (!require("ggmap"))
{devtools::install_github("dkahle/ggmap")}

library(ggplot2)
library(ggmap)
# for mac, Linux
loc<-"서울"
tar<-"서울시청"
# for windows
loc<-URLencode(enc2utf8("서울"))
tar<-URLencode(enc2utf8("서울시청"))

geocityhall<-geocode(tar)
get_googlemap(loc,
              maptype = "roadmap", 
              markers = geocityhall) %>% 
  ggmap()

library(data.table)
wifi<-fread("~/Data_Mining/R_Study/dabrp_classnote2/data/wifi.csv")
sw<-wifi[grep("서울", 소재지도로명주소),.(관리기관명,위도,경도)]
sw<-unique(sw)
names(sw)<-c("ser","lat","lon")
sw<-data.frame(sw)
get_googlemap(loc, maptype = "roadmap", zoom = 11) %>% ggmap() + 
  geom_point(data=sw, aes(x=lon, y=lat, color=ser)) + theme(legend.position="none")

## UTM / UTM-K / GPS
## 좌표계에 대한 설명
# https://mrchypark.wordpress.com/2014/10/23/%EC%A2%8C%ED%91%9C%EA%B3%84-%EB%B3%80%ED%99%98-proj4-%EB%9D%BC%EC%9D%B4%EB%B8%8C%EB%9F%AC%EB%A6%AC/

# 패키지 세팅하기
if (!require("mapdata")){install.packages("mapdata")}
if (!require("mapproj")){install.packages("mapproj")}
library(mapdata)
library(mapproj)

# 내장된 지도 데이터 불러와서 한국만 가져오기
world<-map_data("worldHires")
korea<-world[grep("Korea$", world$region),]

# 한국 지도 그리기
p<-ggplot(korea,aes(x=long,y=lat,group=group))
p+geom_polygon(fill="white",color="black") + coord_map()
