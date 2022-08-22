library(tidyverse)
library(readxl)
library(extrafont)
font_import()
theme_set(theme_gray(base_family='AppleGothic'))

df <- read_excel('population.xlsx') %>% 
  pivot_longer(cols = `15~19세`:`30~34세`, names_to = "ageg")

library(plotly)

ggplot(df %>% filter(행정기관 %in% c("서울특별시", "경기도", "경상남도", "전라남도",
                                          "경상북도", "부산광역시", "울산광역시", 
                                 "대구광역시", "전라북도")), aes(x = 연도, y = 청년인구)) +
  geom_line(aes(color = 성별)) +
  facet_wrap(~행정기관, scales = "free_y") +
  labs(title = "청년인구의 변동(2008~2021)", caption = "연앙인구통계")

ggplot(df %>% filter(str_ends(행정기관, '시') & ageg != "15~19세"), aes(x = 연도, y = value)) +
  geom_line(aes(color = ageg)) +
  facet_wrap(~행정기관 + 성별, scales = "free_y", ncol = 3)

ggplot(df %>% filter(str_ends(행정기관, '도') & ageg != "15~19세"), aes(x = 연도, y = value)) +
  geom_line(aes(color = ageg)) +
  facet_wrap(~행정기관 + 성별, scales = "free_y", ncol = 3)

ggplot(df %>% filter(행정기관 %in% c("서울특별시", "세종특별자치시", "경상남도", "부산광역시", "울산광역시", "경기도") & ageg != "15~19세"), aes(x = 연도, y = value)) +
  geom_line(aes(color = ageg)) +
  facet_wrap(~행정기관 + 성별, scales = "free_y", ncol = 3) + 
  labs(title = "성별 / 연령집단 별 청년인구 변동 (2008~2021)", caption = "출처: 연앙인구통계")
