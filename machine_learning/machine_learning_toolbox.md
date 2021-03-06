Machine Learning Toolbox
================

-   [RMSE and evaluating performance](#rmse-and-evaluating-performance)
-   [Out-of-sample error measures](#out-of-sample-error-measures)
    -   [Creating your training and test sets](#creating-your-training-and-test-sets)
-   [Cross-validation](#cross-validation)
    -   [Cross-validation example](#cross-validation-example)
    -   [Multiple cross-validations](#multiple-cross-validations)

This is just a collection of notes and examples from the associated DataCamp course of the same name. The goal of these notes is to try and compile what I know about the various algorithms into a centralised place for references, as well as solidify that knowledge.
This course is mainly based around the use of the `caret` package in R.

RMSE and evaluating performance
-------------------------------

The root mean squared error, or RMSE, is a common measure of how well a model fits the data. It is commonly caluculated in-sample on your training set, but this isn't ideal as it can lead ot misleading results due to overfitting. This is where your model has been trained on the same data for which it is later evaluated. It way have learnt particular patterns only found in the training examples, and not generalise well when tested on further 'new' data.

It can be calculated easily in R:

``` r
predictions <- predict(model, data, type='response')
residuals <- predictions - data$response_variable
rmse <- sqrt(mean(residuals ^ 2))
```

RMSE is an indication of the model's average error, and is a metric that is has the same units as the response variable. This makes it intuitive to understand and communicate.

Out-of-sample error measures
----------------------------

If the aim of a model is predictive power, rather than data insight. Then your primary concern should be about the model's ability to perform on *new* data.
Therefore, it is good practice, and makes sense, to test the models on new data that wasn't used when the model was trained. This is where your regular training test split will come in. Depending on the amount of data that you have available, you will either do something like a *70/30* split or apply cross validation to estimate a model's performance.

**Error metrics should be calculated on new data as in-sample validation essentially guarantees overfitting.**

Out-of-sample validation helps you to identify models that are capable of dealing with new data effectively, and are likely to perform well in the future.

The `caret` package provides a couple of functions that allow for the creation of training and test sets: `createResamples()` and `createFolds()`.

### Creating your training and test sets

Firstly you can order the full dataset randomly, prior to the divide. Hopefully this means that you have succesfully removed any biases that may be present in the dataset as a result of order.

You can use `sample` to achieve this as it mixes the indices of a dataset that can later be used to subset the original data.

``` r
rows <- sample(nrow(data))
data <- data[rows,]
```

The data would now be mixed thanks to the shuffling of the indices with `sample`. Of a dataset of 10 values, for example, sample would produce the following output:

``` r
sample(10)
```

    ##  [1]  7  6  2  8  5  4  9  3 10  1

When this is applied to a dataset it has the effect or reordering the rows. Once the data has successfully been randomly reordered, you can split without having to worry about any predefined bias that may have been present due to collection of previous analysis/arrangement.

#### Creating a genuine split: 80/20

``` r
split = round(nrow(data) * .8)
train <- data[1:split, ]
test <- data[(split+1):nrow(data), ]
```

Cross-validation
----------------

Simply splitting the data once is still risky, even though we previously accounted for order preference that may change our results. A single outlier can vastly change the RMSE value that we get from an out-of-sample test.

One of the most common methods for multiple test sets is cross-validation. It is only use to estimate the out-of-sample error for your model, if all the outputs from cross-validation give similar results then you can be more certain about your model's capability to cope with unseen data. Once you have carried out the cross-validation, you re train your model using the full dataset so that you can make the most of all the information that you have available to you.

To make reducible results you have to use `set.seed()` as cross-validation with `caret` uses random sampling. Cross-validation using this package is done with the `caret::train()` function that supports lots of different kinds of models allows the control over the validation section of the model.

### Cross-validation example

``` r
data(mtcars)
model <- train(
  mpg ~ ., mtcars, 
  method = 'lm',
  trControl = trainControl(
    method = "cv", number = 5,
    verboseIter = TRUE
  )
)
```

    ## + Fold1: intercept=TRUE 
    ## - Fold1: intercept=TRUE 
    ## + Fold2: intercept=TRUE 
    ## - Fold2: intercept=TRUE 
    ## + Fold3: intercept=TRUE 
    ## - Fold3: intercept=TRUE 
    ## + Fold4: intercept=TRUE 
    ## - Fold4: intercept=TRUE 
    ## + Fold5: intercept=TRUE 
    ## - Fold5: intercept=TRUE 
    ## Aggregating results
    ## Fitting final model on full training set

``` r
print(model)
```

    ## Linear Regression 
    ## 
    ## 32 samples
    ## 10 predictors
    ## 
    ## No pre-processing
    ## Resampling: Cross-Validated (5 fold) 
    ## Summary of sample sizes: 26, 27, 26, 25, 24 
    ## Resampling results:
    ## 
    ##   RMSE      Rsquared   MAE     
    ##   3.692748  0.7484661  2.980641
    ## 
    ## Tuning parameter 'intercept' was held constant at a value of TRUE

Setting `verboseIter` within the call to `trainControl()` means that each iteration of the model validation is shown on the screen so that you have a better idea of how long the model will take to train.

### Multiple cross-validations

You can do more than a single iteration of cross-validation. While this obviously increases the run time of the model creation, it will further give you a better indication of the model's performance on unseen data. With `caret::train()` this is easily specified using the `repeats` arugment within the function.

Once you have created your model, you can simply use the `predict()` function with the arguments `model` and `newdata`.
