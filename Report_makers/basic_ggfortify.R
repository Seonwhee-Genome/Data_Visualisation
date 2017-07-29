# ggfortify
# https://github.com/sinhrks/ggfortify
# 분석 결과 보고용 출력 수준 차트 생성 패키지 1
devtools::install_github('sinhrks/ggfortify')
library(ggfortify)
# 자동으로 분석 결과에 맞는 그림 출력하기 
# k-means 클러스터링
res <- lapply(c(3, 4, 5), function(x) kmeans(iris[-5], x))
autoplot(res, data = iris[-5], ncol = 3)

# 회귀 분석
autoplot(lm(Petal.Width ~ Petal.Length, data = iris), data = iris,
         colour = 'Species', label.size = 3)

if (!require("dlm")){install.packages("dlm")}
library(dlm)
form <- function(theta){
  dlmModPoly(order = 1, dV = exp(theta[1]), dW = exp(theta[2]))
}
# 동적선형분석
model <- form(dlmMLE(Nile, parm = c(1, 1), form)$par)
filtered <- dlmFilter(Nile, model)
autoplot(filtered)