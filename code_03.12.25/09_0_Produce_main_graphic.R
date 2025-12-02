##### CREATE MAIN SPINE CHART --------------------------------------------------

# create a dataset of colours for the subsystems
colour_ref <- data.frame(system = c("Overarching", "Sport and Active Recreation",
                                    "Active Places of Learning", "Active Travel",
                                    "Active Workplaces", "Active Places and Spaces"),
                         colour = c("#a8cfff", "#4e7bcf",
                                    "#f47735", "#f4bd35",
                                    "#a391af", "#76da1c"))

# Colours for significance
col_above <- "#4fd68c"
col_nonsig <- "grey70"
col_below <- "#e34529"

# loop through local authorities
LAlist <- unique(HB_LA$LocalAuthority)

# confirmed that warnings are just for the shetland/western isles
# where the sIMD indicator doesn't apply
#remove_vals <- c("Eilean Siar", "Shetland")
#LAlist <- LAlist[!LAlist %in% remove_vals]
#LAlist <- remove_vals

for (la_name in LAlist) {
  
  # create dataset with only 1 LA in
  source(paste0(dir2,"09_1_Select_LA_dataset.R"))

  # create the main graphic plot
  source(paste0(dir2,"09_2_Create_main_graphic_plot.R"))

  # create tables for main indicator list
  source(paste0(dir2,"09_3_Create_tables_for_main_indicator_list.R"))

  # create the la dataset for sed indicators
  source(paste0(dir2,"09_4_Select_LA_dataset_for_sed.R"))
  
  # create the sed graphic plot
  source(paste0(dir2,"09_5_Create_sed_graphic_plot.R"))
  
  # create tables for sedentary indicator
  source(paste0(dir2,"09_6_Create_tables_for_sed_indicator.R")) 
  
  ## Merge tables with plot
  lay <-  matrix(c(rep(1,37),
                   2,rep(3,13),4,4,4,5,5,6,6,7,7,8,8,rep(9,12),
                   rep(10,37),
                   11,rep(12,14),13,13,14,14,14,14,15,15,15,15,rep(16,12)),
                   ncol=37, byrow=TRUE)

  mainplot <- grobTree(
    arrangeGrob(
      nullGrob(),
      colours,tab1,tab2,tab3,tab4,tab5,tab6, p,
      nullGrob(),
      coloursSB,tab1SB,tab2SB,tab3SB,tab4SB,p2,
      layout_matrix = lay,
                heights=c(0.3,12,0.2,1.6),
                top = textGrob(paste0(la_name, ": Physical activity indicators"), 
                               gp = gpar(fontsize = 16, fontface = "bold"), 
                               vjust=1)),
    textGrob("Sample\nsize", x = 0.42, y = 0.95,
             gp = gpar(fontsize = 10, fontface="bold", lineheight=0.8)),
    textGrob("LA/HB\nvalue", x = 0.49, y = 0.95,
             gp = gpar(fontsize = 10, fontface="bold", lineheight=0.8)),
    textGrob("Scot\nave", x = 0.54, y = 0.95,
             gp = gpar(fontsize = 10, fontface="bold", lineheight=0.8)),
    textGrob("LA/HB\nmin", x = 0.595, y = 0.95,
             gp = gpar(fontsize = 10, fontface="bold", lineheight=0.8)),
    textGrob("LA/HB\nmax", x = 0.65, y = 0.95,
             gp = gpar(fontsize = 10, fontface="bold", lineheight=0.8)),
    textGrob("Sample\nsize", x = 0.43, y = 0.115,
             gp = gpar(fontsize = 10, fontface="bold", lineheight=0.8)),
    textGrob("Median\nfor HB", x = 0.515, y = 0.115,
             gp = gpar(fontsize = 10, fontface="bold", lineheight=0.8)),
    textGrob("Scot\nmedian", x = 0.62, y = 0.115,
             gp = gpar(fontsize = 10, fontface="bold", lineheight=0.8))
  )
  
  ggsave(
  filename = paste0(dir,
                    "\\output\\PDFs\\2. Main spine charts\\",
                    gsub(" ", "_", la_name),"_main_chart.pdf"), 
  plot = mainplot, 
  width = 8.27, height = 11.69, units="in", limitsize = FALSE
)
 
  names <- HB_LA %>%
    filter(LocalAuthority==la_name)
  hb_name <- names$HealthBoard[1]
  
  rmarkdown::render(paste0(dir2,"09_7_Main_charts_page.Rmd"),
                    output_file = paste0(gsub(" ", "_", la_name),"_main_chart_pdf",".pdf"),
                    output_dir = paste0(dir,"\\output\\PDFs\\2. Main spine charts"),
                    params = list(la_name = la_name,
                                  hb_name = hb_name),
                    envir = new.env(),
                    intermediates_dir = tempdir(), 
                    clean=TRUE)

  fn1 <- paste0(dir,"\\code\\",gsub(" ", "_", la_name),"_main_chart_pdf",".log")
  fn2 <- paste0(dir,
                "\\output\\PDFs\\2. Main spine charts\\",
                gsub(" ", "_", la_name),"_main_chart",".pdf")
  if (file.exists(fn1)) {
    file.remove(fn1)
  }
  if (file.exists(fn2)) {
    file.remove(fn2)
  }
}

rm(list = setdiff(ls(), c("dir", "dir2", "hostname", "HB_LA", "spine_data_version")))