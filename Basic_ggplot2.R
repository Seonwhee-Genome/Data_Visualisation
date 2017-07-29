if (!require("gapminder")){install.packages("gapminder")}

library(ggplot2)
library(gridExtra)
library(dplyr)
p <- ggplot(gapminder)
plot1 <- p + aes(x=pop) + geom_histogram()
plot2 <- p + aes(x=continent, y=lifeExp) + geom_violin() + stat_summary(color="blue")
continent_freq <- gapminder %>% count(continent)
plot3 <- ggplot(continent_freq, aes(x = continent, y = n)) + geom_bar(stat = "identity")
jCountries <- c("Canada", "Rwanda", "Cambodia", "Mexico")
plot4 <- gapminder %>% filter(country %in% jCountries) %>%
  ggplot(aes(x = year, y = lifeExp, color = country)) +
  geom_line() + geom_point()
grid.arrange(plot1, plot2, plot3, plot4, nrow=2, ncol=2)

dir.create("./ggsave", showWarnings = F)
ggsave("./ggsave/gapminder.png")