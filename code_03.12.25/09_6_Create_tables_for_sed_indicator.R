##### CREATE TABLES FOR SED INDICATOR ------------------------------------------

la_profile_sed <- la_profile_sed %>%
            mutate(rev_order = -order) 


# Create the table-base pallete
table_base <- ggplot(la_profile_sed, aes(1)) +
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
tab1SB <- table_base + 
  geom_text(aes(y = reorder(indicatortitle, -order), x = 1, 
                label = indicatortitle), size = 3.5, vjust=0.7, hjust=0, 
            position = position_nudge(x = -2)) + 
  xlim(-1,1) 


# Weighted base
tab2SB <- table_base + 
  geom_text(aes(y = reorder(indicatortitle, -order), x = 1, 
                label = Freq2), size = 3.5, vjust=0.3) 

# LA or Health Board value
tab3SB <- table_base + 
  geom_text(aes(y = reorder(indicatortitle, -order), x = 1, 
                label = paste0(formatC(round(weighted_median,1),
                                       format="f", digits=1),
                                       " hrs/day")), 
            size = 3.5, vjust=0.3) 

# Scotland average
tab4SB <- table_base + 
  geom_text(aes(y = reorder(indicatortitle, -order), x = 1, 
                label = paste0(formatC(round(scotland_med,1), 
                                       format="f", digits=1),
                               " hrs/day")), 
            size = 3.5, vjust=0.3)  

# subsystem colours
table_base <- ggplot(la_profile_sed) +
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
        plot.margin = margin(t = 0, r = 0, b = 20, l = 0)
  )

coloursSB <- table_base +
  geom_rect(aes(xmin = 0.4, xmax=0.7,
                ymin = rev_order-0.25, ymax=rev_order+0.15,
                fill = colour3, colour = "black"), size=0.4) +
  scale_fill_identity() +
  scale_alpha_identity() +
  scale_color_identity() +
  scale_y_continuous(
    limits = c(min(la_profile_sed$rev_order) - 0.3,
               max(la_profile_sed$rev_order) + 0.2),
    expand = c(0, 0)
  ) +
  ggtitle(" \n ")