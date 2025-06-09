<!-- README.md is generated from README.Rmd. Please edit that file -->
# deltactrl
<!-- badges: start -->
<!-- badges: end -->

This package is designed to easily calculate the responsiveness (%) of each treatment relative to a control

□ Code summary:

□ Code explained: https://agronomy4future.com/archives/24266

## Installation

You can install the development version of interpolate like so:

Before installing, please download Rtools (https://cran.r-project.org/bin/windows/Rtools)

``` r
if(!require(remotes)) install.packages("remotes")
if (!requireNamespace("deltactrl", quietly = TRUE)) {
remotes::install_github("agronomy4future/deltactrl", force= TRUE)
}
library(remotes)
library(deltactrl)
```

## Example

This is a basic code to calculate responsiveness (%) per groups

``` r
df1= descriptivestat(data=df, group_vars= c("tr1", "tr2"),
                     value_vars= c("y"),
                     output_stats= c("v","sd","se","ci","cv","iqr"))
print(df1)
```

## Let’s practice with actual dataset

``` r
# data upload 
if(!require(remotes)) install.packages("readr")
library(readr)

github="https://raw.githubusercontent.com/agronomy4future/raw_data_practice/main/fertilizer_treatment.csv"
df= data.frame(read_csv(url(github),show_col_types = FALSE))

head(df,5)
    Genotype Block variable value
1 Genotype_A     I  Control  42.9
2 Genotype_A    II  Control  41.6
3 Genotype_A   III  Control  28.9
4 Genotype_A    IV  Control  30.8
5 Genotype_B     I  Control  53.3
.
.
.

tail(df,5)
     Genotype Block    variable value
60 Genotype_C    IV Fertilizer3  51.8
61 Genotype_D     I Fertilizer3  71.6
62 Genotype_D    II Fertilizer3  69.4
63 Genotype_D   III Fertilizer3  56.6
64 Genotype_D    IV Fertilizer3  47.4

df2= deltactrl(
  data= df,
  group_vars= c("Genotype"),
  treatment_var= variable,
  control_label= Control,
  response_vars= c("value")
)

print(df2, n = Inf)
   Genotype   Block variable    value responsive_value
 1 Genotype_A I     Control      42.9          NA     
 2 Genotype_A II    Control      41.6          NA     
 3 Genotype_A III   Control      28.9          NA     
 4 Genotype_A IV    Control      30.8          NA     
 5 Genotype_B I     Control      53.3          NA     
 6 Genotype_B II    Control      69.6          NA     
 7 Genotype_B III   Control      45.4          NA     
 8 Genotype_B IV    Control      35.1          NA     
 9 Genotype_C I     Control      62.3          NA     
10 Genotype_C II    Control      58.5          NA     
11 Genotype_C III   Control      44.6          NA     
12 Genotype_C IV    Control      50.3          NA     
13 Genotype_D I     Control      75.4          NA     
14 Genotype_D II    Control      65.6          NA     
15 Genotype_D III   Control      54            NA     
16 Genotype_D IV    Control      52.7          NA     
17 Genotype_A I     Fertilizer1  53.8           0.492 
18 Genotype_A II    Fertilizer1  58.5           0.623 
19 Genotype_A III   Fertilizer1  43.9           0.218 
20 Genotype_A IV    Fertilizer1  46.3           0.284 
21 Genotype_B I     Fertilizer1  57.6           0.133 
22 Genotype_B II    Fertilizer1  69.6           0.369 
23 Genotype_B III   Fertilizer1  42.4          -0.166 
24 Genotype_B IV    Fertilizer1  51.9           0.0206
25 Genotype_C I     Fertilizer1  63.4           0.176 
26 Genotype_C II    Fertilizer1  50.4          -0.0654
27 Genotype_C III   Fertilizer1  45            -0.166 
28 Genotype_C IV    Fertilizer1  46.7          -0.134 
29 Genotype_D I     Fertilizer1  70.3           0.135 
30 Genotype_D II    Fertilizer1  67.3           0.0868
31 Genotype_D III   Fertilizer1  57.6          -0.0698
32 Genotype_D IV    Fertilizer1  58.5          -0.0553
33 Genotype_A I     Fertilizer2  49.5           0.373 
34 Genotype_A II    Fertilizer2  53.8           0.492 
35 Genotype_A III   Fertilizer2  40.7           0.129 
36 Genotype_A IV    Fertilizer2  39.4           0.0929
37 Genotype_B I     Fertilizer2  59.8           0.176 
38 Genotype_B II    Fertilizer2  65.8           0.294 
39 Genotype_B III   Fertilizer2  41.4          -0.186 
40 Genotype_B IV    Fertilizer2  45.4          -0.107 
41 Genotype_C I     Fertilizer2  64.5           0.196 
42 Genotype_C II    Fertilizer2  46.1          -0.145 
43 Genotype_C III   Fertilizer2  62.6           0.161 
44 Genotype_C IV    Fertilizer2  50.3          -0.0672
45 Genotype_D I     Fertilizer2  68.8           0.111 
46 Genotype_D II    Fertilizer2  65.3           0.0545
47 Genotype_D III   Fertilizer2  45.6          -0.264 
48 Genotype_D IV    Fertilizer2  51            -0.176 
49 Genotype_A I     Fertilizer3  44.4           0.232 
50 Genotype_A II    Fertilizer3  41.8           0.160 
51 Genotype_A III   Fertilizer3  28.3          -0.215 
52 Genotype_A IV    Fertilizer3  34.7          -0.0374
53 Genotype_B I     Fertilizer3  64.1           0.261 
54 Genotype_B II    Fertilizer3  57.4           0.129 
55 Genotype_B III   Fertilizer3  44.1          -0.133 
56 Genotype_B IV    Fertilizer3  51.6           0.0147
57 Genotype_C I     Fertilizer3  63.6           0.179 
58 Genotype_C II    Fertilizer3  56.1           0.0403
59 Genotype_C III   Fertilizer3  52.7          -0.0227
60 Genotype_C IV    Fertilizer3  51.8          -0.0394
61 Genotype_D I     Fertilizer3  71.6           0.156 
62 Genotype_D II    Fertilizer3  69.4           0.121 
63 Genotype_D III   Fertilizer3  56.6          -0.0860
64 Genotype_D IV    Fertilizer3  47.4          -0.235 
