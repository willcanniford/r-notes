Rowwise functions
================

I can’t count the number of times that I’ve needed to calculate
something on a rowwise basis. This probably isn’t that common when you
have tidy data, and are trying to generate a new metric for every
observation in the data, rather than looking at that data one variable
at a time.

I will go through some of the methods that I have used in the past to
achieve applying a function per row for whatever reason might have
suited my needs at the time.

-----

# Using `apply`

This may be the most obvious choice but it was one that evaded me for
some time as I tried to use `dplyr` and the `tidyverse` to pipe all of
my actions together.

Using `apply` and setting the argument `MARGIN` to 1 means that the
function that you use is applied in a rowwise manner. The vector that is
then produced as a result can easily be assigned to the data frame that
you are working with.

*Example: you want to work out how many missing values there are per row
to find observations with largely missing information.*

``` r
df$na_count <- apply(df, MARGIN = 1, ~ sum(is.na(.)))
```

In this case we are going above the usual application and we are defined
an anonymous function to achieve what we are looking to achieve. The
result from the `apply` call is then assigned to the variable `na_count`
on the data frame `df`; you could later filter by this to give you
access to just those observations with a certain number of missing
values, or above a threshold that you have defined.
