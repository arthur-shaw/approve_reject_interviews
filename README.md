
<!-- README.md is generated from README.Rmd. Please edit that file -->

# approve\_reject\_interviews

<!-- badges: start -->
<!-- badges: end -->

## Installation

Before running this program for the first time, (re)install the
following software:

-   [R](#r)
-   [RTools](#rtools)
-   [RStudio](#rstudio)

Even if these software packages are already installed, it is necessary
to reinstall them in order to have the latest version of these tools for
this program to work successfully.

Please read below about how to install these programs.

### R

-   Follow this [link](https://cran.r-project.org/)
-   Click on the appropriate link for your operating system
-   Click on `base`
-   Download and install (e.g.,
    [this](https://cran.r-project.org/bin/windows/base/R-4.1.1-win.exe)
    for Windows)

### RTools

Required for the Windows operating system.

-   Follow this [link](https://cran.r-project.org/)
-   Click on `Windows`
-   Click on `RTools`
-   Download and install (e.g.,
    [this](https://cran.r-project.org/bin/windows/Rtools/rtools40v2-x86_64.exe)
    for a 64bit system)

This program allows R to compile C++ scripts used by certain packages
(e.g., `{dplyr}`).

### RStudio

-   Follow this [link](https://www.rstudio.com/products/rstudio/)
-   Select RStudio Desktop then Open Source Edition
-   Click on the appropriate link for your operating system
-   Download and install (e.g.,
    [this](https://www.rstudio.com/products/rstudio/download/#download)
    for Windows)

### This program

-   Get a copy of this repository
    -   Navigate to [this
        repository](https://github.com/arthur-shaw/uhis_auto_sort)
    -   Click on the `Code` button
    -   Click on `Download ZIP`
    -   Download to the desired folder on your machine
-   Unpack the zip file

## Usage

### Provide program paramters

This involves:

1.  Providing details for connecting to the Survey Solutions
2.  Specifying how the program should behave

#### Providing details for connecting to the Survey Solutions

In order for the program to interact with your server in any way–whether
that is downloading data or rejecting interviews–it needs connection
details.

These details are as follows:

-   `server`. Full URL or the server.
-   `workspace`. Workspace name–not the display name.
-   `user`. User name for an admin or API user authorized for the
    workspace above.
-   `password`. Password for that user.

``` r
# =============================================================================
# Provide user-specified parameters
# =============================================================================

# SuSo server details
server      <- ""   # Server name. 
workspace   <- ""   # Workspace name. Use the name that is an ID rather than the display name.
user        <- ""   # User name. Note: user must be either admin or API user.
password    <- ""   # Password of the user indicated above.

susoapi::set_credentials(
    server = server,
    workspace = workspace,
    user = user,
    password = password
)
```

For more information on why this information is needed and how it is
used, please read about Survey Solutions authentication
[here](https://arthur-shaw.github.io/susoapi/articles/authentication.html)

#### Specifying how the program should behave

The program needs to know how to act in two dimensions:

1.  Which Survey Solutions interview statuses to consider for review
2.  Whether the program should reject any reviews recommended for
    rejection

The `statuses_to_reject` variable captures the comma-separated list of
statuses subject to review. See the notes below on which interview
statuses are currently allowed.

The `statuses_to_approve` comma-separated list of statuses subject to
approve. See the notes below on which interview statuses are currently
allowed.

### Run the program

Once the preparation above completed and saved, it is time to run the
program. To do so:

-   Open RStudio
-   Open the file `approve_reject_interviews.Rproj`, which will have the
    effect of loading the project resources.
-   Open the file `run_approval_rejection.R`, which you modified above
-   Run the program
-   Accept to update packages, if prompted
