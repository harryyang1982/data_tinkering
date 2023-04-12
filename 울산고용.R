library(tidyverse)
library(readxl)
library(extrafont)
theme_set(theme_gray(base_family='AppleGothic'))

unemp <- read_excel("실업률.xlsx") %>% 
  fill(시점) %>% 
  mutate(시점 = parse_integer(시점))

unemp %>% 
  ggplot(aes(x = 시점, y = 데이터, color = 시도별)) +
  geom_line() +
  geom_point(size = 1)

unemp2 <- read_excel("unemp2.xlsx")

unemp %>% 
  filter(시점 >= 2018) %>% 
  group_by(시도별) %>% 
  summarize(실업률 = mean(데이터)) %>% 
  arrange(-실업률)

unemp %>% 
  filter(시점 >= 2018) %>% 
  ggplot(aes(x = 시점, y = 데이터, color = 시도별)) +
  geom_point(size = 1) + 
  geom_line(data = unemp %>% filter(시도별 %in% c("부산광역시", "울산광역시", "경상남도") & 시점 >=2018),
            aes(x = 시점, y = 데이터, color = 시도별)) +
  geom_text(data = unemp %>% filter(시도별 %in% c("부산광역시", "울산광역시", "경상남도") & 시점 >=2018), aes(label = 데이터),
            color = 'black') +
  labs(title = "시도별 청년실업률(2018~2022)", subtitle = "동남권의 청년실업률 추이",
       caption = "단위:%, 출처: 경제활동인구조사") 

table(unemp$시도별)
