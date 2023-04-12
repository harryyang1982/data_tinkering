library(tidyverse)

# file_list <- list.files(path = "edu_datasets", pattern = '*.xlsx')

# df <- str_c("edu_datasets", "/", file_list) %>% 
#   map_df(read_excel, skip = 13)

library(writexl)
writexl::write_xlsx(df, "edu_datasets/edu_enter.xlsx")
write_rds(df, "edu_datasets/edu_enter.RDS")

edu_enter <- df %>% filter(시도 %in% c("서울", "부산", "경남", "울산")) %>% 
  select(-starts_with("졸업자")) %>% 
  select(-starts_with("정원")) %>% 
  select(-starts_with("지원자")) %>% 
  select(-starts_with("휴학생")) %>% 
  select(-starts_with("외국인")) %>% 
  select(-starts_with("시간강사")) %>% 
  select(-starts_with("유예생")) %>% 
  select(-contains("박사")) %>% 
  select(-starts_with("전임교원")) %>% 
  select(-starts_with("비전임교원")) %>% 
  select(-starts_with("직원")) %>% 
  select(-학교상태, -학교수) %>% 
  select(-starts_with("모집인원")) %>% 
  select(-contains("석사")) %>% 
  select(-홈페이지, -팩스번호, -우편번호, -전화번호) %>% 
  select(-27:-29)

write_xlsx(edu_enter, "edu_enter_부울경.xlsx")
write_rds(edu_enter, "edu_enter_부울경.rds")
