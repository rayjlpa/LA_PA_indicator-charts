##### PROCESS LIST OF INDICATORS -----------------------------------------------

process_indicator <- function(config) {
  
  df <- get(config$dataset) %>%
    filter(!is.na(.data[[config$weight]]),
           !is.na(.data[[config$strata]]),
           !is.na(.data[[config$raw_var]])
           ) %>%
    mutate(
      binary_var = config$to_binary(.data[[config$raw_var]]),
      area = as_factor(.data[[config$area]])
      ) 
  
  svy_design <- svydesign(
    ids = ~1,
    weights = as.formula(paste0("~", config$weight)),
    strata = as.formula(paste0("~", config$strata)),
    data = df
  )
  
  summary_df <- svyby(
    ~binary_var, ~area, svy_design, svymean, na.rm=TRUE, ci=TRUE, vartype="ci"
  ) %>%
    rename(
      indicator = binary_var,
      lowerci = ci_l,
      upperci = ci_u
    ) %>%
    arrange(indicator)
  
  weightedn <- svytable(~area, svy_design, na.rm=TRUE)
  weightedn <- as.data.frame(weightedn)
  summary_df <- merge(summary_df, weightedn, by = "area")
  
  wholescotvals <- svymean(~binary_var, svy_design, na.rm=TRUE)
  summary_df$scotland_avg     <- as.numeric(wholescotvals)
  summary_df$scotland_avg_lci <- confint(wholescotvals)[1]
  summary_df$scotland_avg_uci <- confint(wholescotvals)[2]
  summary_df$scotland_min     <- min(summary_df$indicator, na.rm=TRUE)
  summary_df$scotland_max     <- max(summary_df$indicator, na.rm=TRUE)
  summary_df$scotland_q25     <- quantile(summary_df$indicator, 0.25, na.rm=TRUE)
  summary_df$scotland_q75     <- quantile(summary_df$indicator, 0.75, na.rm=TRUE)
  
  summary_df <- summary_df %>%
    mutate(
      sig_level = case_when(
                            (upperci < scotland_avg_lci) & 
                              (lowerci < scotland_avg_lci) ~ "Below average",
                            (lowerci > scotland_avg_uci) & 
                              (upperci > scotland_avg_uci) ~ "Above average",
                            TRUE ~ "Not significantly different"
                            ),
      sig_level = factor(sig_level, 
                         levels = c("Above average", 
                                    "Not significantly different", 
                                    "Below average")
                         )
          )
  
  summary_df$var_name   <- config$name
  summary_df$order      <- config$order
  summary_df$subsystem  <- config$subsystem
  summary_df$subsystem2 <- config$subsystem2
  summary_df$dataset    <- config$dataset
  summary_df
}

## Apply function to the indicators --------------------------------------------
summary_list <- lapply(variables_list, function(cfg) process_indicator(cfg))
names(summary_list) <- sapply(variables_list, function(x) x$name)


rm(variables_list, process_indicator)
