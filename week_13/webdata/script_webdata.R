## ----echo=FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  warning = FALSE,
  message = FALSE,
  comment = "#>"
)

## ------------------------------------------------------------------------
library('rvest')
url <- paste0(
  "https://www.wunderground.com/history/airport/",
  "KAMW/2016/11/15/DailyHistory.html"
)
weather_data <- read_html(url)
head(html_table(weather_data)[[1]])

## ----echo=FALSE----------------------------------------------------------
url <- "ftp://ftp.ncdc.noaa.gov/pub/data/noaa/1991/010510-99999-1991.gz"

## ----eval=FALSE----------------------------------------------------------
## library("httr")
## url <- "ftp://ftp.ncdc.noaa.gov/pub/data/noaa/1991/010510-99999-1991.gz"
## res <- GET(url, write_disk(path = basename(url)))
## res$request$output$path

## ------------------------------------------------------------------------
download.file(url, destfile = basename(url))

## ------------------------------------------------------------------------
readLines(basename(url), n = 10)

## ------------------------------------------------------------------------
library(isdparser)
isd_parse(path = basename(url))

## ------------------------------------------------------------------------
library("request")
library("dplyr")
res <- api("http://omdbapi.com") %>% 
  api_query(s = "iron man", r = json) 
res$Search

