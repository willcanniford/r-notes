Functions in R
================

This is a collection of notes about building functions, and some of the
best practices that we should emulate when doing so to maintain good
code structure.

## Types of arguments

There are, generally speaking, two types of arguments:

  - **Data arguments** - *these are the arguments that the result is
    computed on*
  - **Detail arguments** - *these define how the computation is
    performed by the function*

Data arguments should always preceed the detail arguments, this helps
with clarity, and with the ability to pipe functions together.

### Argument clarity

Some older base functions could be renamed and wrapped in a custom
user-defined function to aid in the readability and flow of the code.
This can be particularly true of model functions that don’t take the
**data arguments** as the first argument, and thus can’t cleanly be used
with pipes and the `tidyverse`.

Defining our own function could clean up our analysis and code to make
it more obvious what we are doing for others to see. Below is an example
of this with defining a function that takes the arguments for a `glm()`
call and rearranges them, giving a clear name at the same time.

``` r
run_poisson_regression <- function(data, formula) {
  glm(formula, data, family = poisson)
}
```
