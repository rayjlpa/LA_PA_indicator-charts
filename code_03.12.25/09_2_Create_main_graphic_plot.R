##### CREATE MAIN SPINE CHART PLOT ---------------------------------------------

p <- ggplot(la_profile, aes(y = reorder(indicatortitle, -order))) +
  geom_segment(aes(x = min_pcent, xend = max_pcent, yend = reorder(indicatortitle, -order)), 
               color = "#f7eac3", linewidth = 4) +
  geom_point(aes(x = indicator_pcent, color = sig_level), 
             size = 2, show.legend = FALSE) +
 geom_segment(data=la_profile, mapping=aes(x=avg_pcent, 
                   xend=avg_pcent, 
                   y=y_numeric+0.2,
                   yend=y_numeric-0.23),
               linetype = "dotted", color = "black") +
  scale_y_discrete(expand = expansion(mult=c(0.03,0.04))) +
  scale_color_manual(values = c(
    "Above average" = col_above,
    "Not significantly different" = col_nonsig,
    "Below average" = col_below
  )) +
  scale_x_continuous(limits = c(0, 100), labels = function(x) paste0(x, "%")) +
  labs(
    x = "Percentage (%)",
    y = NULL
  ) +
  theme_minimal(
    #base_family = "Calibri", 
    base_size = 10) +
  theme(
    axis.text.y = element_blank(),
    axis.title.x = element_text(margin = margin(t = 5)),
    plot.title = element_text(hjust = 0.5, size = 18, face = "bold"),
    plot.margin = margin(5, 0, 0,0))
  
  