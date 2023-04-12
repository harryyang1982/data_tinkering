library(tidyverse)
library(readxl)
library(extrafont)
theme_set(theme_gray(base_family='AppleGothic'))

fert <- read_excel("fertility.xlsx") %>% 
  fill(시점) %>% 
  mutate(시점 = parse_integer(시점))

fert

ggplot(fert, aes(x = 시점, 
                 y = 합계출산율)) +
  geom_line(aes(color = 시도별)) +
  geom_text(aes(label = 합계출산율,
                color = 시도별)) +
  labs(title = "출산율 비교(합계출산율)",
       subtitle = "전국, 서울, 부산, 경남, 울산",
       x = "시점", y = "출산율")
