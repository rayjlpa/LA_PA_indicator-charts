
# Match the Health Board to the LA
names <- HB_LA %>%
  filter(LocalAuthority==la_name)
hb_name <- names$HealthBoard[1]

# Create data table for the LA
la_profile <- all_results %>%
  filter(area == la_name | area==hb_name) %>%
  arrange(order) %>%
  select(indicator, order, year, area)

if (la_name == "Argyll and Bute") {
  la_profile <- la_profile %>%
    filter((order>=1 & order<=3) |
             ((order==4 | order==5 | order==7 |
                 order==8 | order==9 | order==10 |
                 order==11) & area=="Argyll and Bute") |
             (order==6)
    )
}


la_profile_wide <- la_profile %>%
            select(-area) %>%
            mutate(indicator= indicator*100) %>%
            pivot_wider(names_from = order, values_from = indicator) %>%
            mutate(year = factor(year,
                                 levels = c(2015, 2019),
                                 labels = c("SHeS 2012-15\nSHS 2015",
                                            "SHeS 2016-19*\nSHS 2019")))

colnames(la_profile_wide) <- c("year", 
                               "1. Adult MVPA", 
                               "4. Child MVPA", 
                               "5. Adult Muscle\nStrengthening", 
                               "10. Adult\nRecreational\nWalking", 
                               "12. Adult Sport", 
                               "14. Child Sport",
                               "16. Adult Active\nTravel to work",
                               "17. Child Active\nTravel to School",
                               "18. Adult\nvisit outdoors",
                               "19. Adult satisfied\nwith local\nleisure facilities",
                               "20. Adult satisfied\nwith local parks and spaces")


plot <- ggradar(la_profile_wide,
                values.radar = c("0%", "50%", "100%"),
                grid.min = 0, grid.mid = 50, grid.max = 100,
                group.line.width = 1.5,
                group.point.size = 3,
                axis.label.size = 5,
                background.circle.colour = "white",
                gridline.min.linetype = "solid",
                gridline.min.colour = "grey80",
                group.colours = c("#1f77b4", "#ff7f0e"),
                legend.position = "bottom")

plot








