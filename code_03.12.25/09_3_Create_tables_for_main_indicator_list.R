##### CREATE TABLES FOR MAIN INDICATOR LIST ------------------------------------

# add % signs to variables
la_profile <- la_profile %>%
                mutate(indicator_pcent = case_when(!is.na(indicator_pcent) ~ paste0(round(indicator_pcent),"%"),
                                                   TRUE ~ "N/A"),
                       avg_pcent = case_when(!is.na(avg_pcent) ~ paste0(round(avg_pcent),"%"),
                                                   TRUE ~ "N/A"),
                       min_pcent = case_when(!is.na(min_pcent) ~ paste0(round(min_pcent),"%"),
                                                   TRUE ~ "N/A"),
                       max_pcent = case_when(!is.na(max_pcent) ~ paste0(round(max_pcent),"%"),
                                                   TRUE ~ "N/A")) %>%
                mutate(rev_order = -order) 

# Create the table-base pallete
table_base <- ggplot(la_profile) +
  ylab(NULL) + xlab("  ") + 
  theme(plot.title = element_text(hjust = 0.5, size=6),
        axis.text.x = element_blank(),
        axis.line = element_blank(),
        axis.text.y = element_blank(), 
        axis.ticks = element_blank(),
        axis.title.y = element_blank(), 
        legend.position = "none",
        panel.background = element_blank(), 
        panel.border = element_blank(), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.margin = margin(t = 0, r = 0, b = 0, l = 0)
  )

# Indicator
tab1 <- table_base + 
  geom_text(aes(y = rev_order, x = 1, 
                label = indicatortitle), size=3.5, vjust=0.5, hjust=0, 
            position = position_nudge(x = -2)) +
  xlim(-1,1) 

# Weighted base
tab2 <- table_base + 
  geom_text(aes(y = rev_order, x = 1, 
                label = Freq2), size=3.5, vjust=0.5) 

# LA or Health Board value
tab3 <- table_base + 
  geom_text(aes(y = rev_order, x = 1, 
                label = indicator_pcent), 
            vjust=0.5, size=3.5) 

# Scotland average
tab4 <- table_base + 
  geom_text(aes(y = rev_order, x = 1, 
                label = avg_pcent), 
            size=3.5, vjust=0.5) 

# Scotland min
tab5 <- table_base +
  geom_text(aes(y = rev_order, x = 1, 
                label = min_pcent), 
            size=3.5, vjust=0.5) 

# Scotland max
tab6 <- table_base +
  geom_text(aes(y = rev_order, x = 1, 
                label = max_pcent), 
            size=3.5, vjust=0.5) 

# subsystem colours
colours <- table_base +
  geom_rect(aes(xmin = 0.4, xmax=0.7,
                ymin = rev_order-0.3, ymax=rev_order+0.2,
                fill = colour3, colour = "black"), size=0.4) +
  geom_rect(aes(xmin = 0.4, xmax=0.55,
                ymin = rev_order-0.3, ymax=rev_order+0.2,
                fill = colour1, alpha=alpha, colour = border), size=0.4) +
  geom_rect(aes(xmin = 0.55, xmax=0.7,
                ymin = rev_order-0.3, ymax=rev_order+0.2,
                fill = colour2, alpha=alpha, colour = border), size=0.4) +
  scale_fill_identity() +
  scale_alpha_identity() +
  scale_color_identity() +
  scale_y_continuous(
    limits = c(min(la_profile$rev_order) - 1,
                max(la_profile$rev_order) + 1),
    expand =  c(0, 0)
  )  