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

Cleaning data as you load it
----------------------------

I have created a csv that contains some of the issues that I was having, but obviously on a much smaller scale. The csv file can be found in the data folder within this directory if you're interested.

``` r
data <- read_csv('data/clean_me.csv')
glimpse(data)
```

    ## Observations: 2
    ## Variables: 7
    ## $ id             <int> 1, 2
    ## $ name           <chr> "Will", "Rob"
    ## $ email          <chr> "will@test.com", "rob@email.com"
    ## $ password       <chr> NA, NA
    ## $ remember_token <chr> "NULL", "1245"
    ## $ created_at     <chr> "18/08/2017 10:53", "20/08/2017 15:32"
    ## $ updated_at     <chr> "18/08/2017 10:53", "NULL"

One of the password fields was simply a blank text `''` while the other was the string "NA". They have both successfully been parsed as NA.

However, looking at the remember\_token and updated\_at you can see that some "NULL" strings remain. These ideally would have been parsed as NA as well so that the dataset has a consistent method of identifying missing values.

You can do this through expanding an argument in `read_csv` called `na`. `na` takes a character vector of strings to use for missing values. The default value that this takes is `c('', 'NA')`. This means that it automatically changes empty strings as well as those indicated by the string "NA".

This means that it is simple for use to set the string "NULL" to be read as a missing value.

``` r
clean_data <- read_csv('data/clean_me.csv', na = c('NA', '', 'NULL'))
glimpse(clean_data)
```

    ## Observations: 2
    ## Variables: 7
    ## $ id             <int> 1, 2
    ## $ name           <chr> "Will", "Rob"
    ## $ email          <chr> "will@test.com", "rob@email.com"
    ## $ password       <chr> NA, NA
    ## $ remember_token <int> NA, 1245
    ## $ created_at     <chr> "18/08/2017 10:53", "20/08/2017 15:32"
    ## $ updated_at     <chr> "18/08/2017 10:53", NA

As you can now see we have alleviated the issue that we had by reading the data back in and altering the default character string of the `na` argument to include the string "NULL".
