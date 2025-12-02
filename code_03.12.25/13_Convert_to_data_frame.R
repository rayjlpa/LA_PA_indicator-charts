##### CONVERT TO DATA FRAME AND CHECK LA NAMES----------------------------------

data <- matrix(c(
  "Ayrshire and Arran",         "East Ayrshire", 
  "Ayrshire and Arran",         "North Ayrshire", 
  "Ayrshire and Arran",         "South Ayrshire", 
  "Borders",                    "Scottish Borders",
  "Dumfries and Galloway",      "Dumfries and Galloway",
  "Fife",                       "Fife",
  "Forth Valley",               "Clackmannanshire",
  "Forth Valley",               "Stirling",
  "Forth Valley",               "Falkirk",
  "Grampian",                   "Aberdeenshire",
  "Grampian",                   "Aberdeen City",
  "Grampian",                   "Moray",
  "Greater Glasgow and Clyde",  "Glasgow City",
  "Greater Glasgow and Clyde",  "East Dunbartonshire",
  "Greater Glasgow and Clyde",  "East Renfrewshire",
  "Greater Glasgow and Clyde",  "Inverclyde",
  "Greater Glasgow and Clyde",  "Renfrewshire",
  "Greater Glasgow and Clyde",  "West Dunbartonshire",
  "Highland",                   "Highland",
  "Highland",                   "Argyll and Bute",
  "Lanarkshire",                "North Lanarkshire",
  "Lanarkshire",                "South Lanarkshire",
  "Lothian",                    "Edinburgh City",
  "Lothian",                    "East Lothian",
  "Lothian",                    "Midlothian",
  "Lothian",                    "West Lothian",
  "Orkney",                     "Orkney",
  "Shetland",                   "Shetland",
  "Tayside",                    "Angus",
  "Tayside",                    "Dundee City",
  "Tayside",                    "Perth and Kinross",
  "Western Isles",              "Eilean Siar"
),
ncol=2, byrow=TRUE)

HB_LA <- data.frame(HealthBoard = data[,1], LocalAuthority = data[,2])
rm(data)

### Check and correct council names in summary_list 
council_in_mapping <- unique(HB_LA$LocalAuthority)

for (i in seq_along(summary_list)) {
  area_unique <- unique(summary_list[[i]]$area)
  if (length(area_unique) > 14) {
    not_in_mapping <- setdiff(area_unique, council_in_mapping)
    if (length(not_in_mapping) > 0) {
      cat(sprintf("summary_list[[%d]]: These names are not in HB_LA$LocalAuthority:\n", i))
      print(not_in_mapping)
    }
  }
}

replace_list <- c(
  "West Dumbartonshire" = "West Dunbartonshire",
  "East Dumbartonshire" = "East Dunbartonshire"
)

health_board_names <- unique(HB_LA$HealthBoard)

for (i in seq_along(summary_list)) {
  if (!all(summary_list[[i]]$area %in% health_board_names)) {
    summary_list[[i]]$area <- plyr::revalue(summary_list[[i]]$area, replace_list, warn_missing = FALSE)
  }
}

all_results <- dplyr::bind_rows(summary_list, .id = "indicatortitle")


rm(health_2015, health_2019, health5_15_2015, health5_15_2019,
   house_2015, house_2019, area_unique, 
   council_in_mapping, health_board_names, i, not_in_mapping,
   replace_list)