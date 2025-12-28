if (!require('pacman'))
  install.packages('pacman')

pacman::p_load(rvest, binman, stringr, dplyr)

library(rvest)
library(binman)
library(stringr)

url <- 'https://googlechromelabs.github.io/chrome-for-testing/#stable'

datos <- read_html(url) %>% html_element('#stable')

version <- html_element(datos, 'p') %>%
  html_elements('code') %>% html_text2() %>% .[[1]]

versionesInstaladas <- list_versions('chromedriver')$win32

#reemplazar tuUsuario por el usuario real
rutaDestino <- 'C:/Users/tuUsuario/AppData/Local/binman/binman_chromedriver/win32'

if (!str_detect(versionesInstaladas, version) %>% sum() > 0) {
  
  urlDescarga <- html_table(datos) %>% filter(Binary == 'chromedriver' & Platform == 'win64') %>% .$URL
  download.file(urlDescarga, destfile = paste0(version, '.zip'), mode = 'wb')
  unzip(paste0(version, '.zip'), exdir = version)
  dir.create(paste0(rutaDestino, '/', version))
  file.copy(paste0(version, '/chromedriver.exe'), paste0(rutaDestino, '/', version, '/chromedriver.exe'))
}
