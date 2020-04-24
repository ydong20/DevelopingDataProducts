#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# load the data and libraries
library(shiny); library(lubridate);library(ggplot2)

CaseReportGlobal <- read.csv("GlobalCases.csv", sep = ",")

# Tidy the data to fit our plot
CaseReportGlobal$Place <- paste(CaseReportGlobal$Country.Region, CaseReportGlobal$Province.State, sep = " ") 
CaseReportGlobal <- CaseReportGlobal[, -1:-4]
row.names(CaseReportGlobal) <- CaseReportGlobal$Place
CaseReportGlobal <- CaseReportGlobal[,-93]
names(CaseReportGlobal) = sub("X","", names(CaseReportGlobal))
CaseReportGlobal <- t(CaseReportGlobal)
CaseReportGlobal <- as.data.frame(CaseReportGlobal)


# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$RegionPick <- renderPlot({

        # Generate the bar plot based on the input region from ui.R
        ggplot(CaseReportGlobal, aes(x = rownames(CaseReportGlobal), 
                                     y=CaseReportGlobal[,input$Region])) +
            geom_bar(stat = "identity", fill="red", alpha = 0.7) +
            ggtitle("Case Reported in This Region") +
            xlab("Dates (from 01-22-2020 to 04-22-2020)") + ylab("Cases") +
            theme_minimal() + 
            theme(plot.title = element_text(hjust = 0.5)) +
            theme(axis.text.x = element_blank())
    })
})
