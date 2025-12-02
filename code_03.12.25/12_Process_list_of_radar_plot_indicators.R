##### PROCESS LIST OF RADAR PLOT INDICATORS ------------------------------------

process_indicator <- function(config) {
  
  df <- get(config$dataset) %>%
    filter(!is.na(.data[[config$weight]]),
           !is.na(.data[[config$strata]]),
           !is.na(.data[[config$raw_var]])
    )  %>%
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
  
  summary_df$var_name   <- config$name
  summary_df$order      <- config$order
  summary_df$year       <- 2019
  summary_df
  
  df <- get(config$dataset2) %>%
    filter(!is.na(.data[[config$weight2]]),
           !is.na(.data[[config$strata]]),
           !is.na(.data[[config$raw_var]])
    )  %>%
    mutate(
      binary_var = config$to_binary(.data[[config$raw_var]]),
      area = as_factor(.data[[config$area]])
    ) 
  
  svy_design <- svydesign(
    ids = ~1,
    weights = as.formula(paste0("~", config$weight2)),
    strata = as.formula(paste0("~", config$strata)),
    data = df
  )
  
  summary_df2 <- svyby(
    ~binary_var, ~area, svy_design, svymean, na.rm=TRUE, ci=TRUE, vartype="ci"
  ) %>%
    rename(
      indicator = binary_var,
      lowerci = ci_l,
      upperci = ci_u
    ) %>%
    arrange(indicator)
  
  summary_df2$var_name   <- config$name
  summary_df2$order      <- config$order
  summary_df2$year       <- 2015
  summary_df2 
  
 summary_df <- bind_rows(summary_df, summary_df2) 
  
}

## Apply function to the indicators --------------------------------------------
summary_list <- lapply(variables_list, function(cfg) process_indicator(cfg))
names(summary_list) <- sapply(variables_list, function(x) x$name)


rm(variables_list, process_indicator)
