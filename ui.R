library(shiny)

# UI del programa
shinyUI(navbarPage('PoliSeguros',
                   theme = shinytheme("flatly"),
                   tabPanel("Presentación",
                            setBackgroundImage( src = "fondo.jpg", shinydashboard = FALSE ),
                            h1(align="center","Escuela Politécnica Nacional"),
                            hr(),
                            HTML('<center><img src="logoEPNblanco.png" width="200"></center>'),
                            hr(),
                            h2(align="center","Matemática Actuarial"),
                            h3(align='center','Trabajo 2'),
                            column(5,br(), tags$b('Integrantes:'),  br(),
                                   tags$ul(
                                       tags$li("STEFANO SEBASTIÁN CRUZ SEGURA"), 
                                       tags$li("ERIKA ALEXANDRA GALINDES HERNÁNDEZ"),
                                       tags$li("WILLIAM GABRIEL GRANDA BETANCOURT"),
                                       tags$li("DANIELA DOMINIC RIERA SAMPEDRO"),
                                       tags$li("JORGE RICARDO SOSA DONOSO")
                                   )),
                            column(7,br(), tags$b('Profesor:'), br(),
                                   tags$ul(tags$li("MSc. Diego Huaraca")),
                                   tags$b('Fecha:'),
                                   tags$ul(tags$li("22/09/2021"))
                            ) 
                   ),
                   
                  

                
                              tabPanel("Tarificacion individual",
                                       h1(align="center","Consulte la tarificación de su producto:"),
                                       h4(align="justify"," El producto consta de  "),
                                       hr(), 
                                       
                                       fluidRow(align='center',tags$table(style = "padding: 1%; width: 75%;",
                                                                          tags$tr(
                                                                            tags$td(numericInput("edad1", label = h4("Edad (18 a 65 años)"), value = 18,min =1, max = 65)),
                                                                            tags$td(radioButtons("gen1", label = h4("Sexo"),
                                                                                                 choices = list("Masculino" = 1, "Femenino" = 2), 
                                                                                                 selected = 1))
                                                                          ),
                                                                          tags$tr(
                                                                            tags$td(numericInput("int1", label = h4("Tipo de interés (%)"), value = 1,min =0, max = 100,step=0.1)),
                                                                            tags$td(numericInput("dur1", label = h4("Cobertura (años)"), value = 1,min =0, max = 90))
                                                                          ),
                                                                          tags$tr(
                                                                            tags$td(numericInput("cap1", label = h4("Capital"), value = 2000,min =100, max = 1000000)),
                                                                            tags$td(selectInput("tem1", label = h4("Elija su forma de pago:"), 
                                                                                                choices = list("Mensual" = 1, "Trimestral" = 2, "Semestral" = 3, 'Anual'=4), 
                                                                                                selected = 12)),
                                                                            tags$td(numericInput("durpago1", label = h4("Elija el tiempo de pago de las cuotas"), value = 1,min =0, max = 90))
                                                                          ),
                                                                          tags$tr(
                                                                            tags$td(numericInput("dif1", label = h4("Diferimiento"), value = 0,min =0, max = 1000000)),
                                                                            tags$td()
                                                                          )
                                       )),
                                       
                                       fluidRow(align='center',actionButton("s1", label = "Consulta")),
                                       hr(),
                                       
                                       fluidRow(align='center',tags$table(style = "border: 1px solid blue; padding: 5%; width: 50%;",
                                                                          tags$tr(
                                                                            tags$td('Su edad en años es:'), tags$td(textOutput('Edad1'))
                                                                          ),
                                                                          tags$tr(
                                                                            tags$td("El valor a pagar es:"), tags$td(textOutput('PP1'))
                                                                          ),
                                                                          tags$tr(
                                                                            tags$td("El valor de la cuota a pagar es: "), tags$td(textOutput('PF1'))
                                                                          )
                                       )),
                                       hr(),
                                       hr(),
                                       fluidRow(align='center', tableOutput("Reserva_s1")),
                                       plotOutput("S1Graf"),
                                       hr()
                              )
                   
                  
                            
                   )
)

