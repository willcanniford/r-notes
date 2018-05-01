Missing values
================
Will Canniford

-   [Reasons for missing data](#reasons-for-missing-data)
-   [Visualising missing values](#visualising-missing-values)

These are notes that I have put together that I made while completing the *cleaning week challenge in R*, on Kaggle. The actual kernel includes use cases with datasets, that I haven't included here; this is a more general document.

``` r
library(tidyverse) 
library(mice) # package for categorical & numeric imputation
```

Reasons for missing data
------------------------

The first thing to consider when you're looking at missing data is why that data is missing? Does it make sense that this particular data might have missing values simply because they aren't applicable. Some missing values can be left as they indicate valid reasons as to why that those particular values are missing.

For example, a second telephone number, or middle name field when you are looking at personal data. This could be nothing to do with bad recording of data. The person might only have a single phone, or not have a middle name. It would be different if the date of birth was missing. That date of birth value would be said to be **missing at random**.

There is no statistical way to determine whether a missing value is 'at random' or not. Rachel from Kaggle suggested [this paper](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4121561/). Another resources is [this kernel](https://www.kaggle.com/rtatman/data-cleaning-challenge-handling-missing-values) which is written by Rachel from Kaggle as well.

Visualising missing values
--------------------------

Visualising is a quick way to see how much data is generally missing without having to trawl through the data row by row looking for `NA` values.

We can manipulate the data into a nicer format ready for plotting:

``` r
# create a data frame with information on whether the value in each cell is missing
missing_by_column <- data %>% 
    is.na %>% # check if each cell is na
    as_data_frame %>% # convert to data-frame
    mutate(row_number = 1:nrow(.)) %>% # add a column with the row number
    gather(variable, is_missing, -row_number) # turn wide data into long data 
```

And then plot that to visually see the missing values from the data frame:

``` r
# Plot the missing values in our data frame, with a good-looking theme
ggplot(missing_by_column, aes(x = variable, y = row_number, fill = is_missing)) +
    geom_tile() + 
    theme_minimal() +
    scale_fill_grey(name = "",
                    labels = c("Present","Missing")) +
    theme(axis.text.x  = element_text(angle=45, vjust=0.5, size = 8)) + 
    labs(x = "Variables in Dataset",
         y = "Rows / observations")
```

The benefit of a chart like this is that you can read it like your data frame with columns acting like columns and rows like rows. Each cell of the graph represents a cell in the data frame.

Other ways to visualise missing data are outlined [here](https://cran.r-project.org/web/packages/naniar/vignettes/naniar-visualisation.html).
