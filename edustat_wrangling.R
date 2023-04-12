library(tidyverse)
library(readxl)
library(stargazer)

edustat <- read_excel('datasets/edustat_부울경.xlsx')

stargazer(edustat2 %>% select(year, prop_women_employ), type = 'html', out='out.html')

edustat2 <- edustat %>% 
  select(year, 
         univtype = 학제, 
         region = 시도, 
         category1 = 대계열,
         major = 학과명,
         prop_women_employ = 취업자중여자)


?stargazer
edustat2
summary(edustat2)

industry <- read_excel("datasets/total_industry.xlsx")

industry <-  industry %>% 
  mutate(men_ratio=남/소계,
         women_ratio_high=`고졸(여)` / 고졸,
         women_ratio_tech=`전문학사(여)` / 전문학사,
         women_ratio_ba=`학사(여)` / 학사,
         women_ratio_ma=`석사(여)` / 석사,
         women_ratio_phd=`박사(여)` / 박사,
         women_ratio_sci=`자연계(여)` / 자연계,
         women_ratio_eng=`공학계(여)` / 공학계,
         women_ratio_non_scieng=`비이공계(여)` / 비이공계) %>% 
  select(industry = `산업별(1)`,
         year = 시점,
         region = 지역,
         -`...1`,
         women_ratio_high,
         women_ratio_tech,
         women_ratio_ba,
         women_ratio_ma,
         women_ratio_phd,
         women_ratio_sci,
         women_ratio_eng,
         women_ratio_non_scieng)
