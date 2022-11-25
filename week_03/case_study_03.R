library(dplyr)
library(ggplot2)
library(gapminder)

data(gapminder)
gapminder2 = filter(gapminder,country != "Kuwait")
head(gapminder2)
glimpse(gapminder2)

ggplot(gapminder2) + geom_point(aes(x = lifeExp, y = gdpPercap, size=pop/100000, color = continent)) + facet_wrap(~year, nrow = 1) + scale_y_sqrt() + theme_bw() + labs(x = "Life Expectancy", y = "GDP per capita", size = "Population (100k)", color = "Continent", title = "Weather and life expectancy through time") + theme(axis.text.x = element_text(size = 12),axis.text.y = element_text(size = 12),title = element_text(size = 18))
ggsave(
  filename = "Plot1 .png", # 保存的文件名称。通过后缀来决定生成什么格式的图片
  width = 17,             # 宽
  height = 9,            # 高
  units = "in",          # 单位
  dpi = 300              # 分辨率DPI
)

gapminder3 = gapminder2 %>% 
  group_by(continent, year) %>% 
  summarise(gdpPercapweighted = weighted.mean(x = gdpPercap, w = pop), 
                   pop = sum(as.numeric(pop)))                   

ggplot(gapminder2) + geom_line(aes(x = year, y = gdpPercap, color = continent, group = country)) + geom_point(aes(x = year, y = gdpPercap, color = continent, group = country)) + geom_point(data = gapminder3, aes(x = year, y = gdpPercapweighted, size = pop/100000)) + geom_line(data = gapminder3, aes(x = year, y = gdpPercapweighted)) + facet_wrap(~continent, nrow = 1) + theme_bw() + labs(x = "Year", y = "GDP per capita", size = "Population (100k)", color = "Continent") + theme(axis.text.x = element_text(size = 12),axis.text.y = element_text(size = 12),title = element_text(size = 18))
ggsave(
  filename = "Plot2 .png", # 保存的文件名称。通过后缀来决定生成什么格式的图片
  width = 24,             # 宽
  height = 7,            # 高
  units = "in",          # 单位
  dpi = 300              # 分辨率DPI
)

gapminder3