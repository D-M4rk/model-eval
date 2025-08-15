library(ellmer)
library(vitals)
library(tidyverse)

OPENAI_MODELS <- 
  c(
    "gpt_o1" = "o1-2024-12-17",
    "gpt_o3_mini" = "o3-mini-2025-01-31",
    "gpt_o3" = "o3-2025-04-16",
    "gpt_o4_mini" = "o4-mini-2025-04-16",
    "gpt_4_1" = "gpt-4.1-2025-04-14",
    "gpt_5" = "gpt-5",
    "gpt_5_mini" = "gpt-5-mini",
    "gpt_5_nano" = "gpt-5-nano"
  )

ANTHROPIC_MODEL <- "claude-sonnet-4-20250514"
SCORER_MODEL <- "claude-3-7-sonnet-latest"

results_dir <- here::here("results_rds_2")
# -------------------------------------------------------------------------------------------------------

vitals::vitals_log_dir_set("./logs")

scorer_chat <- chat_anthropic(model = SCORER_MODEL)

are_task <- Task$new(
  dataset = are,
  solver = generate(),
  scorer = model_graded_qa(
    scorer_chat = scorer_chat, 
    partial_credit = TRUE
  ),
  epochs = 3,
  name = "An R Eval"
)
  

model_eval <- function(model, filename = model, chat_fun, overwrite = TRUE, ...) {
  model_path <- fs::path(results_dir, filename, ext = "rds")
  
  if (!overwrite & fs::file_exists(model_path)) {
    message(glue::glue("Skipping {model}: file already exists at {model_path}"))
    return(invisible(NULL))
  }

  chat <- chat_fun(model = model, ...)

  are_model <- are_task$clone()
  are_model$eval(solver_chat = chat)

  write_rds(are_model, file = model_path)
}

iwalk(OPENAI_MODELS, model_eval, chat_fun = chat_openai)

model_eval(
  ANTHROPIC_MODEL, 
  filename = "sonnet_4", 
  chat_fun = chat_anthropic
)

model_eval(
  c("sonnet_4_thinking" = ANTHROPIC_MODEL), 
  filename = "sonnet_4_thinking",
  chat_fun = chat_anthropic, 
  api_args = list(
    thinking = list(type = "enabled", budget_tokens = 2000)
  )
)

# OpenAI OSS Models

# gpt-oss-20b
model_eval(
  model = "openai/gpt-oss-20b",
  file = "gpt_oss_20b",
  chat_fun = chat_openai,
  api_key  = Sys.getenv("HUGGING_FACE_API_KEY"),
  base_url = "https://br0abwivakn2ibas.us-east-2.aws.endpoints.huggingface.cloud/v1"
)

# gpt-oss-120b
model_eval(
  model = "openai/gpt-oss-120b",
  file = "gpt_oss_120b",
  chat_fun = chat_openai,
  api_key  = Sys.getenv("HUGGING_FACE_API_KEY"),
  base_url = "https://nd8rjz8obh824ny0.us-east-2.aws.endpoints.huggingface.cloud/v1"
)