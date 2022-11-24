library(tidyverse)
library(modelr)
library(plm)
library(readxl)
library(extrafont)
theme_set(theme_gray(base_family='AppleGothic'))

edustat <- read_excel("edustat_부울경.xlsx")
files_list <- list.files(path = ".", pattern = "*.xlsx")[23:26]
df_list <- map(files_list, read_excel, skip = 1)
industry <- bind_rows(df_list) %>% 
  fill(시점) %>% 
  mutate(지역 = c(rep("부산", 316), rep("경남", 320), rep("서울", 302), rep("울산", 294))) %>% 
  mutate_at(3:44, as.numeric)

industry %>% 
  rename(산업별 = `산업별(1)`) %>% 
  mutate(남성비율=남/`소계...3`,
         학사여성비율=`학사(여)` / 학사,
         석사여성비율=`석사(여)` / 석사,
         박사여성비율=`박사(여)` / 박사,
         자연계여성비율=`자연계(여)` / 자연계,
         공학계여성비율=`공학계(여)` / 공학계,
         비이공계여성비율=`비이공계(여)` / 비이공계) %>% 
  filter(산업별 %in% c("기계", "디스플레이", "반도체", "섬유", "자동차", "전자", "철강", "화학", "바이오ㆍ헬스", "조선", "소프트웨어", "IT 비즈니스")) -> industry_subset

industry_subset

# conduct ols

ols <- lm(학사여성비율 ~ 지역 + 산업별, data = industry_subset)

# conduct fixed effects

fixed <- plm(학사여성비율 ~ 지역 + 산업별, index = "시점", model = "within", data = industry_subset)
summary(fixed)
fixef(fixed)

pFtest(fixed, ols)
fixed2 <- plm(학사여성비율 ~ 지역 * 산업별, index = "시점", model = "within", data = industry_subset)
summary(fixed2)


# random effects

#random <- plm(학사여성비율 ~ 지역 + 산업별, index = "시점", model = "random", data = industry_subset)


