
<!-- README.md is generated from README.Rmd. Please edit that file -->

# `{odestitch}`

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/mawds/odestitch/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/mawds/odestitch/actions/workflows/R-CMD-check.yaml)

<!-- badges: end -->

This is a small Shiny app, built using
[Golem](https://thinkr-open.github.io/golem/), that plots interesting
ODEs (at present only the [Lorentz
System](https://en.wikipedia.org/wiki/Lorenz_system) is supported).

A 2d projection of the solution can then be exported to SVG The
resulting SVG file can be imported into
[Inkscape](https://inkscape.org/) where the [Inkstitch
plugin](https://inkstitch.org/) can be used to output a file suitable
for machine embroidery, where each stitch represents a time-step from
the ODE solver.

## Installation

You can install the package by cloning the repo and, from the project
directory running:

``` r
devtools::install()
```

## Run

You can launch the application locally if you have installed it by
running:

``` r
odestitch::run_app()
```

Or by running `dev/run_dev.R`

Or (probably easiest) run it from
<https://mawdsl.shinyapps.io/odestitch/>

## Deployment

To deploy to shinyapps.io

``` r
options(rsconnect.packrat = TRUE)
rsconnect::deployApp()
```

(see <https://github.com/ThinkR-open/golem/issues/1070>) for why we need
to use packrat

### Inkstitch

Having generated an svg file the following briefly explains how to
convert this to a suitable format for embroidery using Inkstitch:

- Load the exported SVG file into Inkscape (with the Inkstitch extension
  installed)
- Select the resulting curve
- Choose Extensions -\> Ink/Stitch -\> Params
- Set method to “Manual stitch” - each time-step will then be a single
  stitch
- (You may wish to set maximum stitch length if some time-steps result
  in large jumps)
- You can then save the file in the appropriate format for your machine.

#### Troubleshooting

If you’re running Linux, and find Inkstitch’s dialogue boxes don’t
appear, restart Inkscape with:

``` bash
export GDK_BACKEND=x11 && inkscape
```

[This is because Inkstitch doesn’t work properly with
Wayland](https://inkstitch.org/docs/install-linux/#some-inkstitch-dialogs-disappear-after-a-few-seconds-or-dont-show-up-at-all)

## About

You are reading the doc about version : 0.0.0.9000

This README has been compiled on the

``` r
Sys.time()
#> [1] "2024-11-11 16:01:33 GMT"
```

Here are the tests results and package coverage:

``` r
devtools::check(quiet = TRUE)
#> ℹ Loading odestitch
#> ── R CMD check results ─────────────────────────────── odestitch 0.0.0.9000 ────
#> Duration: 33.1s
#> 
#> ❯ checking for future file timestamps ... NOTE
#>   unable to verify current time
#> 
#> ❯ checking dependencies in R code ... NOTE
#>   Namespace in Imports field not imported from: ‘svglite’
#>     All declared Imports should be used.
#> 
#> ❯ checking R code for possible problems ... NOTE
#>   mod_stitchgraph_server : <anonymous>: no visible binding for global
#>     variable ‘x’
#>   mod_stitchgraph_server : <anonymous>: no visible binding for global
#>     variable ‘y’
#>   solve_lorentz: no visible global function definition for ‘runif’
#>   Undefined global functions or variables:
#>     runif x y
#>   Consider adding
#>     importFrom("stats", "runif")
#>   to your NAMESPACE file.
#> 
#> 0 errors ✔ | 0 warnings ✔ | 3 notes ✖
```

``` r
covr::package_coverage()
#> odestitch Coverage: 89.58%
#> R/run_app.R: 0.00%
#> R/mod_stitchgraph.R: 56.10%
#> R/mod_lorentz.R: 90.48%
#> R/mod_resultgraph.R: 95.45%
#> R/app_config.R: 100.00%
#> R/app_server.R: 100.00%
#> R/app_ui.R: 100.00%
#> R/fct_every_nth.R: 100.00%
#> R/fct_solve_lorentz.R: 100.00%
#> R/golem_utils_server.R: 100.00%
#> R/golem_utils_ui.R: 100.00%
```
