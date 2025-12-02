##### LEGENDS ------------------------------------------------------------------


# Colours for significance
col_above <- "#4fd68c"
col_nonsig <- "grey70"
col_below <- "#e34529"


# main list of indicators

leg_data <- data.frame(
      min_pcent = c(30),
      max_pcent = c(70),
      indicator_pcent = c(50),
      sig_level = "Not significantly different",
      colour1 = "#f47735",
      colour2 = "#4e7bcf",
      scotland_avg = c(60)
)

sig_points <- data.frame(
      point_x = c(5,5,5),
      point_y = c(0.96, 0.95, 0.94),
      sig_level = c("Above average", 
                  "Not significantly different",
                  "Below average")
)

leg1 <- ggplot(leg_data, aes(y = 1)) +
            geom_segment(aes(x = min_pcent, xend = max_pcent, yend = 1), 
                         color = "#f7eac3", linewidth = 4) +
            geom_point(aes(x = indicator_pcent, color = sig_level), 
                       size = 3, show.legend = FALSE) +
            geom_point(data=sig_points, mapping=aes(x=point_x,
                                          y=point_y,
                                          color=sig_level), 
                       size = 3) +
            geom_segment(aes(x = scotland_avg, xend = scotland_avg, 
                             y=0.99, yend = 1.05), 
                         color = "black", linetype = "dotted") +
            scale_color_manual(values = c(
              "Above average" = col_above,
              "Not significantly different" = col_nonsig,
              "Below average" = col_below
            )) +
            scale_x_continuous(limits = c(0, 100), labels = function(x) paste0(x, "%")) +
            scale_y_continuous(limits = c(0.93,1.05)) +
            labs(
              title = " ",
              x = "Percentage (%)",
              y = NULL
            ) +
            theme_minimal(
              #base_family = "Calibri", 
              base_size = 10) +
            theme(
              axis.text.y = element_blank(),
              axis.title.x = element_blank(),
              axis.text.x = element_blank(),
              plot.title = element_blank(),
              plot.margin = margin(0, 0, 0,0),
              legend.position = "none",
              panel.grid = element_blank()
              ) +
            annotate("text", x=20, y=1.037, label="Minimum LA/\nHB value", size=3.6) +
            annotate(
              "segment",
              x = 20, xend = 29,
              y = 1.02, yend = 1,
              arrow = arrow(length = unit(0.1, "cm")),
              color = "black",
              linewidth = 0.5
            ) +
            annotate("text", x=80, y=1.037, label="Maximum LA/\nHB value", size=3.6) +
            annotate(
              "segment",
              x = 80, xend = 71,
              y = 1.02, yend = 1,
              arrow = arrow(length = unit(0.1, "cm")),
              color = "black",
              linewidth = 0.5
            ) +
            annotate("text", x=50, y=0.975, label="LA/HB value", size=3.6) +
            annotate(
              "segment",
              x = 50, xend = 50,
              y = 0.98, yend = 0.995,
              arrow = arrow(length = unit(0.1, "cm")),
              color = "black",
              linewidth = 0.5
            ) +
            annotate("text", x=8, y=0.96, label="LA/HB better than Scotland average", hjust=0, size=3.6) +
            annotate("text", x=8, y=0.95, 
                     label="LA/HB not significantly different from Scotland average", 
                     hjust=0, size=3.6) +
            annotate("text", x=8, y=0.94, label="LA/HB worse than Scotland average", hjust=0, size=3.6) +
            annotate("text", x=50, y=1.03, label="Scotland\naverage", size=3.6) +
            annotate(
              "segment",
              x = 53, xend = 59,
              y = 1.015, yend = 1.01,
              arrow = arrow(length = unit(0.1, "cm")),
              color = "black",
              linewidth = 0.5
            ) 
  leg1

# sedentary plot

leg_data2 <- data.frame(
  weighted_05 = c(2),
  weighted_95 = c(8),
  weighted_25 = c(4),
  weighted_75 = c(6),
  weighted_median = c(5),
  scotland_med = c(5.5)
  )

leg2 <- ggplot(leg_data2, aes(y=1)) +
              geom_segment(aes(x = weighted_05, xend = weighted_95, yend = 1), 
                           color = "#f7eac3", linewidth = 4) +
              geom_segment(aes(x = weighted_25, xend = weighted_75, yend = 1), 
                           color = "#ffcc66", linewidth = 4) +
              geom_point(aes(x = weighted_median, 
              ), 
              size = 2, show.legend = FALSE) +
             geom_segment(aes(x = scotland_med, xend = scotland_med, 
                   y=0.99, yend = 1.02), 
               color = "black", linetype = "dotted") +
              scale_x_continuous(limits = c(1.2, 8.8)) +
              scale_y_continuous(limits = c(0.97,1.035)) +
              labs(
                title = " ",
                x = "Sedentary Time (hours/day)",
                y = NULL
              ) +
              theme_minimal(
                #base_family = "Calibri", 
                base_size = 10) +
              theme(
                axis.text.y = element_blank(),
                axis.title.x = element_blank(),
                axis.text.x = element_blank(),
                plot.title = element_blank(),
                plot.margin = margin(0, 0, 0,0),
                panel.grid = element_blank()
                ) +
              annotate("text", x=2.3, y=1.03, label="5th percentile* of\ndistribution for HB", size=3.6) +
              annotate(
                "segment",
                x = 2, xend = 2,
                y = 1.02, yend = 1.003,
                arrow = arrow(length = unit(0.1, "cm")),
                color = "black",
                linewidth = 0.5
              ) +
              annotate("text", x=7.7, y=1.03, label="95th percentile* of\ndistribution for HB", size=3.6) +
              annotate(
                "segment",
                x = 8, xend = 8,
                y = 1.02, yend = 1.003,
                arrow = arrow(length = unit(0.1, "cm")),
                color = "black",
                linewidth = 0.5
              ) +
              annotate("text", x=4.7, y=1.018, label="HB\nmedian", size=3.6) +
              annotate(
                "segment",
                x = 4.7, xend = 5,
                y = 1.01, yend = 1.003,
                arrow = arrow(length = unit(0.1, "cm")),
                color = "black",
                linewidth = 0.5
              ) +
              annotate("text", x=3, y=0.98, label="25th percentile* of\ndistribution for HB", size=3.6) +
              annotate(
                "segment",
                x = 3, xend = 4,
                y = 0.99, yend = 0.997,
                arrow = arrow(length = unit(0.1, "cm")),
                color = "black",
                linewidth = 0.5
              ) +
              annotate("text", x=7, y=0.98, label="75th percentile* of\ndistribution for HB", size=3.6) +
              annotate(
                "segment",
                x = 7, xend = 6,
                y = 0.99, yend = 0.997,
                arrow = arrow(length = unit(0.1, "cm")),
                color = "black",
                linewidth = 0.5
              )  +
              annotate("text", x=6.25, y=1.017, label="Scotland\nmedian", size=3.6) +
              annotate(
                "segment",
                x = 6, xend = 5.55,
                y = 1.009, yend = 1.007,
                arrow = arrow(length = unit(0.1, "cm")),
                color = "black",
                linewidth = 0.5
              )  

