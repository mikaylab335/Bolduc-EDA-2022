
# Correlation Between COVID Cases and Vaccination Status Among Different Age Groups in the U.S.

Mikayla Bolduc<sup>1</sup>

Minnesota State University Moorhead Biosciences Department<sup>1</sup>

## Abstract

-   COVID cases have increased among all age groups from December of
    2021 going into March of 2022.
-   COVID vaccine rates have increased among all age groups and continue
    to.
-   
-   

## Introduction

COVID-19 vaccinations in the U.S. first became available to select
populations, such as the elderly and immunocompromised, back in June
2020, right after COVID-19 was declared a pandemic in March. Fast
forward to present day where vaccinations are available to everyone,
along with the development of a booster shot. However, since then,
vaccines have become a very controversial topic.

The COVID-19 vaccines were the fastest vaccines to get approved for use.
This has led to many people wondering, how effective are these vaccines?

In this project, we will be doing an exploratory data analysis on the
relationship between the number of COVID-19 cases and the number of
people vaccinated. This will help to show the effectiveness of the
vaccine.

We will be using data from COVID Data Tracker, which is a website
managed by the CDC, to look for relationships between positive COVID-19
cases and vaccination status among different age groups. We will be
looking at the whole population of the U.S. to get more accurate
information on the effectiveness of the COVID-19 vaccine. If the vaccine
is effective, we should see that as the number of vaccinated people goes
up, the amount of COVID-19 cases will go down.

## Methods

### Data Acquisition

COVID data: Cases

1.  Go to
    <https://www.tn.gov/health/cedep/ncov/data/downloadable-datasets.html>
2.  Scroll to the “Daily Age Group Outcomes” download and click
3.  Click on “Show in folder”
4.  Copy data set
5.  Paste in data folder (Public_Dataset_Age_1\_)

COVID data: Vaccination Status

1.  Go to
    <https://data.cdc.gov/Vaccinations/COVID-19-Vaccination-Demographics-in-the-United-St/km4m-vcsb>
2.  Scroll to “View Data”
3.  Click on the Export Tab
4.  Click on CSV
5.  Save to data folder
    (COVID_19_Vaccination_Demographics_in_the_United_States_National_1\_.csv)

-   Print both data sets into an Rscript in R
-   Filter data set to get the variables that are needed for this
    project
-   Graph the data sets

## Results

![](Bolduc_files/figure-gfm/unnamed-chunk-1-1.png)<!-- -->

## Discussion

We were unable to run a statistical test on this data due to the age
groups being different between the different data sets that we used.

## References

Wickham et al., (2019). Welcome to the tidyverse. Journal of Open Source
Software, 4(43), 1686, <https://doi.org/10.21105/joss.01686>

## Acknowledgements

We would like to give a big thanks to Dr. Chris Merkord and Shelby
Pankratz for assisting me with this project, and everyone else who was
indirectly involved.