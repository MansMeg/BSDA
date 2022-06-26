Frequently asked questions
==========================

## How do I access the course material in Github?

Instead of trying to download each file separately via the Github interface, it is recommended to use one of these options:

 - The best way is to clone the repository using git, and use pull to get the latest updates.
   - If you want to learn to use git, start by installing a [git client](https://www.google.com/search?q=git+clients&oq=git+client). There are plenty of good git tutorials online.
 - If you don't want to learn to use git, download a the repository as a zip file. Click the green button "Code" at the main page of the repository and choose "Download ZIP" ([direct link](https://github.com/MansMeg/BSDA/archive/refs/heads/main.zip)). Remember to download again during the course to get the latest updates.


## Problems installing R packages on Windows ?

Getting the setup needed for the course working on Windows might involve a bit more effort than on Linux and Mac. Consequently, **we recommmend using either Linux or MacOS**.

Moreover, `Stan`, the probabilistic programming language which we will use later on during the course requires a C++ compiler toolchain which is not available by default in Windows (blame Microsoft).
However, if you want to use Windows and have a problem getting the setup working, see install instructions[here](https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started).



## Installing `bsda` package

The course has its own R package bsda with data and functionality
to simplify. To install the package just run the following
(upgrade=”never” skips question about updating other packages):

1. `install.packages("remotes")`
2. `remotes::install_github("avehtari/BDA_course_Aalto", subdir = "rpackage", upgrade="never")`

If during the course there is announcement that `bsda` has been
updated (e.g. some error has been fixed), you can get the latest
version by repeating the second step above.

## Error related to LC_CTYPE while installing `bsda` r-package.

When installing the `bsda` package, you may encounter an error like this:

```{r eval=FALSE}
Error: (converted from warning) Setting LC_CTYPE failed, using "C"
Execution halted
Error: Failed to install 'bsda' from GitHub:
 (converted from warning) installation of package '/var/folders/g6/bdv4dr4s6qq4zyxw2nzy26kr0000gn/T//Rtmp3uYwuD/file121f355845a3/bsda_0.1.tar.gz' had non-zero exit status
```

**Solution:**
See the following StackOverflow solution. ([link](https://stackoverflow.com/a/3909546))

## Installing `knitr`

If you just installed RStudio and R, chances are you don't have `knitr` installed, the package responsible for rendering your notebook to pdf.

**Solution:**
```{r eval=FALSE}
install.packages("knitr")
```
You can also install packages from RStudio menu `Tools->Install Packages`.

## If `knitr` is installed but the pdf won't compile

In this case it is possible that you don't have LaTeX installed, which is the package that runs the engine to process the text and render the pdf itself.

**Solution:**
Tinytex is the bare minimum Latex core that you need to install in order to run the pdf compiler. If you want to go further and download a full distribution of Latex, look at TeX Live for Linux and MacTeX for Mac OS.

```{r eval=FALSE}
install.packages("tinytex")
tinytex::install_tinytex()
```

## How do I install the latest version of `RStan` or `CmdStanR`?

* Make sure you have installed R version 3.4.0 or newer. If you don't, install a newer version using instructions from [https://www.r-project.org/](https://www.r-project.org/)
* Install `RStan` along with the necessary C++ compiler toolchain as described [here](https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started)

Instead of RStan, you can also use new `CmdStanR`which maybe easier to install.
* [CmdStanR](https://mc-stan.org/cmdstanr/) is a lightweight interface to Stan for R users (see CmdStanPy for Python).
* CmdStanR avoids some installation problems as it doesn't require matching C++ tools for R and RStan

## I have problems with RStan and Windows!

* [A list of the current RStan Windows problems and and known temporary workarounds](https://discourse.mc-stan.org/t/workarounds-for-current-rstan-windows-issues/17389)



## I missed some deadline or wasn't able to do some part of the course
- If you miss the deadline during the few first rounds due technical problems, but you send the pdf to the TA a few minutes after the deadline it can be accepted.

## I was not able to do one of the assignments because [some personal problem]. Can I do some extra work?

Things happen and you don't need to tell the course staff your personal reasons (especially you shouldn't tell any health issue details). See more information on late submissions  [here](https://github.com/MansMeg/BSDA#follow-up-and-late-submissions).

## My group member a) disappered, b) doesn't do anything, c) is annoying. Can I continue with the project alone.
First we hope you can resolve the issue, but if nothing works, then you can continue the project work alone.


## I was not able a) to do the project or b) to give a presentation because [some personal problem]. Can a) I submit it later, b) present later.

Things happen and you don't need to tell the course staff your personal reasons (especially you shouldn't tell any health issue details). If you cannot do the project on time, you can submit it later. See more information [here](https://github.com/MansMeg/BSDA#follow-up-and-late-submissions). 

