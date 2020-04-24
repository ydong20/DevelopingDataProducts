#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny); library(lubridate);library(ggplot2)

CaseReportGlobal <- read.csv("GlobalCases.csv", sep = ",")

CaseReportGlobal$Place <- paste(CaseReportGlobal$Country.Region, CaseReportGlobal$Province.State, sep = " ") 
CaseReportGlobal <- CaseReportGlobal[, -1:-4]
row.names(CaseReportGlobal) <- CaseReportGlobal$Place
CaseReportGlobal <- CaseReportGlobal[,-93]
names(CaseReportGlobal) = sub("X","", names(CaseReportGlobal))
CaseReportGlobal <- t(CaseReportGlobal)
CaseReportGlobal <- as.data.frame(CaseReportGlobal)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Global COVID19 Case by Region (As of 04/22/2020)"),

    # Sidebar with a panel for different regions to load.
    sidebarLayout(
        sidebarPanel(("Select the region you want to know."),
            selectInput("Region", "Region:",
                        choices=colnames(CaseReportGlobal)),
            hr(),
            helpText (p(strong("Hope you are doing well in these odd times. Stay Safe!"
                               , style="color:red")),
            helpText ("Documentation:", a("User Help Page", 
                                          href="https://rpubs.com/YisPractice/COVID19"))),
            helpText ("Data acquired from:", a("Johns Hopkins Coronavirus Resource Center", 
                                              href="https://coronavirus.jhu.edu"))),
            
            
        # Show a plot of the number of cases reported in the past 3 month
        mainPanel(
            plotOutput("RegionPick")
        )
    )
))
