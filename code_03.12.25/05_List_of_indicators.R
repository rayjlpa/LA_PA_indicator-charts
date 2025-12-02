##### CREATE LIST OF INDICATORS ------------------------------------------------

## each indicator needs
# name: name of indicator
# order: order it will appear on chart
# dataset: dataset to use
# raw_var: name of key variable
# weight: weighting variable
# strata: stratification variable
# area: Health Board or LA (depends on dataset)
# to_binary: the code to convert raw_var to a binary indicator
# subsystem: the primary subsystem with the Scot Gov framework
# subsystem2: secondary subsystem, if applicable

variables_list <- list(
  list(
    name = "1. Percentage of adults (16+) meeting the\nMVPA guideline",
    order = 1,
    dataset = "health",
    raw_var = "adt10gpTW",           
    weight = "int16171819wt",        
    strata = "Strata",               
    area = "HBCode",                 
    to_binary = function(x) dplyr::case_when(x == 1 ~ 1, 
                                             x %in% 2:4 ~ 0, 
                                             x < 0 ~ NA_real_), 
    subsystem = "Overarching"
  ),
  list(
    name = "2. Percentage of older adults (65+)\nmeeting the MVPA guideline",
    order = 2,
    dataset = "health65",
    raw_var = "adt10gpTW",           
    weight = "int16171819wt",        
    strata = "Strata",               
    area = "HBCode",                 
    to_binary = function(x) dplyr::case_when(x == 1 ~ 1, 
                                             x %in% 2:4 ~ 0, 
                                             x < 0 ~ NA_real_), 
    subsystem = "Overarching"
  ), 
  list(
    name = "3. Percentage of adults (16+) meeting the\nMVPA guideline in the lowest SIMD quintile",
    order =3,
    dataset = "healthSIMD",
    raw_var = "adt10gpTW",           
    weight = "int16171819wt",        
    strata = "Strata",               
    area = "HBCode",                 
    to_binary = function(x) dplyr::case_when(x == 1 ~ 1, 
                                             x %in% 2:4 ~ 0, 
                                             x < 0 ~ NA_real_), 
    subsystem = "Overarching"
  ),
  list(
    name = "4. Percentage of children (5-15) meeting\nthe MVPA guidelines",
    order = 4,
    dataset = "health5_15",
    raw_var = "c00sum7S",
    weight = "cint16171819wt",
    strata = "Strata",
    area = "HBCode",
    to_binary = function(x) dplyr::case_when(x == 1 ~ 1, 
                                             x %in% 2:3 ~ 0, 
                                             x < 0 ~ NA_real_),
    subsystem = "Overarching"
  ), 
  list(
    name = "5. Percentage of adults (16+) meeting\nthe muscle strengthening guideline",
    order = 5,
    dataset = "health",
    raw_var = "MusRec",           
    weight = "int16171819wt",        
    strata = "Strata",               
    area = "HBCode",                 
    to_binary = function(x) dplyr::case_when(x == 1 ~ 1, 
                                             x ==0 ~ 0, 
                                             x < 0 ~ NA_real_), 
    subsystem = "Overarching"
  ),  
  list(
    name = "6. Percentage of older adults (65+) meeting\nthe muscle strengthening guideline",
    order = 6,
    dataset = "health65",
    raw_var = "MusRec",           
    weight = "int16171819wt",        
    strata = "Strata",               
    area = "HBCode",                 
    to_binary = function(x) dplyr::case_when(x == 1 ~ 1, 
                                             x ==0 ~ 0, 
                                             x < 0 ~ NA_real_), 
    subsystem = "Overarching"
  ),  
  list(
    name = "7. Percentage of adults (16+) with\n'very low' activity levels",
    order = 7,
    dataset = "health",
    raw_var = "adt10gpTW",           
    weight = "int16171819wt",        
    strata = "Strata",               
    area = "HBCode",                 
    to_binary = function(x) dplyr::case_when(x == 4 ~ 1, 
                                             x %in% 1:3 ~ 0, x < 0 ~ NA_real_), 
    subsystem = "Overarching"
  ),  
  list(
    name = "8. Percentage of older adults (65+)\nwith 'very low' activity levels",
    order = 8,
    dataset = "health65",
    raw_var = "adt10gpTW",           
    weight = "int16171819wt",        
    strata = "Strata",               
    area = "HBCode",                 
    to_binary = function(x) dplyr::case_when(x == 4 ~ 1, 
                                             x %in% 1:3 ~ 0, 
                                             x < 0 ~ NA_real_), 
    subsystem = "Overarching"
  ),
  list(
    name = "9. Percentage of children (5-15) with\n'very low' activity levels",
    order = 9,
    dataset = "health5_15",
    raw_var = "c00sum7S",
    weight = "cint16171819wt",
    strata = "Strata",
    area = "HBCode",
    to_binary = function(x) dplyr::case_when(x == 3 ~ 1, 
                                             x %in% 1:2 ~ 0, 
                                             x < 0 ~ NA_real_),
    subsystem = "Overarching"
  ), 
  list(
    name = "10. Percentage of adults (16+)\nparticipating in recreational walking",
    order = 10,
    dataset = "house",
    raw_var = "sprt3aa",
    weight = "IND_WT",
    strata = "council",
    area = "council",
    to_binary = function(x) dplyr::case_when(x == 1 ~ 1, 
                                             x ==0 ~ 0, 
                                             is.na(x) ~ NA_real_),
    subsystem = "Sport and Active Recreation"
  ),
  list(
    name = "11. Percentage of older adults (60+)\nparticipating in recreational walking",
    order = 11,
    dataset = "house60",
    raw_var = "sprt3aa",
    weight = "IND_WT",
    strata = "council",
    area = "council",
    to_binary = function(x) dplyr::case_when(x == 1 ~ 1, 
                                             x ==0 ~ 0, 
                                             is.na(x) ~ NA_real_),
    subsystem = "Sport and Active Recreation"
  ),  
  list(
    name = "12. Percentage of adults (16+)\nparticipating in sport",
    order = 12,
    dataset = "house",
    raw_var = "anysportnowalk",
    weight = "IND_WT",
    strata = "council",
    area = "council",
    to_binary = function(x) dplyr::case_when(x == 1 ~ 1, 
                                             x == 0 ~ 0, 
                                             is.na(x) ~ NA_real_),
    subsystem = "Sport and Active Recreation"
  ),  
  list(
    name = "13. Percentage of older adults (60+)\nparticipating in sport",
    order = 13,
    dataset = "house60",
    raw_var = "anysportnowalk",
    weight = "IND_WT",
    strata = "council",
    area = "council",
    to_binary = function(x) dplyr::case_when(x == 1 ~ 1, 
                                             x == 0 ~ 0, 
                                             is.na(x) ~ NA_real_),
    subsystem = "Sport and Active Recreation"
  ),  
  list(
    name = "14. Percentage of children (5-15)\nparticipating in sport",
    order = 14,
    dataset = "health5_15",
    raw_var = "spt1ch",
    weight = "cint16171819wt",
    strata = "Strata",
    area = "HBCode",
    to_binary = function(x) dplyr::case_when(x == 1 ~ 1, 
                                             x %in% 2 ~ 0, 
                                             x < 0 ~ NA_real_),
    subsystem = "Sport and Active Recreation"
  ),
  list(
    name = "15. Percentage of children (2-15)\nengaged in active play",
    order = 15,
    dataset = "health",
    raw_var = "ch30plyg",
    weight = "cint16171819wt",
    strata = "Strata",
    area = "HBCode",
    to_binary = function(x) dplyr::case_when(x == 5 ~ 1, 
                                             x %in% 0:3 ~ 0, 
                                             x < 0 ~ NA_real_),
    subsystem = "Active Places of Learning",
    subsystem2 = "Sport and Active Recreation"
  ),
  list(
    name = "16. Percentage of adults (16+) usually\nwalking or cycling to work",
    order = 16,
    dataset = "house",
    raw_var = "rd3",
    weight = "IND_WT",
    strata = "council",
    area = "council",
    to_binary = function(x) dplyr::case_when(x == 1 | x == 5 ~ 1, 
                                             x %in% 2:4 | x %in% 6:16 ~ 0, 
                                             is.na(x) ~ NA_real_),
    subsystem = "Active Travel",
    subsystem2 = "Active Workplace"
  ),  
  list(
    name = "17. Percentage of children (2-15) that use\nactive travel to get to school",
    order = 17,
    dataset = "house",
    raw_var = "he10n",
    weight = "IND_WT",
    strata = "council",
    area = "council",
    to_binary = function(x) dplyr::case_when(x == 1 | x == 5 ~ 1, 
                                             x %in% 2:4 | x %in% 6:16 ~ 0, 
                                             is.na(x) ~ NA_real_),
    subsystem = "Active Travel",
    subsystem2 = "Active Places of Learning"
  ),
  list(
    name = "18. Percentage of adults (16+) that visit\nthe outdoors at least once a week",
    order = 18,
    dataset = "house",
    raw_var = "outdoor",
    weight = "IND_WT",
    strata = "council",
    area = "council",
    to_binary = function(x) dplyr::case_when(x %in% 1:4 ~ 1, 
                                             x %in% 5:8 ~ 0, 
                                             is.na(x) ~ NA_real_),
    subsystem = "Active Places and Spaces",
    subsystem2 = "Sport and Active Recreation"
  ),
  list(
    name = "19. Percentage of adults (16+) that are satisfied\nwith their local sports and leisure facilities",
    order = 19,
    dataset = "house",
    raw_var = "serv3a",
    weight = "IND_WT",
    strata = "council",
    area = "council",
    to_binary = function(x) dplyr::case_when(x %in% 1:2 ~ 1, 
                                             x %in% 3:6 ~ 0, 
                                             is.na(x) ~ NA_real_),
    subsystem = "Active Places and Spaces",
    subsystem2 = "Sport and Active Recreation"
  ),
  list(
    name = "20. Percentage of adults (16+) that are satisfied\nwith their local parks and open spaces",
    order = 20,
    dataset = "house",
    raw_var = "serv3e",
    weight = "IND_WT",
    strata = "council",
    area = "council",
    to_binary = function(x) dplyr::case_when(x %in% 1:2 ~ 1, 
                                             x %in% 3:6 ~ 0, 
                                             is.na(x) ~ NA_real_),
    subsystem = "Active Places and Spaces",
    subsystem2 = "Sport and Active Recreation"
  )
)