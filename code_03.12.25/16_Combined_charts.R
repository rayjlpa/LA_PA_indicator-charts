#### COMBINE PDFS --------------------------------------------------------------

dir3 <- paste0(dir,"\\output\\PDFs\\")

LAlist <- unique(HB_LA$LocalAuthority)

# Loop through names and render a PDF for each
for (la_name in LAlist) {
  
pdf_subset(paste0(dir3,"2. Main spine charts\\",gsub(" ", "_", la_name),"_main_chart_pdf.pdf"),
           paste0(dir3,"2. Main spine charts\\",gsub(" ", "_", la_name),"_main_chart_pdf2.pdf"),
           pages = 2)  
  
pdf_combine(
  input = c(paste0(dir3,"1. Title pages\\",gsub(" ", "_", la_name),"_Title_page.pdf"), 
            paste0(dir3,"2. Main spine charts\\",gsub(" ", "_", la_name),"_main_chart_pdf2.pdf"),
            paste0(dir3,"3. Radar plots\\",gsub(" ", "_", la_name),"_Radar_plot_page.pdf"),
            paste0(dir3,"4. Definitions\\",gsub(" ", "_", la_name),"_Definitions_page.pdf")),
  output = paste0(dir3,"Combined charts\\",gsub(" ", "_", la_name),".pdf")
)

fn1 <- paste0(dir,
              "\\output\\PDFs\\2. Main spine charts\\",
              gsub(" ", "_", la_name),"_main_chart_pdf2",".pdf")
if (file.exists(fn1)) {
  file.remove(fn1)
}

}
