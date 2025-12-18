This app displays evaluation results comparing how well various LLMs generate R code. 

## Methodology

- We used the [ellmer package](https://ellmer.tidyverse.org/) to create connections to various models and the [vitals package](https://vitals.tidyverse.org/) to evaluate model performance.

- Models were evaluated on the [`are` dataset](https://vitals.tidyverse.org/reference/are.html) (**A**n **R** **E**val), which contains challenging R coding problems and their solutions. `are` is included in the vitals package. 

- Each model's solution was scored by Claude 3.7 Sonnet as either Incorrect, Partially Correct, or Correct.

## Using LLMs for R Programming

LLMs can be powerful tools for R programming tasks:

- **Code Generation**: Generate R code from natural language descriptions
- **Debugging**: Help identify and fix errors in existing code
- **Package Discovery**: Find appropriate packages for specific tasks
- **Best Practices**: Learn idiomatic R patterns and tidyverse approaches

## Resources for R + LLMs

- [ellmer package](https://ellmer.tidyverse.org/) - Connect to LLMs from R
- [vitals package](https://vitals.tidyverse.org/) - Evaluate LLM code generation
- [are dataset](https://vitals.tidyverse.org/reference/are.html) - Challenging R coding problems for evaluation

## About This Project

**Author**: Mark Dippold based on work from Sara Altman and Simon Couch

**Repository**: [github.com/D-M4rk/model-eval](https://github.com/D-M4rk/model-eval)

This evaluation helps R users understand which LLMs perform best for R code generation tasks, enabling more informed choices when selecting AI coding assistants.
