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

    ## Observations: 3
    ## Variables: 7
    ## $ id                 <int> 1, 2, 3
    ## $ firstname          <chr> "Will", "Rob", "Jane"
    ## $ surname            <chr> "Canniford", NA, NA
    ## $ email              <chr> "will@test.com", "rob@email.com", "jane@dom...
    ## $ current_profession <chr> "Web developer", "NULL", "Software Engineer"
    ## $ created_at         <chr> "18/08/2017 10:53", "20/08/2017 15:32", "20...
    ## $ updated_at         <chr> "18/08/2017 10:53", "NULL", NA

One of the password fields was simply a blank text `''` while the other was the string "NA". They have both successfully been parsed as NA.

However, looking at the current\_profession and updated\_at you can see that some "NULL" strings remain. These ideally would have been parsed as NA as well so that the dataset has a consistent method of identifying missing values.

You can do this through expanding an argument in `read_csv` called `na`. `na` takes a character vector of strings to use for missing values. The default value that this takes is `c('', 'NA')`. This means that it automatically changes empty strings as well as those indicated by the string "NA".

This means that it is simple for use to set the string "NULL" to be read as a missing value.

``` r
clean_data <- read_csv('data/clean_me.csv', na = c('NA', '', 'NULL'))
glimpse(clean_data)
```

    ## Observations: 3
    ## Variables: 7
    ## $ id                 <int> 1, 2, 3
    ## $ firstname          <chr> "Will", "Rob", "Jane"
    ## $ surname            <chr> "Canniford", NA, NA
    ## $ email              <chr> "will@test.com", "rob@email.com", "jane@dom...
    ## $ current_profession <chr> "Web developer", NA, "Software Engineer"
    ## $ created_at         <chr> "18/08/2017 10:53", "20/08/2017 15:32", "20...
    ## $ updated_at         <chr> "18/08/2017 10:53", NA, NA

As you can now see we have alleviated the issue that we had by reading the data back in and altering the default character string of the `na` argument to include the string "NULL".

As I said previously, I actually found out this solution having already written a function that dealt with the messy data after reading it in without specifying the "NULL" string in the `na` of the `read_csv`.

### Function using purrr and map

``` r
string_to_na <- function(df, string = "NULL") {
  df[, map_lgl(df, is.character)] <- map_df(df[, map_lgl(df, is.character)], ~ gsub(paste('^', string, '$', sep = ''), '', .)) %>% map_df(~ ifelse(. == '', NA, .))
}
```

Here the function leverages the map functions from the `purrr` package, as well as pipes from the `magrittr` package.

If we break it down then the function firstly says that it is only going to tackle those columns of the data frame that are characters.
It then uses `gsub` to change all exact matches of the given string using `paste`, creating a regular expression to avoid altering strings with a partial match,instead targetting just exact matches. It then replaces those matches with a blank string.
The resulting data frame (maintained using `map_df`) is piped into another `map_df` call that then loops through the cells again and replaces all blank cells with `NA`, else it keeps them as they were. Here is a reminder of how the data looks when you don't alter the `na` argument when reading in the csv file.

``` r
glimpse(data)
```

    ## Observations: 3
    ## Variables: 7
    ## $ id                 <int> 1, 2, 3
    ## $ firstname          <chr> "Will", "Rob", "Jane"
    ## $ surname            <chr> "Canniford", NA, NA
    ## $ email              <chr> "will@test.com", "rob@email.com", "jane@dom...
    ## $ current_profession <chr> "Web developer", "NULL", "Software Engineer"
    ## $ created_at         <chr> "18/08/2017 10:53", "20/08/2017 15:32", "20...
    ## $ updated_at         <chr> "18/08/2017 10:53", "NULL", NA

Then I can apply the function to remove those instances of the string "NULL".

``` r
glimpse(string_to_na(data))
```

    ## Observations: 3
    ## Variables: 6
    ## $ firstname          <chr> "Will", "Rob", "Jane"
    ## $ surname            <chr> "Canniford", NA, NA
    ## $ email              <chr> "will@test.com", "rob@email.com", "jane@dom...
    ## $ current_profession <chr> "Web developer", NA, "Software Engineer"
    ## $ created_at         <chr> "18/08/2017 10:53", "20/08/2017 15:32", "20...
    ## $ updated_at         <chr> "18/08/2017 10:53", NA, NA

With the function that I have written, it is possible to change the string that you are turning into missing values. For example, if I have something particularly against Rob then I could replace all occurrences of Rob with `NA` instead...

``` r
glimpse(string_to_na(df = data, string = "Rob"))
```

    ## Observations: 3
    ## Variables: 6
    ## $ firstname          <chr> "Will", NA, "Jane"
    ## $ surname            <chr> "Canniford", NA, NA
    ## $ email              <chr> "will@test.com", "rob@email.com", "jane@dom...
    ## $ current_profession <chr> "Web developer", "NULL", "Software Engineer"
    ## $ created_at         <chr> "18/08/2017 10:53", "20/08/2017 15:32", "20...
    ## $ updated_at         <chr> "18/08/2017 10:53", "NULL", NA

This gives this function some control to work with data frames after they have been loaded, but could also be adapted and improved to work within longer piped analysis as it both accepts and returns a data frame. This is particularly useful when working with the `tidyverse` and `dplyr` packages while analysing data. For example:

``` r
data %>% 
  head(n = 2) %>% 
  string_to_na(string = "will@test.com") %>% 
  filter(firstname == "Will") %>% 
  print()
```

    ## # A tibble: 1 x 6
    ##   firstname   surname email current_profession       created_at
    ##       <chr>     <chr> <chr>              <chr>            <chr>
    ## 1      Will Canniford  <NA>      Web developer 18/08/2017 10:53
    ## # ... with 1 more variables: updated_at <chr>

I would like to make some more improvements to the function, namely adding the ability to dictate the type of match that you are trying to replace, as well as adding the replacement item to create a function that is much more flexible for replacing values but is still able to be used in pipelines with `dplyr`.
