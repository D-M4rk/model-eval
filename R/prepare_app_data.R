# Prepare data for Shiny app
# Pre-processes the evaluation results into a smaller format

library(tidyverse)
library(vitals)
library(fs)
library(yaml)

# Source the data loading functions
source("R/data_loading.R")

# Load model prices
model_prices <- load_model_prices("data/model_prices.yaml")

# Load evaluation results
tasks <- load_eval_results("results_rds")

# Process evaluation data
are_eval_full <- process_eval_data(tasks)

# Extract only the columns needed for the app to minimize file size
eval_data_minimal <- are_eval_full |>
  select(model_join, model_display, score)

# Compute cost data
are_costs <- compute_cost_data(tasks, model_prices)

# Save to a single RDS file with minimal data
readr::write_rds(
  list(
    eval_data = eval_data_minimal,
    cost_data = are_costs,
    model_prices = model_prices
  ),
  "data/app_data.rds"
)
