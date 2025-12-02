##### WRAP FILE ----------------------------------------------------------------

# directory links
hostname <- Sys.info()["nodename"]

if (hostname == "DESKTOP-76PIK88") {
  dir <- ""
} else if (hostname == "AHSS-COL-23012") {
  dir <- "C:/Users/tstrain/OneDrive - University of Edinburgh/LA_Spine_Charts"
} else if (hostname == "RAY") {
  dir <- "C:/Users/Ray_/OneDrive - University of Edinburgh/Tessa Strain's files - LA_Spine_Charts"
} else {
  stop("Unrecognised machine name. Please manually set 'dir'.")
}

dir2 <- paste0(dir,"\\code\\")

## ---- CHOOSE DATA VERSION FOR THIS RUN (NEW) ---------------------------------
## This controls which SHeS/SHS data window is used for the MAIN spine charts.
## "current" = existing pack; "new" = updated data window (once paths are set)
## To produce the new version, simply change "current" to "new" and rerun.

options(spine_data_version = "current")
# options(spine_data_version = "new")  # uncomment when you want to build the new version

message("Building LA PA indicator charts with data version: ",
        getOption("spine_data_version"))


# load packages and define version switch
source(paste0(dir2,"01_Housekeeping.R"))

# create title page
source(paste0(dir2,"02_HB_LA_dataframe.R"))
source(paste0(dir2,"03_0_Render_title_pages.R"))

# code for main indicator chart
source(paste0(dir2,"04_Import_data.R"))
source(paste0(dir2,"05_List_of_indicators.R"))
source(paste0(dir2,"06_Process_list.R"))
source(paste0(dir2,"07_Match_LA_to_HB.R"))
source(paste0(dir2,"08_Sedentary_indicator_prep.R"))
source(paste0(dir2,"09_0_Produce_main_graphic.R"))

# code for radar plot
source(paste0(dir2,"10_Import_radar_plot_data.R"))
source(paste0(dir2,"11_List_of_radar_plot_indicators.R"))
source(paste0(dir2,"12_Process_list_of_radar_plot_indicators.R"))
source(paste0(dir2,"13_Convert_to_data_frame.R"))
source(paste0(dir2,"14_0_Render_radar_plot_pages.R"))

# create definition page
source(paste0(dir2,"15_0_Render_definitions_pages.R"))

# combine pdfs
source(paste0(dir2,"16_Combined_charts.R"))
