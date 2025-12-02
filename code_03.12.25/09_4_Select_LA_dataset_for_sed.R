#####   Select LA dataset for sed

la_profile_sed <- sed_data %>%
  filter(HBCode == hb_name) %>%
  left_join(colour_ref, by = c("subsystem" = "system")
  ) %>%
  rename(colour3 = colour
  ) %>%
  mutate(alpha = case_when(!is.na(colour3) ~ 1,
                           is.na(colour3)~0),
         border = case_when(!is.na(colour3) ~ "black",
                            is.na(colour3)~ NA_character_)
  ) %>%
  mutate(Freq2 = case_when(Freq<100 ~ paste0(round(Freq),"*"),
                           TRUE ~ as.character(round(Freq)))
  ) %>%
  mutate(
    title_ordered = reorder(indicatortitle, -order)   
  ) %>%
  arrange(title_ordered) %>%
  mutate(
    y_numeric = row_number()              
  )


