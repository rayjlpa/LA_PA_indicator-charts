#### CREATE LA - HB DATAFRAME --------------------------------------------------


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
