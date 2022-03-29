library(shiny)

#Server
shinyServer(function(input, output) {
    
  ###################### TEMPORAL #########################
  #########################################################
  
  S <- eventReactive(input$s1,{  #### Prima Pura 
    edad <- input$edad1; dur <- input$dur1; int <- input$int1
    gen <- input$gen1;  cap <- input$cap1;  dif <- input$dif1
    
    if(gen == 1){ tabla <- TH} # Asignamos la tabla de los hombres 
    else if(gen == 2){ tabla <- TM}
    cap*Axn(tabla, edad, dur, int/100,m=dif,k=1)
  })
  
  PF <- eventReactive(input$s1,{      ### Prima Fraccionada
    edad <- input$edad1; durpago<- input$durpago1; int <- input$int1
    gen <- input$gen1;  cap <- input$cap1;  dif <- input$dif1
    tem <- input$tem1
    
    if(gen==1){ tabla <- TH }
    else if(gen==2){ tabla <- TM  }
    
    if(tem==1){ frac <- 12 }
    else if(tem==2){ frac <- 4 }
    else if(tem==3){ frac <- 2 }
    else if(tem==4){ frac <- 1 }
    
    S()/(frac*axn(tabla, x=edad, n=durpago, m = dif,i=int/100, k=frac, payment = "due"))
  })
  
  output$Edad1 <- renderText({ input$edad1 })
  output$PP1 <- renderText({ round(S(),2) })
  output$PF1 <- renderText({ round(PF(),2) })
  
  ### Reservas Matematicas anuales
  
  RM <- eventReactive(input$s1,{
    edad <- input$edad1; dur <- input$dur1; int <- input$int1
    gen <- input$gen1;  cap <- input$cap1;  dif <- input$dif1
    tem <- input$tem1; durpago<- input$durpago1
    
    res_mat <- vector();  prest <- vector();  prim <- vector()
    
    if(gen==1){ tabla <- TH }
    else if(gen==2){ tabla <- TM }
    
    if(tem==1){ frac <- 12 }
    else if(tem==2){ frac <- 4 }
    else if(tem==3){ frac <- 2 }
    else if(tem==4){ frac <- 1 }
    
    for(t in 0:dur){
      prest <- c(prest,cap*Axn(tabla, x=edad+t, m= dif ,n=dur-t, i=int/100))
    }
    for(t in 0:dur){
      prim <- c(prim,PF()*frac*axn(tabla, x=edad+t, n=durpago-t, m=dif,i=int/100, k=frac ,payment = "due"))
    }
    
    for(t in 0:dur){
      res_mat <- c(res_mat, cap*Axn(tabla, x=edad+t, n=dur-t, m=dif ,i=int/100)-
                     PF()*frac*axn(tabla, x=edad+t, n=durpago-t, m=dif ,i=int/100, k=frac ,payment = "due"))
    }
    
    data.frame(Año=seq(0,dur), Prestaciones=prest, Primas=prim, Reserva_Matemática=res_mat)
  })
  
  output$Reserva_s1 = renderTable({ RM() })
  output$S1Graf <- renderPlot({
    g <- ggplot(data = RM(), aes(x = Año, y = Reserva_Matemática)) +
      geom_line() +
      ggtitle("Reserva Matemática") + xlab("Período") + ylab("Reserva")+
      theme_bw() 
    print(g)
  })
  
        
})
