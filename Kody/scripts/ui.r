library(shinythemes)
library(markdown)
library(shinyWidgets)
library(DT)
library(bslib)
library(supercaliheatmapwidget)
library(shiny)

#source("Projekt_ja/Yt_stats.R")

my_theme <- bs_theme(
  version = 5,
  bg = "#121212",
  fg = "#FF0000",
  primary = "#FF0000",
  base_font = 'Roboto_condensed',
  heading_font = font_google("Proza Libre"),
  code_font = 'Roboto_condensed'
)

ui <- navbarPage(div(img(src = "logo.png", width = 60, height = 60,class = "img-responsive"), align = "left","Youtube wrapped",style="font-size: 30px;width:400px; margin:20 auto;",class="moving right"),
                 # title = "Youtube wrapped",
           theme = my_theme,
           tabPanel(div("Home", style = "font-size: 30px;"),
                    fluidPage(
                      fluidRow(
                        column(2, align = "center", 
                               sidebarPanel(
                                 awesomeRadio(
                                   inputId = "subscriberCountFilter",
                                   label = "Subscriber count",
                                   choices = c(
                                     "All" = "all",
                                     "Under 1 Milion" = "underMilion",
                                     "Under 100 thousand" = "under100k"
                                   ),
                                   status = "danger"
                                 ),
                                 width = 200,
                                 align = "left"
                               ),
                               sidebarPanel(
                                 awesomeRadio(
                                   inputId = "rankingCriteria",
                                   label = "Ranking Criteria",
                                   choices = c(
                                     "By videos watched" = "byVideos",
                                     "By watchtime" = "byWatchtime"
                                   ),
                                   status = "danger"
                                 ),
                                 width = 200,
                                 align = "left"
                               )
                        ),
                        column(
                          10,
                          h1(
                            "Top creators",
                            align = "center",
                            style = "color: #ff9933" 
                          ),
                          align = "center", 
                          style = 'border-left:1px solid #65D36E; padding-right: 30px',
                          fluidRow(
                            column(4, h1("Pawe??")),
                            column(4, h1("Miko??aj")),
                            column(4, h1("Micha??"))
                            
                          ),
                          
                          fluidRow(
                            column(
                              4,
                              align = "center",
                              DT::dataTableOutput("topCreatorsP")
                            ),
                            column(
                              4,
                              align = "center",
                              DT::dataTableOutput("topCreatorsM")
                            ),
                            column(
                              4,
                              align = "center",
                              DT::dataTableOutput("topCreatorsB")
                            )
                            
                          ),
                          tags$br(), tags$br(), tags$br() , tags$br(),
                          fluidRow(
                            h1("Most Watched", style = "color: #ff9933;"),
                            tags$br(), tags$br(), tags$br() , tags$br()
                            
                          ),
                          fluidRow(
                            div(
                              style = 
                                "height: 80px; background-color: #121212; width: 100%; position: relative;",
                              tags$iframe(width="376", height="315", src="https://www.youtube.com/embed/JR9lfJL8ov0", 
                                          frameBorder="400", allowfullscreen=NA, style = "border: 10px solid #EEE; border-color: #6e0e0a;"),
                              tags$iframe(width="376", height="315", src="https://www.youtube.com/embed/HMum-XYlZSk", 
                                          frameBorder="400", allowfullscreen=NA, style = "border: 10px solid #EEE; border-color: #6e0e0a;"),
                              tags$iframe(width="376", height="315", src="https://www.youtube.com/embed/oe8SoCqElGI", 
                                          frameBorder="400", allowfullscreen=NA, style = "border: 10px solid #EEE; border-color: #6e0e0a;")
                            ),
                            style="text-align:center"
                            
                          )
                        )
                      ),
                    )
                    
           ),
           
           tabPanel(div("When do we watch", style = "font-size:30px;"),
                    fluidPage(
                      h1(
                      "Time of the day",
                      align = "center",
                      style = "color: #ff9933"
                    ),
                      fluidRow(
                        column(2, align = "center", #h2("Filters"),
                          sidebarPanel(
                            awesomeCheckboxGroup(
                              inputId = "hourPlotFilter",
                              label = "Choose a person",
                              choices = c(
                                "Pawe??" = "pawel",
                                "Miko??aj" = "mikolaj", 
                                "Micha??" = "michal"
                              ),
                              selected = c("pawel","mikolaj","michal"),
                              #inline = TRUE,
                              status = "danger"
                            ),
                            width = 200,
                            align = "left"
                          )
                        ),
                      column(10, align = "center",
                      plotOutput("hourPlot")
                      )
                    ),
                  fluidRow(
                    column(
                    6,
                    align = "center",
                    h1(
                      "Weekday",
                      align = "center",
                      style = "color: #ff9933"
                    ),
                    plotOutput("weekdayPlot", height = "500px")
                    ),
                    column(
                      6,
                      align = "center",
                      h1(
                        "Yearly calendar",
                        align = "center",
                        style = "color: #ff9933"
                      ),
                      radioGroupButtons(
                        inputId = "whoseCalendar",
                        label = "Selected person:",
                        choices = c(
                          "Pawe??" = "dfP",
                          "Miko??aj" = "dfM",
                          "Micha??" = "dfB"
                        ),
                        status = 'primary',
                        individual = TRUE
                      ),
                      uiOutput("ListOfCharts1", height = "210px"),
                
                      uiOutput("ListOfCharts2", height = "100px"),
                      uiOutput("ListOfCharts3")
                      
                    )
                  
                )
              )      
           ),
            tabPanel(div("Likes and views", style = "font-size: 30px;"),
                     fluidPage(
                       tags$style(HTML(".js-irs-0 .irs-bar,.js-irs-0 .irs-single, .js-irs-0 .irs-bar-edge, .js-irs-0 .irs-to,.js-irs-0 .irs-from, .js-irs-0 .irs-grid-pol {background: red}")),
                       tags$style(HTML(".js-irs-1 .irs-bar,.js-irs-1 .irs-single, .js-irs-1 .irs-bar-edge, .js-irs-1 .irs-to,.js-irs-1 .irs-from, .js-irs-1 .irs-grid-pol {background: red}")),
                       h1(
                         "What do we like to watch",
                         align = "center",
                         style = "color: #ff9933"
                       ),
                       fluidRow(
                         column(2, align = "center", 
                                sidebarPanel(
                                  awesomeCheckboxGroup(
                                    inputId = "likeViewPlotFilter",
                                    label = "Choose a person",
                                    choices = c(
                                      "Pawe??" = "dfP",
                                      "Miko??aj" = "dfM",
                                      "Micha??" = "dfB"
                                    ),
                                    selected = c("dfP","dfM","dfB"),
                                    status = "danger"
                                  ),
                                  width = 200,
                                  align = "left"
                                )
                         ),
                         column(5, align = "center",
                                plotOutput("likePlot"),
                                fluidRow(
                                  column(9, align = "center",
                                           sliderInput('likeRange',
                                            "Chose range of likes",
                                            min = 0,
                                            max = 100000,
                                            value = c(0,20000),
                                            step = 5000,
                                            ticks = FALSE)
                                    
                                  ),
                                  column(3)
                                )
                         ),
                         column(5, align = "center",
                                plotOutput("viewPlot"),
                                fluidRow(
                                  column(9, align = "center",
                                         sliderInput('viewRange',
                                                     "Chose range of views",
                                                     min = 0,
                                                     max = 1000000,
                                                     value = c(0,500000),
                                                     step = 20000,
                                                     ticks = FALSE)
                                         ),
                                  column(3)
                                )
                         )
                       
                      
                    )
            )
                      
      ),
      tabPanel(div("About", style = "font-size: 30px;"),
               
               h4("YouTube Wrapped to aplikacja bazuj??ca na platformie YouTube, kt??ra pozwala u??ytkownikom
                przegl??da?? podsumowanie swojej aktywno??ci odtwarzania i ogl??dania przez ca??y rok.
                Zawiera ona informacje takie 10 najcz????ciej oraz najwi??cej ogl??danych kana????w pod wzgl??dem liczby subkrybent??w danego kana??u. 
                U??ytkownicy mog?? r??wnie?? sprawdzi?? g??sto???? czasu sp??dzonego na platformie i proporcje liczby filmik??w w zale??no??ci od dnia tygodnia oraz danego dnia w roku.
                W trzeciej zak??adce mo??na r??wnie?? por??wna?? liczbe ogl??danych odcink??w bior??c zakres popularno??ci filmik??w. Ca??o???? jest kolorystycznie dostosowana tak jak na poni??szej legendzie:
                  ", align = "center", style = "color: white" ),
               
               fluidRow(
                 column(
                   12, 
                   align = "center", 
                   style = 'border-left:1px solid #65D36E; padding-right: 30px',
                   fluidRow(
                     
                     column(4, h1("Pawe??", align = "center")),
                     
                     column(4, h1("Miko??aj", align = "center")),
                    
                     column(4, h1("Micha??", align = "center"))
                   ),
                   fluidRow(
                     
                     column(4, img(src = "ikona3.png", width = 300, height = 300)),
                     
                     column(4, img(src = "ikona2.png", width = 300, height = 300)),
                     
                     column(4, img(src = "ikona1.png", width = 300, height = 300))
                   )
                     )))
      
               
)

      

