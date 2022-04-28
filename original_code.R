# Loading Packages ----
library(tidyverse)

# Getting citation for tidyverse and Rstudio ----
citation()
citation("tidyverse")
RStudio.Version()

if (!dir.exists("figs")) dir.create("figs")

# Data for Graph with width of age range ----
ages <- tibble(
  age_group = c("5-11", "12-17", "18-24", 
                "25-39", "40-49", "50-64", "65-74", "75+"),
  age_start = c(5, 12, 18, 25, 40, 50, 65, 75),
  age_end = c(12, 18, 25, 40, 50, 65, 75, 89)
) %>% 
  mutate(age_group = as_factor(age_group))

# Vaccination Raw Data ----
vax_data <- 
  read_csv("data/COVID-19_Vaccination_Demographics_in_the_United_States_National.csv") %>% 
  filter(str_starts(Demographic_category, "Ages_")) %>% 
  rename(age_group = Demographic_category) %>% 
  mutate(
    Date = as.Date(Date, format = "%m/%d/%Y"),
    age_group=str_remove(age_group, "Ages_"),
    age_group=str_remove(age_group, "_yrs"),
    age_group=str_remove(age_group, "yrs"),
  ) %>% 
  mutate(age_group = factor(age_group, levels = ages$age_group)) %>%
  inner_join(ages) %>%
rename(
    per_vax = Series_Complete_Pop_pct_agegroup, 
    date = Date
  ) %>% 
  select(date, starts_with("age"), per_vax) %>%
  print()

# Basic Column Graph ----
vax_data %>% 
  filter(date == max(date)) %>% 
  ggplot()+
  geom_col(mapping = aes(x=age_group, y=per_vax), 
           fill = "darkseagreen") +
  labs(y="% Fully Vaccinated", x="Age", title = "Vaccination Status for the US as of March 27, 2022")+
  theme_gray(base_size = 15)
ggsave("figs/vax data.png", height = 6, width = 10, units="in", dpi=600)

# Column Graph, width of age ranges ----
vax_data %>% 
  filter(date == max(date)) %>% 
  ggplot()+
  geom_rect(aes(xmin = age_start, xmax = age_end, ymin = 0, ymax = per_vax), 
            fill = "darkseagreen", color = "azure") +
  geom_rect(aes(xmin = age_start, xmax = age_end, ymin = per_vax, ymax = 100), 
            fill = "azure3", color = "azure") +
  labs(y="% Fully Vaccinated", x="Age", title = "Vaccination Status for the US as of March 27, 2022")+
  theme_gray(base_size = 15)
ggsave("figs/vax data.png", height = 6, width = 10, units="in", dpi=600)

# Line Graph (Time-wise visual) ----
vax_data %>% 
  ggplot(aes(x = date, y = per_vax, color = age_group)) +
  geom_line() +
  labs(y="% Fully Vaccinated", x="Date", title = "Vaccination Status for the US as of March 27, 2022")+
  theme_gray(base_size = 15)
ggsave("figs/line vax data.png", height = 6, width = 10, units="in", dpi=600)


# COVID Cases Raw Data ----
library(readxl)
cases_by_age <- 
  read_excel("data/Public-Dataset-Age.XLSX") %>% 
  select(-c(AR_TOTALPERCENT, AR_NEWCASES, 
            AR_NEWPERCENT, AR_TOTALDEATHS, AR_NEWDEATHS)) %>% 
  rename(date = DATE, age_range=AGE_RANGE, total_cases=AR_TOTALCASES) %>% 
  mutate(date = as.Date(date)) %>% 
  print()

# Column Graph (Comparing 2 different dates) ----
cases_by_age %>%
  filter(date == as.Date("2022-03-26") | date == as.Date("2021-12-01")) %>% 
  ggplot()+
  geom_col(mapping = aes(x=age_range, y=total_cases, fill=as.factor(date)),
           position="dodge2") +
  scale_fill_manual(values=c("darkseagreen", "azure3")) +
  labs(y="# of Cases", x="Age Group", title="COVID-19 Cases Among  Age Groups") +
  theme_gray(base_size = 15)

# Multiple Graphs (Comparing 2 different dates) ----
cases_by_age %>% 
  filter(date == as.Date("2022-03-26") | date == as.Date("2021-12-01")) %>% 
  ggplot() +
  geom_col(mapping = aes(x = date, y = total_cases),
           fill = "darkseagreen") +
  facet_wrap(~ age_range)+
  labs(y="Total Cases", x="Date", title = "COVID Cases in the US (December 1, 
       2021 and March 26, 2022)")+
  theme_gray(base_size = 15)+
  theme(axis.text.x=element_text(size=rel(.8)))
ggsave("figs/case data.png", height = 8, width = 12, units="in", dpi=600)

# New Multiple Graph (different dates being compared) ----
cases_by_age %>% 
  filter(date == as.Date("2020-12-01") | date == as.Date("2021-12-01")) %>% 
  ggplot() +
  geom_col(mapping = aes(x = date, y = total_cases),
           fill = "darkseagreen") +
  facet_wrap(~ age_range)+
  labs(y="Total Cases", x="Date", title = "COVID Cases in the US (December 1, 
       2020 and December 1, 2021)")+
  theme_gray(base_size = 15)+
  theme(axis.text.x=element_text(size=rel(.8)))
ggsave("figs/case data.png", height = 8, width = 12, units="in", dpi=600)


# Statistical analysis ----
cases_by_age %>% 
  filter(date == as.Date("2020-12-01") | date == as.Date("2021-12-01")) %>% 
  mutate(date = as.factor(lubridate::year(date))) %>% 
  pivot_wider(names_from = "date", values_from = "total_cases") %>% 
  select(-age_range) %>% 
  as.matrix() %>% 
  chisq.test()
