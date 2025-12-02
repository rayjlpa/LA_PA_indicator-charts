#### DATASET BEHIND THE DEFINITIONS TABLE --------------------------------------

variables_list <- list(
  list(
    name = paste0("1. % adults (16+) meeting the MVPA guideline",
                  "\n2. % older adults (65+) meeting the MVPA guideline",
                  "\n3. % adults (16+) meeting the MVPA guideline",
                  " in the lowest SIMD quintile"),
    order = 1,
    definition = paste0("≥150 minutes of moderate intensity",
                        " activity or ≥75 minutes of vigorous intensity activity",
                        " or an equivelant combination of the two in the past",
                        " four weeks"),
    dataset = " SHeS\n 2016-19"
  ),
  list(
    name = "4. % children (5-15) meeting the MVPA guideline",
    order = 2,
    definition = paste0("An average of ≥60 minutes of at least",
                        " moderate intensity activity per day in the past 7 days"),
    dataset = " SHeS 2016\n & 2019"
  ), 
  list(
    name = paste0("5. % adults (16+) meeting the muscle strengthening guideline",
                  "\n6. % older adults (65+) meeting the muscle strengthening guideline"),
    order = 3,
    definition = paste0("≥2 sessions per week of muscle ",
                        "strengthening activities in the past 4 weeks"),
    dataset = " SHeS\n 2016-19"
  ),  
  list(
    name = paste0("7. % adults (16+) with 'very low' activity levels",
                  "\n8. % older adults (65+) with 'very low' activity levels"),
    order = 4,
    definition = paste0("≤30 minutes of moderate intensity activity ",
                        "or ≤15 minutes of vigorous intensity activity or an",
                        " equivalent combination of the two in the past 4 weeks"),
    dataset = " SHeS\n 2016-19"
  ),  
  list(
    name = "9. % children (5-15) with 'very low' activity levels",
    order = 5,
    definition = paste0("An average of ≤30 minutes of at least",
                        " moderate intensity activity per day in the past 7 days"),
    dataset = " SHeS 2016\n & 2019"
  ), 
  list(
    name = paste0("10. % adults (16+) participating in recreational walking",
                  "\n11. % older adults (60+) participating in recreational walking"),
    order = 6,
    definition = paste0("Participation in recreational walking",
                        " for ≥30 minutes in the past four weeks"),
    dataset = " SHS 2019"
  ),
  list(
    name = paste0("12. % adults (16+) participating in sport",
                  "\n13. % older adults (60+) participating in sport"),
    order = 7,
    definition = paste0("Participation in any sporting activity",
                        " for ≥30 minutes in the past four weeks"),
    dataset = " SHS 2019"
  ),  
  list(
    name = "14. % children (5-15) participating in sport",
    order = 8,
    definition = paste0("Participation in any sport",
                        " or recreation activities in the past 7 days"),
    dataset = " SHeS\n 2016-19"
  ),
  list(
    name = "15. % children (2-15) engaged in active play",
    order = 9,
    definition = paste0("≥30 mins of",
                        " active play on at least 1 day in the last 7 days"),
    dataset = " SHeS 2016\n & 2019"
  ),
  list(
    name = "16. % adults (16+) usually walking or cycling to work",
    order = 11,
    definition = paste0("Usual",
                        " method of travel to work is by walking or cycling"),
    dataset = " SHS 2019"
  ),  
  list(
    name = "17. % children (2-15) that use active travel to get to school",
    order = 12,
    definition = paste0("Usual method of",
                        " travel to school is by walking or cycling"),
    dataset = " SHS 2019"
  ),
  list(
    name = "18. % adults (16+) that visit the outdoors at least once a week",
    order = 13,
    definition = paste0("Visit the outdoors",
                        " for leisure or recreation at least once a week in the last 12 months"),
    dataset = " SHS 2019"
  ),
  list(
    name = "19. % adults (16+) that are satisfied with their local sports and leisure facilities",
    order = 14,
    definition = paste0("Very or",
                        " fairly satisfied with local sports and leisure facilities"),
    dataset = " SHS 2019"
  ),
  list(
    name = "20. % adults (16+) that are satisfied with their local parks and open spaces",
    order = 15,
    definition = paste0("Very or",
                        " fairly satisfied with local parks and open spaces"),
    dataset = " SHS 2019"
  ),
  list(
    name = paste0("21. Daily weekday sedentary time for adults (16+)"),
    order = 16,
    definition = paste0("Median self-reported sitting time on weekdays (hours/day)"),
    dataset = " SHeS\n 2016-19"
  ),
  list(
    name = paste0("22. Daily weekday leisure sedentary time for children (5-15)"),
    order = 17,
    definition = paste0("Median self-reported sitting time on weekdays (hours/day)"),
    dataset = " SHeS\n 2018-19"
  )
)

indicator_defs <- do.call(rbind, lapply(variables_list, as.data.frame))
rownames(indicator_defs) <- NULL

indicator_defs <- indicator_defs %>%
  select(-order) %>%
  select(name, dataset, definition) %>%
  rename(Indicator = name,
         Dataset = dataset,
         Definition = definition)