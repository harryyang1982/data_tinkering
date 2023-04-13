library(tidyverse)
library(readxl)

masan_export <- read_excel('masan_export_special.xlsx', sheet = 1)
masan_labor <- read_excel('masan_export_special.xlsx', sheet = 2)

masan_export_tidy <- masan_export %>% 
  pivot_longer(cols = `1971`:`1995`, names_to = '연도', values_to = '수출액')

masan_labor_tidy <- masan_labor %>% 
  pivot_longer(cols = `1971`:`1995`, names_to = '연도', values_to = '인원') 

library(extrafont)
theme_set(theme_gray(base_family='AppleGothic'))

ggplot(masan_export_tidy, aes(x = 연도, y = 수출액)) +
  geom_col(aes(fill = 업종별), position = position_dodge2(width = 2)) +
  labs(title = "마산수출자유지역 수출액", caption = "단위: 천$")
  
ggplot(masan_labor_tidy %>% filter(성별 != "계"), aes(x = 연도, y = 인원)) +
  geom_col(aes(fill = 성별), position = position_dodge2(width = 2)) +
  labs(title = "마산수출자유지역 고용 인원", caption = "단위: 명")
