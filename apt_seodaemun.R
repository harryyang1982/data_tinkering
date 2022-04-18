library(tidyverse)
library(readxl)
library(plotly)

theme_set(theme_gray(base_family='AppleGothic'))
seodaemun <- read_excel("datasets/apttotal.xlsx")

seodaemun %>% 
  rename(전용면적=`전용면적(㎡)`) %>% 
  mutate(전용면적 = as.character(전용면적)) %>% 
  group_by(계약년월, 계약일, 단지명, 전용면적) %>% 
  summarize(mean = mean(거래금액)) -> by_danji


by_danji %>% 
  mutate(계약일 = ifelse(nchar(as.character(계약일))==1,
                      paste0("0", as.character(계약일)), as.character(계약일)),
            contract = lubridate::ymd(paste0(계약년월, 계약일))) %>% 
  filter(단지명 %in% c("홍제한양", "홍제현대")) %>% 
  ggplot(aes(x = contract,
             y = mean,
             color = 전용면적,
             group = 전용면적)) +
  geom_line() +
  facet_wrap(~단지명, scale="free_y") -> g1

ggplotly(g1)
