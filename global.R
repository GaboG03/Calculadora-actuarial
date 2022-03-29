library(readxl)
library(lifecontingencies)
library(highcharter)
library(shinythemes)
library(DT)
library(ggplot2)
library(shinyWidgets)

# Eliminamos la notación cientifica
options(scipen = 999)

# Probabilidades de muerte Hombres
probs.H <- unname(unlist(read_excel("Probabilidades_Ecuador_2020_2060.xlsx", sheet = 1)[,c(3)]))

# Probabilidades de muerte Mujeres
probs.M <- unname(unlist(read_excel("Probabilidades_Ecuador_2020_2060.xlsx", sheet = 2)[,c(3)]))

# Tabla de mortalidad
TH <- probs2lifetable(probs.H, radix = 1000000, type = "qx", name = "Ecuador_H")

# Tabla de mortalidad
TM <- probs2lifetable(probs.M, radix = 1000000, type = "qx", name = "Ecuador_M")


poissontruncada <- function(n=1800){
  g=c()
  y=c()
  p=c()
  i=0
  while(i < n){
    x <- rpois(1,45)
    if(18<=x&&x<=65){
      y=c(y,x)
      g=c(g,sample(0:1,1))
      i=i+1
    }
  }
  
  y <- data.frame("edad"=y,"genero"=g)
  
  return(y)
}



Seguro<- function(genero, edad , duracion , tasa , diferido, fraccionado,cuantia){
  
  SH<- cuantia*Axn(TH, x=edad , n=duracion , i=tasa /100,  m=diferido , k=fraccionado )
  
  SM<- cuantia*Axn(TM, x=edad , n=duracion , i=tasa /100,  m=diferido , k=fraccionado )
  
  ifelse( genero==1, SM,SH )
}

PagoRenta<- function(genero , edad , duracionpago , tasa , fraccionadopago){
  RH<- axn (TH, x=edad , n=duracionpago , i=tasa /100 , k=fraccionadopago, payment = "due" )
  RM<- axn (TM, x=edad , n=duracionpago , i=tasa /100 , k=fraccionadopago, payment = "due" )
  
  ifelse( genero==1, RM,RH )
}  


Descuento<- function ( genero , edad , k , tasa ){
  DH<- Exn(TH, x=edad , n=k , i=tasa /100)
  DM<- Exn(TM, x=edad , n=k , i=tasa /100)
  
  ifelse(genero==1, DM,DH ) 
}







