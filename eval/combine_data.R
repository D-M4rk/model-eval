# Combine and prepare results data for use
# Pre-processes the evaluation results into a smaller format
# and publishes to a pin on Connect Cloud

library(tidyverse)
library(vitals)
library(fs)
library(yaml)
library(pins)

# Source the data loading functions
source("eval/data_loading.R")

# Load model info (pricing and provider)
model_info <- load_model_info("data/model_info.yaml")

# Load evaluation results
tasks <- load_eval_results("results_rds")

# Process evaluation data using model_info for name mapping
are_eval_full <- process_eval_data(tasks, model_info)

# Extract only the columns needed for the app to minimize file size
eval_data_minimal <- are_eval_full |>
  select(model_join, model_display, score)

# Compute cost data
are_costs <- compute_cost_data(tasks, model_info)

app_data <- list(
  eval_data = eval_data_minimal,
  cost_data = are_costs,
  model_info = model_info
)

readr::write_rds(app_data, "data/data_combined.rds")
