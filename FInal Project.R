library(rvest)
library(polite)
library(tidyverse)
rm(list = ls())

url1 <- "https://www.wrestlingdata.com/index.php?befehl=titles&titel=1"
champions_page1 <- read_html(url1)
champions_table <- html_table(champions_page1)
table16 <- champions_table[[16]]
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

champions_data <- list()
champions_data[[1]] <- table16 %>% filter(!str_detect(order, 'The'))
champions_data[[2]] <- table16.2 %>% filter(!str_detect(order, 'The'))
champions_data[[3]] <- table16.3 %>% filter(!str_detect(order, 'The'))
champions_data[[4]] <- table16.4 %>% filter(!str_detect(order, 'The'))
combined_table <- do.call(rbind, champions_data)

combined_table$days <- as.numeric(combined_table$days, na.rm = TRUE)
sorted_table <- combined_table[order(combined_table$days, decreasing = TRUE), ]

eras <- data.frame(
  era_name = c("WWWF Era", "Golden Era", "Attitude Era", "Ruthless Aggression Era", "PG Era", "Modern Era"),
  start_date = as.Date(c("1953-01-01", "1983-01-01", "1997-01-01", "2002-01-01", "2008-01-01", "2016-01-01")),
  end_date = as.Date(c("1983-01-01", "1997-01-01", "2002-01-01", "2008-01-01", "2016-01-01", "2024-05-01"))
)
combined_table$era <- NA
combined_table <- combined_table[!is.na(combined_table$date), ]
for(i in 1:nrow(combined_table)){
  reign_date <- as.Date(combined_table$date[i])
  for(j in 1:nrow(eras)){
    if(reign_date >= eras$start_date[j] & reign_date <= eras$end_date[j]){
      combined_table$era[i] <- eras$era_name[j]
      break  
    }
  }
}
filtered_data <- combined_table[combined_table$era %in% eras$era_name,]
era_champions <- filtered_data %>%
  group_by(era) %>%
  arrange(desc(days)) %>%
  top_n(1)  
#view(era_champions)
print(era_champions)
# Bruno Sammartino has the longest World Title reign in WWE history at 2,803 days.  
# 5 out of the top 10 longest reigning WWE champions are from the WWWF era.
# During this era, WWE was not national, instead it was the New York Territory.

# Let's look at the longest reigning champions of each era, excluding the WWWF era. 
golden_era_data <- filtered_data[filtered_data$era == "Golden Era", ]
golden_era_champs <- golden_era_data %>%
  arrange(desc(days)) %>%
  top_n(1)  
print(golden_era_champs)
# Hulk Hogan had the longest title reign of the golden era, at 1,474 days. 

attitude_era_data <- filtered_data[filtered_data$era == "Attitude Era", ]
attitude_era_champs <- attitude_era_data %>%
  arrange(desc(days)) %>%
  top_n(1)  
print(attitude_era_champs)
# 'Stone Cold' Steve Austin had the longest reign of the attitude era, at 175 days. 

ruthless_aggression_era_data <- filtered_data[filtered_data$era == "Ruthless Aggression Era", ]
ruthless_aggression_era_champs <- ruthless_aggression_era_data %>%
  arrange(desc(days)) %>%
  top_n(1)  
print(ruthless_aggression_era_champs)
# John Cena had the longest title reign of the ruthless aggression era, at 380 days. 

pg_era_data <- filtered_data[filtered_data$era == "PG Era", ]
pg_era_champs <- pg_era_data %>%
  arrange(desc(days)) %>%
  top_n(1)  
print(pg_era_champs)
# CM Punk had the longest title reign of the PG era, at 434 days. 

modern_era_data <- filtered_data[filtered_data$era == "Modern Era", ]
modern_era_champs <- modern_era_data %>%
  arrange(desc(days)) %>%
  top_n(1)  
print(modern_era_champs)
# Roman Reigns has the longest WWE Title reign of the modern era at 735 days.
# In the modern era, WWE introduced a new top title, the Universal Title.
 url5 <- "https://www.wrestlingdata.com/index.php?befehl=titles&titel=4335"
 universal_champ_page <- read_html(url5)
 universal_champ_table <- html_table(universal_champ_page)
 u_table <- universal_champ_table[[16]]
 u_table <- u_table[2:nrow(u_table), 1:4]
 colnames(u_table) <- c("order", "champion", "date", "days")
u_table %>% filter(!str_detect(order, 'The'))
u_table$days <- str_replace_all(u_table$days, "[^0-9]", "") %>% as.numeric()
u_table_ranked <- u_table %>% filter(!str_detect(order, 'The'))
u_table_ranked<- arrange(u_table_ranked, desc(days))
print(u_table_ranked)
# Roman Reigns has the longest title reign of the modern era at 1,316 days.
# Roman won the WWE title 581 days into his Universal title reign, unifying the belts.
# He was the undisputed WWE champion for a total of 735 days. 





