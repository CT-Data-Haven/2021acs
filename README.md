
<!-- README.md is generated from README.Rmd. Please edit that file -->

# 2021 ACS update + community profiles

Distribution-ready files are in [`to_distro`](to_distro). CSV file for
populating website’s community profiles is in [`website`](website).

## Output

                                                levelName
    1  .                                                 
    2   ¦--fetch_data                                    
    3   ¦   °--acs_basic_2021_fetch_all.rds              
    4   ¦--output_data                                   
    5   ¦   ¦--acs_nhoods_by_city_2021.rds               
    6   ¦   ¦--acs_town_basic_profile_2021.csv           
    7   ¦   ¦--acs_town_basic_profile_2021.rds           
    8   ¦   °--cws_basic_indicators_2021.rds             
    9   ¦--to_distro                                     
    10  ¦   ¦--bridgeport_acs_basic_neighborhood_2021.csv
    11  ¦   ¦--hartford_acs_basic_neighborhood_2021.csv  
    12  ¦   ¦--new_haven_acs_basic_neighborhood_2021.csv 
    13  ¦   ¦--stamford_acs_basic_neighborhood_2021.csv  
    14  ¦   °--town_acs_basic_distro_2021.csv            
    15  °--website                                       
    16      °--5year2021town_profile_expanded_CWS.csv    

## Development

Several global functions and other objects are loaded when each script
sources `utils/pkgs_utils.R`, including all loaded libraries. There are
two global variables for years: `yr` and `cws_yr`, for the ACS endyear
and the CWS year, respectively. Those are both taken as positional
arguments by `pkgs_utils.R` and passed down to whatever script you want
to run.

For example, on the command line run:

``` bash
Rscript scripts/03_calc_acs_towns.R 2021 2021
```

to execute that script for ACS year 2021 & CWS year 2021. Similarly,
those 2 variables are saved in the makefile and passed to scripts from
there.

To build the full project in the proper order, on the command line run:

``` bash
make
# or make all
```

or rebuild just once piece of it, e.g. `make distro_nhood`.

You can supply the years to `make`; calling `make testvars` will verify
what years are being used by sourcing just `utils/pkgs_utils.R`.

<figure>
<img src="make.png" alt="makefile" />
<figcaption aria-hidden="true">makefile</figcaption>
</figure>
