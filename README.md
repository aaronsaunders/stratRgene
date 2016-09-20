# StratRgene

A simple package for using R to analyse qPCR data from the Stratagene qPCR machines.

At the moment it can just parse the default text output from Stratagene qPCR software, rename the headings to names usable in R, and do some simple operations that I find useful. 

It is not an actual qPCR analysis tool, for this check out [qpcR](https://github.com/anspiess/qpcR) or [SLqPCR](http://www.bioconductor.org/packages/devel/bioc/html/SLqPCR.html).


## Installation

``` r
devtools::install_github("aaronsaunders/stratRgene")
```

## Dependancies

tidyverse: readr, tidyr, dplyr, ggplot2, stringr.

``` r
devtools::install_github("hadley/tidyverse")
```

## Usage

Export the qPCR data to text. Before you do this choose "Select All" to get all of the data. 

more to come...


## License

The software is licenced under a permissive the MIT License.

MIT License (MIT)
Copyright (c) 2016 Aaron Saunders

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
