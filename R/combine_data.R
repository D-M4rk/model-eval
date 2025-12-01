# Combine and prepare results data for use
# Pre-processes the evaluation results into a smaller format
# and publishes to a pin on Connect Cloud

library(tidyverse)
library(vitals)
library(fs)
library(yaml)
library(pins)

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

# Prepare data for pin
app_data <- list(
  eval_data = eval_data_minimal,
  cost_data = are_costs,
  model_prices = model_prices
)

readr::write_rds(app_data, "data/app_data.rds")
