##### RENDER RADAR PLOT PAGES  ------------------------------------------------

LAlist <- unique(HB_LA$LocalAuthority)


# Loop through names and render a PDF for each
for (la_name in LAlist) {
  
  names <- HB_LA %>%
    filter(LocalAuthority==la_name)
  hb_name <- names$HealthBoard[1]
  
  rmarkdown::render(paste0(dir2,"14_1_Radar_plot_page.Rmd"),
                    output_file = paste0(gsub(" ", "_", la_name),"_Radar_plot_page",".pdf"),
                    output_dir = paste0(dir,"\\output\\PDFs\\3. Radar plots"),
                    params = list(la_name = la_name,
                                  hb_name = hb_name),
                    envir = new.env())
  
  fn <- paste0(dir,"\\code\\",gsub(" ", "_", la_name),"_Radar_plot_page",".log")
  if (file.exists(fn)) {
    #Delete file if it exists
    file.remove(fn)
  }
}
#rm(list = setdiff(ls(), c("dir", "dir2", "hostname", "HB_LA", "spine_data_version")))