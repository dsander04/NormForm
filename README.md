# NormForm

## Overview

`NormForm` is an R package for identifying candidate keys and evaluating whether a dataset satisfies first, second, and third normal forms.

It helps users quickly assess data structure, improve organization, and prepare datasets for relational analysis.

------------------------------------------------------------------------

## Installation

You can install the development version from GitHub:

``` r
install.packages("remotes")
remotes::install_github("dsander04/NormForm")
```

------------------------------------------------------------------------

## Example

``` r
library(NormForm)

# Example dataset included in the package
data(college)

# Find candidate keys
find_keys(college, max_size = 2)

# Check if a column is a key
is_key(college, "unitid")

# Evaluate normal forms
first_normal(college)
second_normal(college)
third_normal(college)
```

------------------------------------------------------------------------

## Key Features

- Identify whether a column or set of columns forms a key
- Automatically search for minimal keys
- Test for first, second, and third normal form

------------------------------------------------------------------------

## Documentation

For a full introduction, see the vignette:

``` r
vignette("getting-started", package = "NormForm")
```

Or visit the website: <https://dsander04.github.io/NormForm/>

------------------------------------------------------------------------

## Contributing

Contributions, issues, and feature requests are welcome.
