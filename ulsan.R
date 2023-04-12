library(tidyverse)
library(readxl)
library(extrafont)
theme_set(theme_gray(base_family='AppleGothic'))


industry <- read_excel('total_industry.xlsx') %>% 
  .[, -1]

ulsan <- industry %>% 
  filter(지역 == "울산" & `산업별(1)` %in% c("조선", "자동차", "화학", "계")) %>% 
  rename(산업=`산업별(1)`)

ulsan_ratio <- ulsan %>% 
  mutate(irr_rate = 비정규직 / 정규직)

ggplot(ulsan_ratio, aes(x = 시점, y = 공학계/소계)) +

ggplot(ulsan_ratio, aes(x = 시점, y = (공학계+자연계)/소계)) +
  geom_line(aes(color = 산업)) +
  geom_text(aes(color = 산업, label = round((공학계+자연계)/소계, 2))) +
  labs(title = "울산의 자연계+공학계 대졸자 이상 산업기술인력")

?geom_text

ggplot(ulsan_ratio, aes(x = 시점, y = (석사+박사)/소계)) +
  geom_line(aes(color = 산업))
