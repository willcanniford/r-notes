Cleaning Data in R
================

Just a collection of notes and functions about cleaning data in R. Most of the code here was written to solve real problems and issues that I came across when dealing with messier datasets in R. I wish I could have found someone who had written a function that did what I wanted it do to...

### Remove and replace all instances of a particular string

I've included the loading os some more generic packages that I tend to use when trying to troubleshoot problems and analyse data.

``` r
library(readr)
library(tidyverse)
library(purrr)
```

The scenario I was having in this instance was that I was importing a csv file that I had generated after doing an initial query in SQL and exporting the results table. Sequel Pro seems to fill in missing `NULL` values with the string "NULL".
This may not have impacted my particular analysis, but I would rather the dataset be clean and all missing values represented by `NA`; this makes filtering much easier later on as you can easily use something like `filter(data, !is.na(column_of_interest))` rather than trying to match every case in the data that you know means blank, in order to keep only those complete observations.

One way of doing this is actually directly at the point of loading, using an argument in the `read_csv()` function from `readr`. Unfortunately, I didn't realise this until later. I will include that solution first, however, as I think it is probably the easier of the two. Although, the latter solution acts as a more agile function that can be altered to fit a variety of situations beyond inserting `NA` values for particular strings.
