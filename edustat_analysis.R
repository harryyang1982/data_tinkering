library(tidyverse)
library(readxl)

edustat <- read_excel('edustat_부울경.xlsx')

edustat %>% 
  filter((str_detect(학과명, "해양") | str_detect(학과명, "조선") | str_detect(학과명, "선박")) & 대계열 == "공학계열") -> filtered_edu

edustat %>% 
  mutate(shipbuilding = case_when((str_detect(학과명, "해양") | str_detect(학과명, "조선") | str_detect(학과명, "선박")) & 대계열 == "공학계열" ~ 1, 
                                  TRUE ~ 0),
         eng = case_when(대계열 == "공학계열" ~ 1,
                         TRUE ~ 0),
         year = as.integer(str_sub(조사기준일, start=1L, end = 4L)),
         졸업자_여자_비중 = ) %>% 
  select(-`...1`) -> edustat_2

?anova
