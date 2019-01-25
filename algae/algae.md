Growth Rates of Algae
================

``` r
library(ggplot2)
library(ggthemr)
library(dplyr)
```

Read the dataset and convert the temperature and light intensity (lux) columns to factors.

``` r
algae <- read.csv("/algae/algae.csv", sep=";")
algae$temp <- as.factor(algae$temp)
algae$lux <- as.factor(algae$lux)
```

Exploring the dataset
---------------------

The dataset is available at <http://www.aquatext.com/tables/algaegrwth.htm>. It contains specific growth rates of algae measured in divisions per day at different light intensities and temperatures.

``` r
str(algae)
```

    ## 'data.frame':    152 obs. of  4 variables:
    ##  $ species: Factor w/ 19 levels "Caloneis schroderi",..: 1 2 3 4 5 6 8 7 9 11 ...
    ##  $ temp   : Factor w/ 4 levels "5","10","25",..: 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ lux    : Factor w/ 2 levels "2500","5000": 2 2 2 2 2 2 2 2 2 2 ...
    ##  $ value  : num  -0.01 -0.01 -0.06 0.03 0.01 -0.25 0.28 0.16 -0.36 -0.57 ...

There are nineteen species of algae, each measured at four different temperatures (5, 10, 25, 30 °C) and two different light intensities (2500 and 5000 lux). The names of the nineteen species are

``` r
levels(algae$species)
```

    ##  [1] "Caloneis schroderi"              "Chaetoceros gracilis"           
    ##  [3] "Chaetoceros simplex"             "Chlorella ellipsoidea"          
    ##  [5] "Chlorella stigmatophora"         "Chlorella vulgaris (freshwater)"
    ##  [7] "Cyclotella sp. NUFP-9"           "Dunaniella tertiolecta"         
    ##  [9] "Hanzchia marina"                 "Isochrysis aff. galbana"        
    ## [11] "Isochrysis galbana"              "Nannochloris salina"            
    ## [13] "Nannochlorois oculata"           "Navicula incerta"               
    ## [15] "Nitzscia sp."                    "Skeletonema costatum"           
    ## [17] "Tetraselmus suecica"             "Thalassiosira fluviatilis"      
    ## [19] "Thalassiosira sp."

A summary of the growth rates by species:

``` r
algae %>% group_by(species) %>% summarise(
  mean = mean(value),
  sd = sd(value),
  min = min(value),
  max = max(value)
  )
```

    ## # A tibble: 19 x 5
    ##    species                            mean    sd    min   max
    ##    <fct>                             <dbl> <dbl>  <dbl> <dbl>
    ##  1 Caloneis schroderi               0.111  0.298 -0.5    0.38
    ##  2 Chaetoceros gracilis             0.304  0.301 -0.05   0.73
    ##  3 Chaetoceros simplex              0.364  0.267 -0.06   0.63
    ##  4 Chlorella ellipsoidea            0.601  0.391  0.02   0.98
    ##  5 Chlorella stigmatophora          0.405  0.251  0.01   0.78
    ##  6 Chlorella vulgaris (freshwater)  0.124  0.387 -0.290  0.68
    ##  7 Cyclotella sp. NUFP-9           -0.0288 0.122 -0.19   0.16
    ##  8 Dunaniella tertiolecta           0.449  0.165  0.17   0.64
    ##  9 Hanzchia marina                 -0.0988 0.304 -0.68   0.21
    ## 10 Isochrysis aff. galbana          0.215  0.641 -0.67   0.81
    ## 11 Isochrysis galbana               0.27   0.400 -0.570  0.55
    ## 12 Nannochloris salina              0.0713 0.315 -0.34   0.54
    ## 13 Nannochlorois oculata            0.504  0.538 -0.03   1.14
    ## 14 Navicula incerta                 0.318  0.111  0.16   0.48
    ## 15 Nitzscia sp.                     0.229  0.172 -0.1    0.46
    ## 16 Skeletonema costatum             0.51   0.147  0.290  0.67
    ## 17 Tetraselmus suecica              0.335  0.216 -0.02   0.55
    ## 18 Thalassiosira fluviatilis        0.11   0.101 -0.03   0.28
    ## 19 Thalassiosira sp.                0.0588 0.259 -0.290  0.41

Now plot the growth rates for each species, lux and temperature:

``` r
# set ggthemr "dust"
ggthemr("dust")

ggplot(algae, aes(x=temp, y=value, color=lux, group=lux)) +
  geom_point(size=2) +
  geom_line(size=1) + 
  facet_wrap( ~ species, nrow = 6) +
  labs(
    x = "Temperature (?C)", 
    y = "Divisions per day",
    color = "Light intensity (lux)") +
  ggtitle("Growth Rates of Algae") +
  theme(legend.position = "bottom", legend.direction = "horizontal")
```

![](algae_files/figure-markdown_github/unnamed-chunk-7-1.png)
