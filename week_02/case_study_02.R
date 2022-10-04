library(tidyverse)
# define the link to the data - you can try this in your browser too.  Note that the URL ends in .txt.
dataurl="https://data.giss.nasa.gov/tmp/gistemp/STATIONS/tmp_USW00014733_14_0_1/station.txt"

#the next line tells the NASA site to create the temporary file
httr::GET("https://data.giss.nasa.gov/cgi-bin/gistemp/stdata_show_v4.cgi?id=USW00014733&ds=14&dt=1")

# the next lines download the data
temp=read_table(dataurl,
              skip=3, #skip the first line which has column names
              na="999.90", # tell R that 999.90 means missing in this dataset
              col_names = c("YEAR","JAN","FEB","MAR", # define column names 
                            "APR","MAY","JUN","JUL",  
                            "AUG","SEP","OCT","NOV",  
                            "DEC","DJF","MAM","JJA",  
                            "SON","metANN"))
# renaming is necessary becuase they used dashes ("-")
# in the column names and R doesn't like that.

head(temp)

dat = temp[,7:9]
years = temp[,1]
class(dat)

row_mean = apply(dat,1,mean)
JJA_mean = data.frame(row_mean)
JJA_years = cbind(years,JJA_mean)

library(ggplot2)

ggplot(data = JJA_years, mapping = aes(x = YEAR, y = row_mean, group = 1)) + geom_line() + geom_smooth(method='loess') + labs(x = "Year", y = "Mean Summer Temperatures (C°)",
       title = "Mean Summer Temperatures in Buffalo, NY", #添加主标题
       subtitle = "Summer includes June, July, and August 
       Data from the Global Historical Climate Network 
       Blue line is a LOESS smooth", #添加次标题
       caption = "Data: NASA",#下备注
       tag = "Fig. 1") + theme(axis.text.x = element_text(size = 20),axis.text.y = element_text(size = 20),title = element_text(size = 30))

ggsave(
  filename = "Mean Summer Temperatures in Buffalo.png", # 保存的文件名称。通过后缀来决定生成什么格式的图片
  width = 17,             # 宽
  height = 9,            # 高
  units = "in",          # 单位
  dpi = 300              # 分辨率DPI
)