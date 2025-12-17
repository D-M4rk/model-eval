# R Code Generation: LLM Performance Evaluation

**Author**: Mark Dippold

This repository evaluates how well different AI models generate R code. The evaluation uses the `are` (**A**n **R** **E**val) dataset from the [vitals package](https://vitals.tidyverse.org/), which contains challenging R coding problems and solutions.

## Live App

**[View the live Shinylive app](https://d-m4rk.github.io/model-eval/)** to compare model performance and costs for a variety of LLMs.

## Methodology

* We used [ellmer](https://ellmer.tidyverse.org/) to create connections to the various models and [vitals](https://vitals.tidyverse.org/) to evaluate model performance on R code generation tasks.
* We tested each model on a shared benchmark: the `are` dataset (An R Eval). `are` contains a collection of difficult R coding problems and a column, `target`, with information about the target solution.  
* Using vitals, we had each model solve each problem in `are`. Then, we scored their solutions using a scoring model (Claude 3.7 Sonnet). Each solution received either an Incorrect, Partially Correct, or Correct score. 

## Running Evaluations

To run the evaluations yourself (or experiment with different models), run or edit the scripts `eval/01_eval.R` and `eval/02_eval.R`. Note that you will need API keys for all model providers. See the ellmer [documentation on authentication](https://ellmer.tidyverse.org/#authentication) for more details. 

## Deployment

This app is deployed to GitHub Pages using Shinylive, allowing it to run entirely in the browser without requiring a server. The deployment is automated via GitHub Actions.

## Using LLMs for R Programming

LLMs can be powerful tools for R programming:
- **Code Generation**: Generate R code from natural language descriptions
- **Debugging**: Help identify and fix errors in existing code
- **Package Discovery**: Find appropriate packages for specific tasks
- **Best Practices**: Learn idiomatic R patterns and tidyverse approaches

## References

- [ellmer package](https://ellmer.tidyverse.org/) - Connect to LLMs from R
- [vitals package](https://vitals.tidyverse.org/) - Evaluate LLM code generation
- [are dataset](https://vitals.tidyverse.org/reference/are.html) - Challenging R coding problems
