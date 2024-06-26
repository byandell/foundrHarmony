% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Calcium.R, R/Enrich.R, R/Enrich3.R, R/Lipid.R,
%   R/LivEnrich.R, R/Met.R, R/Physio.R, R/Protein.R, R/moduleHarmony.R
\name{CalciumHarmony}
\alias{CalciumHarmony}
\alias{EnrichHarmony}
\alias{Enrich3Harmony}
\alias{LipidHarmony}
\alias{LivEnrichHarmony}
\alias{MetHarmony}
\alias{PhysioHarmony}
\alias{ProteinHarmony}
\alias{moduleHarmony}
\title{Title}
\usage{
CalciumHarmony(dataset, links, basal = FALSE, ...)

EnrichHarmony(dataset, links, annot, ...)

Enrich3Harmony(dataset, links, annot, ...)

LipidHarmony(
  dataset,
  links,
  annot,
  sheetNum,
  skipNum,
  minCol,
  maxCol,
  charCols,
  ...
)

LivEnrichHarmony(dataset, links, annot, ...)

MetHarmony(dataset, links, annot, skiprows = 4, ...)

PhysioHarmony(dataset, links, annot, sheet = 2, rename_function, ...)

ProteinHarmony(dataset, links, ...)

moduleHarmony(
  datasetname,
  links,
  object,
  responsename = names(object[[1]]),
  ...,
  datatraits = FALSE,
  traitparams = FALSE
)
}
\arguments{
\item{dataset}{name of dataset}

\item{links}{data frame with links (not used yet)}

\item{basal}{include `basal` dataset if `TRUE`}

\item{...}{additional parameters ignored}

\item{annot}{annotation data frame}

\item{sheetNum, skipNum, minCol, maxCol, charCols}{additional parameters}

\item{skiprows}{number of rows to skip}

\item{sheet, rename_function}{additional parameters}

\item{datasetname}{name to give to dataset (here for compatibility)}

\item{object}{object of class traitModule}

\item{responsename}{name of response to extract}

\item{datatraits}{incorporate `dataset` into `trait` if `TRUE`}

\item{traitparams}{incorporate key `params` into `trait` if `TRUE`}
}
\value{
data frame

data frame

data frame

data frame

data frame

data frame with columns for strain,sex,animal,condition,trait,value

data frame

data frame

harmonize object
}
\description{
There are  minor differences among metabolite files.
To harmonize, we assume the following:
   Some number of rows (3-4) at top of file are skipped
   Columns from “compound” to “data_type” precede mouse data
   Mouse ID always begins with FFF-nn with “FFF” = founder, “nn” = animal
   (the rest of Mouse ID seems to change from file to file)
}
