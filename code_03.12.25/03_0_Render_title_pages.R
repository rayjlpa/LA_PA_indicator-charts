##### RENDER TITLE PAGES  ------------------------------------------------------

LAlist <- unique(HB_LA$LocalAuthority)


# Loop through names and render a PDF for each
for (la_name in LAlist) {
  
  names <- HB_LA %>%
    filter(LocalAuthority==la_name)
  hb_name <- names$HealthBoard[1]
  
  if (spine_data_version == "current") {
    
      rmarkdown::render(paste0(dir2,"03_1_Title_page_2016-19.Rmd"),
                        output_file = paste0(gsub(" ", "_", la_name),"_Title_page",".pdf"),
                        output_dir = paste0(dir,"\\output\\PDFs\\1. Title pages"),
                        params = list(la_name = la_name,
                                      hb_name = hb_name),
                        envir = new.env())
  }
  if (spine_data_version == "new") {
   
     rmarkdown::render(paste0(dir2,"03_1_Title_page_2021-24.Rmd"),
                      output_file = paste0(gsub(" ", "_", la_name),"_Title_page",".pdf"),
                      output_dir = paste0(dir,"\\output\\PDFs\\1. Title pages"),
                      params = list(la_name = la_name,
                                    hb_name = hb_name),
                      envir = new.env())
  } 
} 
 

rm(list = setdiff(ls(), c("dir", "dir2", "hostname", "HB_LA", "spine_data_version")))
