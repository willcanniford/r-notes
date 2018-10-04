Logistic Regression
================

-   [Creating test and training sets refresher](#creating-test-and-training-sets-refresher)
-   [Plotting regressions](#plotting-regressions)

Logistic regression is one of the more common predicitive analyses and is the classification counterpart to linear regression. It is usually used to describe the relationship between a binary response/dependent variable and any number of predictor/independent variables. Some assumptions of the logisitic regression should be that there should be no outliers in the data, the response variable must be binary, or dichotomous, and multicollinearity should be avoided (as with linear regressions). The fact that you are predicting a qualitative target variable means that this is a classification problem, but remains supervised learning. Predictions are mapped between 0 and 1 through the logit function that is applied, so the predictions can be interpreted as class probabilities.

Typically, a logistic regression can be created in R using the following functions:

``` r
mode <- glm(formula, data, family = binomial)
predictions <- predict(model, data, type = 'response')
```

Above we are using the function `glm()` which, by itself, isn't for logistic regression, but when you specify that `family = binomial` then the result is a logisitic regression model. Something that you might want to consider when using logistic regression to *one-hot encode* your categorical variables so that they have a boolean equivalent. One way of doing this is through using the `vtreat` package: I will over this at a different stage.

It is still good practice to create testing and training sets to avoid overfitting in the model performance metrics. This can be done with any type of model by varying the testing and training sets during the creation of the model.

#### Creating test and training sets refresher

Depending on the size of your data, the percentage split will differ. The less data you have then you might have to put aside more of the data so that the test set is substantial enough to give a clear indication of the out-of-sample metrics. ***Cross-validation*** can also achieve this through creating multiple models and performing multiple out-of-sample assessments and then averaging them together.

``` r
# Create random indices
rows <- sample(nrow(data))
# Reorder the data to avoid order bias
data <- data [rows,]

# Split the data
split <- round(nrow(data) * 0.8)
train <- data[1:split, ]
test <- data[(split+1):nrow(data), ]
```

Plotting regressions
--------------------

``` r
ggplot(dataset, aes(x = predictor_variable, y = binomial_variable)) +
    geom_point() + 
    geom_smooth(method = "glm", method.args = list(family = "binomial")) 
```

You can alter this depending on the sort of variable that you are trying to predict. You will change the family argument of the glm model so that the model that is built is appropriate for the type of regression analysis that you are doing.

`binomial` is appropriate for logistic regression.
`gaussian` for linear regression.
`poisson` for poisson when the response variable is a count. `quasipoisson` should be used when the response variable doesn't meet the assumptions of the poisson distribution.
