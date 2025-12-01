# Evals from 2025-11-01 on

library(ellmer)
library(vitals)
library(tidyverse)

SCORER_MODEL <- "claude-3-7-sonnet-latest"

# -------------------------------------------------------------------------------------------------------
vitals::vitals_log_dir_set(here::here("logs/02_eval"))
source(here::here("eval/helper.R"))

scorer_chat <- chat_anthropic(model = SCORER_MODEL)

model_eval_2 <- function(
  model,
  filename = model,
  overwrite = TRUE,
  ...
) {
  model_path <- fs::path(results_dir, filename, ext = "rds")

  if (!overwrite & fs::file_exists(model_path)) {
    message(glue::glue("Skipping {model}: file already exists at {model_path}"))
    return(invisible(NULL))
  }

  chat <- chat(name = model, ...)

  are_model <- are_task$clone()
  are_model$eval(solver_chat = chat)

  readr::write_rds(are_model, file = model_path)
}

# Gemini 3
model_eval(
  model = "google_gemini/gemini-3-pro-preview",
  filename = "gemini_3"
)

# GPT-5.1
model_eval(
  model = "openai/gpt-5.1",
  filename = "gpt_5_1"
)

# Opus 4.5
model_eval(
  model = "anthropic/claude-opus-4-5-20251101",
  filename = "opus_4_5",
  api_args = list(
    thinking = list(type = "enabled", budget_tokens = 2000)
  )
)

# GPT-5 Codex
model_eval_2(
  model = "openai/gpt-5.1-codex",
  filename = "gpt_5_1_codex"
)
