library(rvest)
library(polite)
library(tidyverse)
rm(list = ls())

url1 <- "https://www.wrestlingdata.com/index.php?befehl=titles&titel=1"
champions_page1 <- read_html(url1)
champions_table <- html_table(champions_page1)
#tables <- champions_table %>% html_table()
table16 <- champions_table[[16]]
#t_16names <- table16 [1, ] 
table16 <- table16[2:nrow(table16), 1:4]
colnames(table16) <- c("order", "champion", "date", "days")
table16 %>% filter(!str_detect(order, 'The'))

url2 <- "https://www.wrestlingdata.com/index.php?befehl=titles&kategorie=1&liga=3&titel=1&seite=2"
champions_page2 <- read_html(url2)
champions_table2 <- html_table(champions_page2)
table16.2 <- champions_table2[[16]]
table16.2 <- table16.2[2:nrow(table16), 1:4]
colnames(table16.2) <- c("order", "champion", "date", "days")
table16.2 %>% filter(!str_detect(order, 'The'))

url3 <- "https://www.wrestlingdata.com/index.php?befehl=titles&kategorie=1&liga=3&titel=1&seite=3"
champions_page3 <- read_html(url3)
champions_table3 <- html_table(champions_page3)
table16.3 <- champions_table3[[16]]
table16.3 <- table16.3[2:nrow(table16), 1:4]
colnames(table16.3) <- c("order", "champion", "date", "days")
table16.3 %>% filter(!str_detect(order, 'The'))

url4 <- "https://www.wrestlingdata.com/index.php?befehl=titles&kategorie=1&liga=3&titel=1&seite=4"
champions_page4 <- read_html(url4)
champions_table4 <- html_table(champions_page4)
table16.4 <- champions_table4[[16]]
table16.4 <- table16.4[2:nrow(table16), 1:4]
colnames(table16.4) <- c("order", "champion", "date", "days")
table16.4 %>% filter(!str_detect(order, 'The'))



