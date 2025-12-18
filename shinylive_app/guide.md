# R Best Practices for Working with LLMs

## Getting Started with LLMs in R

Large Language Models (LLMs) can significantly enhance your R programming workflow. Here's how to make the most of them:

### Key R Packages for LLM Integration

- **[ellmer](https://ellmer.tidyverse.org/)** - Connect to various LLM providers (OpenAI, Anthropic, Google) from R
- **[httr2](https://httr2.r-lib.org/)** - Make direct API calls to LLM services
- **[chattr](https://mlverse.github.io/chattr/)** - RStudio addin for interactive AI assistance

### Next gen IDE for LLM Integration

- **[Positron](https://positron.posit.co/)** - Built in connections to various LLM providers (Less control, easier to use)

### Effective Prompting for R Code Generation

**Be Specific About Your Environment:**
```
Generate R code using tidyverse to read a CSV file,
filter rows where age > 25, and create a bar plot of
counts by category.
```

**Specify Package Preferences:**
- "Use base R pipe `|>` instead of magrittr pipe `%>%`"
- "Use data.table instead of dplyr"
- "Use ggplot2 for visualization"

**Provide Context:**
- Share your data structure (`glimpse(df)` output)
- Mention relevant column names
- Specify expected output format

### R Code Review Checklist

When using LLM-generated R code, always verify:

1. **Package Loading** - Are all required libraries loaded?
2. **Pipe Operator** - Is the correct pipe being used (`|>` vs `%>%`)?
3. **Data Types** - Are conversions handled correctly (factors, dates, numerics)?
4. **Missing Values** - Does the code handle `NA` values appropriately?
5. **Tidyverse Idioms** - For tidyverse code, are modern best practices followed?
6. **Performance** - For large datasets, is the approach efficient?

### Common LLM Pitfalls in R

**Outdated Syntax:**
LLMs may suggest older R patterns. Watch for:
- Using `%>%` instead of `|>` (base pipe available in R ≥ 4.1)
- `aes_string()` instead of `.data[[]]` in ggplot2
- Deprecated dplyr functions like `funs()`

**Package Confusion:**
- Mixing base R and tidyverse approaches unnecessarily
- Suggesting packages that don't exist or are archived
- Using functions from packages without loading them

**Data Assumptions:**
- Not checking for edge cases
- Assuming column names without verification
- Ignoring data type mismatches

### Best Practices for Production Code

1. **Start Small** - Test LLM-generated code on sample data first
2. **Add Error Handling** - Wrap code in `tryCatch()` for robustness
3. **Document Intent** - Add comments explaining what the code should do
4. **Test Edge Cases** - Verify behavior with empty data, NAs, extreme values
5. **Iterate** - Refine prompts based on initial results

### Debugging LLM-Generated Code

**Step-by-step approach:**
```r
# 1. Check data structure
str(your_data)
glimpse(your_data)

# 2. Test in pieces
your_data |>
  step1() |>
  str()  # Check intermediate result

# 3. Handle errors explicitly
result <- tryCatch({
  your_data |> 
    complex_operation()
}, error = function(e) {
  message("Error: ", e$message)
  NULL
})
```

### Useful Prompting Patterns

**"Explain this code":**
```
Explain what this R code does line by line:
[paste your code]
```

**"Optimize this":**
```
This R code works but is slow on large datasets.
Suggest optimizations using data.table or vectorization:
[paste your code]
```

**"Convert to tidyverse":**
```
Convert this base R code to use tidyverse functions:
[paste your code]
```

**"Add error handling":**
```
Add appropriate error handling and input validation
to this R function:
[paste your code]
```

### Resources for Learning More

- [R for Data Science](https://r4ds.hadley.nz/) - Modern tidyverse approaches
- [Advanced R](https://adv-r.hadley.nz/) - Deep dive into R programming
- [ellmer documentation](https://ellmer.tidyverse.org/) - LLM integration in R
- [Posit Community](https://forum.posit.co/) - Get help from the R community

### When to Use (and Not Use) LLMs

**Great for:**
- Boilerplate code generation
- Converting between data formats
- Learning new packages and functions
- Quick prototype development
- Documentation and comments

**Be cautious with:**
- Statistical analysis decisions (verify with domain knowledge)
- Complex algorithm implementations (verify correctness)
- Production-critical code (thorough testing required)
- Security-sensitive operations (review carefully)

### Tips for This Evaluation

The models evaluated in this app were tested on challenging R problems from the `are` dataset. Key findings:

- **Consistency matters** - Top models produce correct code reliably
- **Cost vs. performance** - Check the trade-offs in the "Cost vs. Performance" tab
- **Model selection** - Different models excel at different tasks
- **Iteration helps** - Even top models benefit from clarifying prompts

Remember: LLMs are tools to augment your R programming, not replace understanding of data analysis principles and R fundamentals.
