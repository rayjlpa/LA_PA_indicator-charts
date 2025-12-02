##### SELECT A LOCAL AUTHORITY DATASET -----------------------------------------

# Match the Health Board to the LA
names <- HB_LA %>%
  filter(LocalAuthority==la_name)
hb_name <- names$HealthBoard[1]

# Create data table for the LA
la_profile <- all_results %>%
  filter(str_detect(dataset, "health") & area == hb_name |
           str_detect(dataset, "house") & area == la_name) %>%
  arrange(order) %>%
  mutate(
    indicator_pcent = indicator * 100,
    lowerci_pcent = lowerci * 100,
    upperci_pcent = upperci * 100,
    min_pcent = scotland_min * 100,
    max_pcent = scotland_max * 100,
    q25_pcent = scotland_q25 * 100,
    q75_pcent = scotland_q75 * 100,
    avg_pcent = scotland_avg * 100
  ) %>%
  left_join(colour_ref, by = c("subsystem" = "system")
  ) %>%
  rename(colour1 = colour
  ) %>%
  left_join(colour_ref, by = c("subsystem2" = "system")
  ) %>%
  rename(colour2 = colour
  ) %>%
  mutate(colour3 = case_when(is.na(colour2) ~ colour1,
                             !is.na(colour2) ~ NA_character_),
         colour2 = case_when(!is.na(colour3) ~ NA_character_,
                             is.na(colour3) ~ colour2),
         colour1 = case_when(!is.na(colour3) ~ NA_character_,
                             is.na(colour3) ~ colour1)
  ) %>%
  mutate(alpha = case_when(!is.na(colour2) ~ 1,
                           is.na(colour2)~0),
         border = case_when(!is.na(colour2) ~ "black",
                            is.na(colour2)~ NA_character_)
  ) %>%
  mutate(Freq2 = case_when(Freq>0 & Freq<100 ~ paste0(round(Freq),"*"),
                           Freq==0 ~ paste0(round(Freq),"**"),
                          TRUE ~ as.character(round(Freq))
  )) %>%
  mutate(
      title_ordered = reorder(indicatortitle, -order)   
    ) %>%
    arrange(title_ordered) %>%
    mutate(
      y_numeric = row_number()              
    )

# change the significance level on the three very low indicators so they appear
# red when higher, green when lower
la_profile <- la_profile %>%
              mutate(sig_level = case_when(
                                (order>=7 & order <=9) & sig_level=="Above average" ~ "Below average",
                                (order>=7 & order <=9) & sig_level=="Below average" ~ "Average average",
                                TRUE ~ sig_level))
  