##### HOUSEKEEPING -------------------------------------------------------------

.libPaths(c("C:/Users/tstrain/Rlibs",
            "C:/Program Files/R441/library",
            "C:/ProgramData/R441/library/"))

# packages
library(plyr)
library(haven)
library(dplyr)
library(survey)
library(writexl)
library(ggplot2)
library(scales)
library(readxl)
library(gridExtra)
library(janitor)
library(tidyverse)
library(showtext)
library(ggdist)
library(glue)
library(ggtext)
library(MetBrewer)
library(patchwork)
library(gridtext)
library(cowplot)
library(tibble)
library(forcats)
library(Hmisc)
library(fmsb)
library(gridGraphics)
library(png)
library(grid)
library(magick)
library(extrafont)
library(gtable)
library(tinytex)
library(ggpubr)
library(flextable)
library(officer)
library(rmarkdown)
#install.packages("remotes")
#remotes::install_github("ricardo-bion/ggradar", lib = "C:/Users/tstrain/Rlibs", dependencies=TRUE)
library(ggradar)
library(qpdf)

# fonts
loadfonts(device = "win")
loadfonts(device = "pdf")
theme_update(
  text = element_text(family = "Arial")
)

## ---- DATA VERSION SWITCH ----------------------------------------------------
## Which data window should the main spine charts use?
## "current" = the existing pack (original data window)
## "new"     = an updated data window (new SHeS/SHS files)
## Default = "current". This can be overridden in Wrap File.R
## via: options(spine_data_version = "new")
spine_data_version <- getOption("spine_data_version", "current")

message("Using data version for main spine charts: ", spine_data_version)
