##### Import data for radar plot

# health survey 2016-2019
health_2019 <- read_sav(paste0(dir,"\\data\\shes\\UKDA-8737-spss\\",
                          "spss\\spss25\\shes16171819i_eul.sav"))

health5_15_2019 <- health_2019 %>%
  filter(age>=5 & age<=15)

# health survey 2012-2015
health_2015 <- read_sav(paste0(dir,"\\data\\shes\\UKDA-8100-spss\\",
                               "spss\\spss19\\shes12131415i_archive_v1.sav"))
                        
health_2015 <- health_2015 %>%
              rename(Strata = STRATA)

health5_15_2015 <- health_2015 %>%
  filter(age>=5 & age<=15)

# household survey 2019
house_2019 <- read_sav(paste0(dir,"\\data\\shs\\UKDA-8775-spss\\spss",
                         "\\spss25\\shs2019_social_public.sav"))

house_2019 <- house_2019 

# household survey 2015
house_2015 <- read_sav(paste0(dir,"\\data\\shs\\UKDA-8168-spss\\",
                              "spss\\spss28\\shs2015_social_public_updated.sav"))

house_2015 <- house_2015 %>%
    rename(council = la) 


