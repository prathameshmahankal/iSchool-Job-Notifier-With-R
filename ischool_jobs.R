library(robotstxt)
library(xml2)
library(dplyr)
library(tidyr)
library(lubridate)
library(stringr)
library(rvest)

link <- 'https://jobs.ischool.uw.edu/'

paths_allowed(paths = link)

jobs <- read_html(link)
job_list <- jobs %>%
  html_nodes('.tableRow') %>%
  html_text() %>% str_trim() %>% str_replace_all("\t", "") %>%
  str_replace_all("\n", ",") %>% strsplit(",")

id <- vector()
name <- vector()
type <- vector()
deadline <- vector()
sdate <- vector()
edate <- vector()

for (i in seq(length(job_list))){
  id <- append(id, job_list[[i]][1])
  name <- append(name, job_list[[i]][4])
  type <- append(type, job_list[[i]][7])
  deadline <- append(deadline, job_list[[i]][10])
  sdate <- append(sdate, job_list[[i]][13])
  edate <- append(edate, job_list[[i]][16])
}

df_jobs <- data.frame(id, name, type, deadline, sdate, edate)

library(sendmailR)
from <- "<dummyacnt1695@gmail.com>"
to <- "<pratham1695@gmail.com>"
subject <- "New jobs are out!"
body <- "This is the result of the test:"                     
mailControl=list(smtpServer="ASPMX.L.GOOGLE.COM")

sendmail(from=from,to=to,subject=subject,msg=body,control=mailControl)

install.packages("devtools", dep = T)
library(devtools)
install_github("rpremraj/mailR")

library(mailR)
send.mail(from="<dummyacnt1695@gmail.com>",
          to="<pratham1695@gmail.com>",
          subject="Job Notification Email",
          body="New jobs are out!",
          smtp=list(host.name = "smtp.gmail.com",
                    port = 465,
                    user.name = "dummyacnt1695@gmail.com",
                    passwd = "dummy@16",
                    ssl = TRUE),
          authenticate=TRUE,
          send = TRUE)

#create an email client
