## korean map

# Kormaps를 이용해 세부적인 한국 지도 그리기
# 패키지 세팅하기
if (!require("httpuv")){install.packages("httpuv")}
if (!require("rgdal")){install.packages("rgdal")}
if (!require("leaflet")){install.packages("leaflet")}
if (!require("crosstalk")){install.packages("crosstalk")}
if (!require("Kormaps")){devtools::install_github("cardiomoon/Kormaps")}
if (!require("tmap")){install.packages("tmap")}
if (!require("cartogram")){devtools::install_github("sjewo/cartogram")}
library(Kormaps)
library(tmap)
library(cartogram)

# 윈도우를 위한 폰트 설정하기
# for windows
windowsFonts()
if (!require("extrafont")){install.packages("extrafont")}
library(extrafont)
#font_import()
loadfonts()

# 내장 인구 데이터를 이용해 한국 지도 그리기
qtm(kormap1)
qtm(korpopmap1,"총인구_명")+tm_layout(fontfamily="NanumGothic")
qtm(korpopmap2,"총인구_명")+tm_layout(fontfamily="NanumGothic")

# 인코딩 문제 고치기
Encoding(names(korpopmap1))<-"UTF-8"
Encoding(names(korpopmap2))<-"UTF-8"
# ggplot 으로 한국 지도 그리기 위한 전처리
kor <- fortify(korpopmap1, region = "id")
kordf <- merge(kor, korpopmap1@data, by = "id")

# ggplot으로 한국 지도 그리기
ggplot(kordf, aes(x=long.x, y=lat.x, group=group.x, fill=`총인구_명`)) + 
  geom_polygon(color="black") + coord_map() +
  scale_fill_gradient(high = "#132B43", low = "#56B1F7") +
  theme(title=element_text(family="NanumGothic",face="bold"))

# ggplot facet 기능 적용해 보기
# 남녀 인구로 구분
kordfs <- kordf %>% select(id:여자_명) %>% gather(성별,인구,-(id:총인구_명))

# 남녀 인구 한국 지도 시각화
ggplot(kordfs, aes(x=long.x, y=lat.x, group=group.x, fill=`인구`)) + 
  geom_polygon(color="black") + coord_map() +
  scale_fill_gradient(high = "#132B43", low = "#56B1F7") +
  theme(text=element_text(family="NanumGothic",face="bold")) +
  facet_grid(.~ 성별)