##### IMPORT DATA --------------------------------------------------------------
# All data are available on the UK Data Archive

## ---- CHOOSE FILE PATHS BASED ON VERSION ------------------------------------
## Use the version switch defined in 01_Housekeeping.R to decide
## which SHeS/SHS files to read for the main spine charts.

if (spine_data_version == "current") {
  
  # SHeS 2016–2019 combined file (original version)
  shes_file <- paste0(
    dir, "\\data\\shes\\UKDA-8737-spss\\",
    "spss\\spss25\\shes16171819i_eul.sav"
  )
  
  # SHS 2019 file (original version)
  shs_file <- paste0(
    dir, "\\data\\shs\\UKDA-8775-spss\\spss",
    "\\spss25\\shs2019_social_public.sav"
  )
  
} else if (spine_data_version == "new") {
  
  # NEW: update these two paths to the new SHeS/SHS files when available
  shes_file <- paste0(
    dir, "\\data\\shes\\<NEW-SHeS-FOLDER>\\",
    "spss\\spss25\\<new_shes_file>.sav"
  )
  
  shs_file <- paste0(
    dir, "\\data\\shs\\<NEW-SHS-FOLDER>\\spss",
    "\\spss25\\<new_shs_file>.sav"
  )
  
} else {
  
  stop("Unknown spine_data_version: ", spine_data_version)
  
}

message("Reading SHeS from: ", shes_file)
message("Reading SHS from:  ", shs_file)


## ---- READ SCOTTISH HEALTH SURVEY (SHeS) -------------------------------------

# Note: the only change here is that we now use shes_file instead of
# a hard-coded path. Object names remain the same (health, health65, etc.).

health <- read_sav(shes_file) %>%
  select(
    adt10gpTW,
    c00sum7S,
    MusRec,
    spt1ch,
    ch30plyg,
    wksedhe18,
    wksedheC,
    wksedhec18,
    wksedhc,
    WkSedHc18,
    SIMD20_SGa,
    HBCode,
    age,
    SYear,
    Strata,
    int16171819wt,
    cint16171819wt
  )

health65 <- health %>%
  filter(age >= 65)

healthSIMD <- health %>%
  filter(SIMD20_SGa == 1)

health5_15 <- health %>%
  filter(age >= 5 & age <= 15)

health5_15 %>%
  count(c00sum7S, SYear)


## ---- READ SCOTTISH HOUSEHOLD SURVEY (SHS) -----------------------------------

# Again, the only change is that we use shs_file instead of
# a hard-coded path. Object names stay the same (house, house60, ...).

house <- read_sav(shs_file)

# Remove those without a valid random adult age
# (they did not complete the second half of the interview)
house <- house %>%
  filter(!is.na(randage))

# create an active travel variable – walking or cycling for transport
house <- house %>%
  mutate(
    re6 = replace(re6, is.na(re6), 0),         # not routed to the bike question
    re6 = replace(re6, re6 == -97, NA_real_),  # don't know
    re6 = replace(re6, re6 == -98, 0),         # none
    re8 = replace(re8, re8 == -97, NA_real_),  # don't know
    re8 = replace(re8, re8 == -98, 0)          # unable to walk
    # keep is.na(re8) as NA_real_ as it is unclear why they did not answer
  ) %>%
  mutate(
    atvar = case_when(
      re8 >= 1              ~ 1,
      re6 >= 1              ~ 1,
      re8 == 0 & re6 == 0   ~ 0,
      TRUE                  ~ NA_real_
    )
  )

house60 <- house %>%
  filter(randage >= 60)

house2_4 <- house %>%
  filter(randage >= 60)
