# Introduction

In 1974 *Motor Trend* a US magazine, performed road tests for 32 cars in the 1973-74 model year. They recorded 11 statistics about each model of car, the results are available on the data-set **mtcars** as part of R.

This application will help you estimate the expected change on MPG consumption of each of the 32 cars in the scenario that you alter the factory gross Horsepower or if the total Weight of the vehicle is changed by additional load that you might plan to carry on it.


Our MPG Predictor might prove useful to estimate your gasoline cost on your next family trip, giving you a quantitative argument to reduce the total luggage weight. 

### How to use the tool

To use this tool is as simple as 1,2,3...

1. *Vehicle selection*

   Identify your vehicle (or the closest one) in the left list, the selected item is shown as highlighted.

2. *Experiment*

   Using the sliders you can select a new value for the total Weight (lb/1000) of your vehicle or the adjusted HP after that ~~kick*$$~~ tune-up

   Is worth nothing that the default value of those sliders correspond to the actual factory values for your vehicle, so you can always reset your changes by selecting again your vehicle on the list.

3. *Results*

    The resulting prediction is available on the first tab of this panel; For convenience we have included the some of the observed metrics for your vehicle accouding to Motor Trend
    
    You can adjust the slider to new values or select a different vehicle and all values in the prediction step will update accordingly.
    

Have fun!

### Methodology

The prediction model is based on Gaussian linear regression, where _mpg_ is predicted based on the covariates _cyl + hp + wt + am_.

The relative low acuracy of this prediction can be noticed by leaving unchanged the default values on the slider and noting that prediction doesn't match the expected factory MPG value, regardless of this discrepancy you can be asured that estimated value is between a 95% confidence interval.

For the curious at heart, this is the table of coeficients for our model (mpg~cyl + hp + wt + am):
```r{}
              Estimate Std. Error   t value     Pr(>|t|)
(Intercept) 33.70832390 2.60488618 12.940421 7.733392e-13
cyl6        -3.03134449 1.40728351 -2.154040 4.068272e-02
cyl8        -2.16367532 2.28425172 -0.947214 3.522509e-01
hp          -0.03210943 0.01369257 -2.345025 2.693461e-02
wt          -2.49682942 0.88558779 -2.819404 9.081408e-03
ammanual     1.80921138 1.39630450  1.295714 2.064597e-01
```