##### SEDENTARY TIME INDICATOR PREPARATION -------------------------------------

health <- health %>%
  mutate(HBCode = as_factor(HBCode))
health5_15 <- health5_15 %>%
  mutate(HBCode = as_factor(HBCode))  

# adults
sed_data <- health %>%
  filter(!is.na(wksedhe18),   
         !is.na(HBCode),       
         !is.na(int16171819wt),
         wksedhe18 >= 0) %>%   
  select(HBCode, wksedhe18, int16171819wt)  

svy_design <- svydesign(ids = ~1, weights = ~int16171819wt, data = sed_data)

scotland_avg <- sed_data %>%
  summarise(scotland_avg = wtd.quantile(wksedhe18,
                                        weights = int16171819wt, 
                                        probs = 0.5))
medwt <- sed_data %>%
  group_by(HBCode) %>%
  summarise(weighted_median = wtd.quantile(wksedhe18,
                                           weights = int16171819wt, 
                                           probs = 0.5),
            weighted_25 = wtd.quantile(wksedhe18,
                                       weights = int16171819wt, 
                                       probs = 0.25),
            weighted_75 = wtd.quantile(wksedhe18,
                                       weights = int16171819wt, 
                                       probs = 0.75),
            weighted_05 = wtd.quantile(wksedhe18,
                                       weights = int16171819wt, 
                                       probs = 0.05),
            weighted_95 = wtd.quantile(wksedhe18,
                                       weights = int16171819wt, 
                                       probs = 0.95)
            ) %>%
  mutate(scotland_med = scotland_avg$scotland_avg[1]) %>%
  mutate(indicatortitle="21. Daily weekday leisure sedentary time for\nadults (16+)") %>%
  mutate(subsystem = "Overarching") %>%
  mutate(order=1)

  weightedn <- svytable(~HBCode, svy_design, na.rm=TRUE)
  weightedn <- as.data.frame(weightedn)
  medwt <- merge(medwt, weightedn, by = "HBCode")


# children
sed_data <- health5_15 %>%
  filter(!is.na(wksedhec18),   
         !is.na(HBCode),       
         !is.na(cint16171819wt),
         wksedhec18 >= 0) %>%   
  select(HBCode, wksedhec18, cint16171819wt)  

svy_design <- svydesign(ids = ~1, weights = ~cint16171819wt, data = sed_data)

scotland_avg <- sed_data %>%
  summarise(scotland_avg = wtd.quantile(wksedhec18,
                                        weights = cint16171819wt, 
                                        probs = 0.5))
medwtc <- sed_data %>%
  group_by(HBCode) %>%
  summarise(weighted_median = wtd.quantile(wksedhec18,
                                           weights = cint16171819wt, 
                                           probs = 0.5),
            weighted_25 = wtd.quantile(wksedhec18,
                                       weights = cint16171819wt, 
                                       probs = 0.25),
            weighted_75 = wtd.quantile(wksedhec18,
                                       weights = cint16171819wt, 
                                       probs = 0.75),
            weighted_05 = wtd.quantile(wksedhec18,
                                       weights = cint16171819wt, 
                                       probs = 0.05),
            weighted_95 = wtd.quantile(wksedhec18,
                                       weights = cint16171819wt, 
                                       probs = 0.95)
  ) %>%
  mutate(scotland_med = scotland_avg$scotland_avg[1]) %>%
  mutate(indicatortitle="22. Daily weekday leisure sedentary time for\nchildren (5-15)") %>%
  mutate(subsystem = "Overarching") %>%
  mutate(order=2)

    weightedn <- svytable(~HBCode, svy_design, na.rm=TRUE)
    weightedn <- as.data.frame(weightedn)
    medwtc <- merge(medwtc, weightedn, by = "HBCode")

# combine
sed_data <- rbind(medwt, medwtc)

sed_data <- sed_data %>%
            mutate(Freq2 = round(Freq,0))

rm(scotland_avg, medwt, medwtc, svy_design, weightedn)


