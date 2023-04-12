library(tidyverse)
library(readxl)

# making edu_ent

edu_ent <- read_excel("edu_datasets/edu_enter_부울경.xlsx")
edu_ent_f <- edu_ent %>% 
  filter(연도 >= 2011 & 연도 <= 2020) %>% 
  select(-대학원구분, -학위과정)

# making edu_stat

edustat <- read_excel('edustat_부울경.xlsx')

edustat %>% 
  filter((str_detect(학과명, "해양") | str_detect(학과명, "조선") | str_detect(학과명, "선박")) & 대계열 == "공학계열") -> filtered_edu

edustat %>% 
  mutate(shipbuilding = case_when((str_detect(학과명, "해양") | str_detect(학과명, "조선") | str_detect(학과명, "선박")) & 대계열 == "공학계열" ~ 1, 
                                  TRUE ~ 0),
         eng = case_when(대계열 == "공학계열" ~ 1,
                         TRUE ~ 0)) %>% 
  select(-`...1`) -> edustat_2

edustat_3 <- edustat_2 %>% 
  select(-23:-40) %>% 
  select(-contains("외국인")) %>% 
  select(-32:-50) %>% 
  select(-32:-52) %>% 
  select(-조사기준일) %>% 
  select(-31) %>% 
  select(-contains("KEDI")) %>% 
  select(연도=year, everything()) %>% 
  select(-과정구분)


edustat_3 %>% left_join(edu_ent_f, by = c("연도", "학제", "학교명", "본분교", "시도", "설립", "대계열", "중계열", "소계열", "학과명", "학과코드")) -> joined

sum(is.na(joined$재학생_전체_계))

joined %>% 
  select(-시군구:-학과수_전체) -> joined2

write_rds(joined2, "joined_data.rds")
writexl::write_xlsx(joined2, "joined_data.xlsx")
