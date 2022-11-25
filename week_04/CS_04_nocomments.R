library(tidyverse)
library(nycflights13)

df_sub = flights %>% 
  dplyr::select(tailnum, flight, origin, dest, distance) %>% # 只选择需要的列 
  unique() %>% # 删除重复的列
  arrange(desc(distance)) %>% # 安排距离 
  slice(1) %>%  # 获得最远距离 
  left_join(., airports, c("dest" = "faa")) # 加入 airpots 以查找完整的 airpot 名称

df_sub

farthest_airport = df_sub %>% pull(name)
farthest_airport