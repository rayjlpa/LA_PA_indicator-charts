##### CREATE SED GRAPHIC PLOT

p2 <- ggplot(la_profile_sed, aes(y=reorder(indicatortitle, -order))) +
  geom_segment(aes(x = weighted_05, xend = weighted_95, yend = reorder(indicatortitle, -order)), 
               color = "#f7eac3", linewidth = 4) +
  geom_segment(aes(x = weighted_25, xend = weighted_75, yend = reorder(indicatortitle, -order)), 
               color = "#ffcc66", linewidth = 4) +
  geom_segment(aes(x=scotland_med, 
                   xend=scotland_med, 
                   y=y_numeric+0.2,
                   yend=y_numeric-0.2),
               linetype = "dotted", color = "black") +
  geom_point(aes(x = weighted_median, 
                 #color = sig_level
                 ), 
             size = 2, show.legend = FALSE) +
  scale_x_continuous(limits = c(1, 11.2)) +
  labs(
    x = "Sedentary Time (hours/day)",
    y = NULL
  ) +
  theme_minimal(
    #base_family = "Calibri", 
    base_size = 10) +
  theme(
    axis.text.y = element_blank(),
    plot.title = element_text(hjust = 0.5, size = 18, face = "bold"),
    plot.margin = margin(0, 0, 0,0))