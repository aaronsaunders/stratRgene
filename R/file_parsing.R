library(readr)
library(tidyr)
library(dplyr)
library(stringr)

no_Ct_to_NA <- function(myvector){
  myvector <- ifelse(str_detect(myvector, "No Ct"), yes = NA, no = myvector)
  myvector <- ifelse(str_detect(myvector, "<2 Unique"), yes = NA, no = myvector)
  myvector
}

slash_NA_to_NA <- function(myvector){
  ifelse(myvector == "N/A", yes = NA, no = myvector)
}

parse_Stratagene_output <- function (path_to_file) {
  #' Parse the text output from a Statagene qPCR machine.
  #'
  #' @param path_to_file string
  #' @return dataframe of the parsed \code{path_to_file}
  #' @examples
  #' \dontrun{
  #' parse_Stratagene_output(L:/data/A01-data.txt)
  #' }
  fname_strings <- basename(path_to_file) %>%
                    str_split(pattern = "-", n = 2)
  runnum <- fname_strings[[1]][1]

  mydf <- read_tsv(path_to_file) %>%
          select(-`NA`) %>%
    # change all of the headers
          dplyr::rename(Well_Name = `Well Name`,
                  Well_Comment = `Well Comment`,
                  Well_Type = `Well Type`,
                  Rep        = `Replicate`,
                  R_last    = `R Last`,
                  dR_last   = `dR Last`,
                  Rn_last   = `Rn Last`,
                  dRn_last  = `dRn Last`,
                  RLast_RFirst  = `RLast/RFirst`,
                  Threshold     = `Threshold (dRn)`,
                  Baseline_St_Cyc  = `Baseline Start Cycle`,
                  Baseline_End_Cyc = `Baseline End Cycle`,
                  Ct             = `Ct (dRn)`,
                  Final_Call     = `Final Call (dRn)`,
                  Copies_PCR     = `Quantity (copies)`,
                  Avg_Copies_PCR = `Quantity Avg. (copies)`,
                  SD_Copies_PCR  = `Quantity SD (copies)`,
                  RSq            = `RSq (dRn)`,
                  Slope          = `Slope (dRn)`,
                  Efficiency     = `Efficiency (%)`,
                  Ct_Avg         = `Ct Avg. Treated Ind. (dRn)`,
                  Ct_SD          = `Ct SD Treated Ind. (dRn)`,
                  Tm_1           = `Tm Product 1 (-R'(T))`,
                  Tm_2           = `Tm Product 2 (-R'(T))`,
                  Tm_3           = `Tm Product 3 (-R'(T))`,
                  Tm_4           = `Tm Product 4 (-R'(T))`,
                  Tm_5           = `Tm Product 5 (-R'(T))`,
                  Tm_6           = `Tm Product 6 (-R'(T))`) %>%
    filter(Ct != "Reference") %>%    # remove any reference dyes
    mutate(Run            = runnum,
           Copies_PCR     = as.numeric(no_Ct_to_NA(Copies_PCR)),
           Ct             = as.numeric(no_Ct_to_NA(Ct)),
           Avg_Copies_PCR = as.numeric(no_Ct_to_NA(Avg_Copies_PCR)),
           SD_Copies_PCR  = as.numeric(no_Ct_to_NA(SD_Copies_PCR)),
           Ct_Avg         = as.numeric(no_Ct_to_NA(Ct_Avg)),
           Ct_SD          = as.numeric(no_Ct_to_NA(Ct_SD)),
           Final_Call     = ifelse(Final_Call == "+", TRUE, FALSE),
           Efficiency     = as.numeric(no_Ct_to_NA(Efficiency)),
           RSq            = as.numeric(no_Ct_to_NA(RSq)),
           Slope          = as.numeric(no_Ct_to_NA(Slope)),
           Tm_1           = as.numeric(slash_NA_to_NA(Tm_1)),
           Tm_2           = as.numeric(slash_NA_to_NA(Tm_2)),
           Tm_3           = as.numeric(slash_NA_to_NA(Tm_3)),
           Tm_4           = as.numeric(slash_NA_to_NA(Tm_4)),
           Tm_5           = as.numeric(slash_NA_to_NA(Tm_5)),
           Tm_6           = as.numeric(slash_NA_to_NA(Tm_6)))
  mydf
}

parse_metadata <- function(samplepath, dnaextpath, projectname){
  #' Parse the text output from a Statagene qPCR machine.
  #'
  #' @param samplepath string path to sample data export from Podio
  #' @param dnaextpath string path to dnaextract data export from Podio
  #' @param projectname string projectname from Podio
  #' @return dataframe of the parsed \code{path_to_file}
  #' @examples
  #' \dontrun{
  #' parse_Stratagene_output(L:/data/A01-data.txt)
  #' }
  sampledata <- read_excel(samplepath) %>%
    rename(sampleID = `Sample Number`,
           amount   = Amount,
           amount_unit = `Amount unit` ) %>%
    filter(Project == projectname) %>%
    select(sampleID, Site, Location)

  dnasampledata <- read_excel(dnaextpath) %>%
    rename(dnaID  = DNA_ID,
           sampleID = `Source sample`,
           extract_amount   = `amount extracted`,
           extract_amount_unit = `amount unit`) %>%
    select(dnaID, sampleID, extract_amount, extract_amount_unit) %>%
    left_join(sampledata, by = "sampleID") %>%
    select(-sampleID)
  dnasampledata
}
