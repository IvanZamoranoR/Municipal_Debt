### Deuda Pública.
## Fuente: Secretaría de Hacienda y Crédito Público
## Link: https://www.disciplinafinanciera.hacienda.gob.mx/es/DISCIPLINA_FINANCIERA/Registro_Publico_Unico
## Crisis Group
## Iván Zamorano, Rafael Ch


#Librerías 

#Usar pacman para leer todas las librerías en una sola línea 

library(readxl)
library(dplyr)
library(magrittr)
library(openxlsx)



#Cargamos datos, ignorando la primera fila
# Eliminamos la segunda fila ya que tiene blanks

file_path <- "registro_deuda (1).xlsx"

registro_deuda_1_ <- read.xlsx(file_path, startRow = 2) %>%
  slice(-1)

#Observamos datos 
#View(registro_deuda_1)

#Para Amount: 
#Se tomó monto original contratado,  

#Para Maturities: 
#Se tomó fecha de vencimiento (hay algunos null values)
#También podemos está fecha de contratación, fecha de inscripción y plazo pactado a días, sumando fecha de contratación o fecha de inscripción más el plazo pactado a días 

#Para Rates: 
#Se tomó Tasa Efectiva 
#También se pude tomar Tasa de Interés, Sobretasa, Porcentaje Afectado, Tasa garantizada 



#Análisis municipal 
#Obtenemos datos municipales 

# Create a new data frame with rows containing "municipio"
registro_deuda_municipal_1 <- registro_deuda_1_[grepl("municipio", registro_deuda_1_$DEUDOR.U.OBLIGADO.2, ignore.case = TRUE), ]
registro_deuda_municipal_2 <- registro_deuda_1_[grepl("municipal", registro_deuda_1_$DEUDOR.U.OBLIGADO.2, ignore.case = TRUE), ]
registro_deuda_municipal <- rbind(registro_deuda_municipal_1, registro_deuda_municipal_2)
registro_deuda_municipal <- registro_deuda_municipal[, c("MONTO.ORIGINAL.CONTRATADO.7/", "DEUDOR.U.OBLIGADO.2/", "FECHA.DE.VENCIMIENTO.27/", "TASA.EFECTIVA.13/")]
write.xlsx(registro_deuda_municipal, file = "registro_deuda_municipal.xlsx")



#Análisis estatal 
#Obtenemos datos estatales

registro_deuda_estatal_1 <- registro_deuda_1_[grepl("Estado", registro_deuda_1_$DEUDOR.U.OBLIGADO.2, ignore.case = TRUE), ]
registro_deuda_estatal_2 <- registro_deuda_1_[grepl("Estatal", registro_deuda_1_$DEUDOR.U.OBLIGADO.2, ignore.case = TRUE), ]
registro_deuda_estatal <- rbind(registro_deuda_estatal_1, registro_deuda_estatal_2)
registro_deuda_estatal <- registro_deuda_estatal[, c("MONTO.ORIGINAL.CONTRATADO.7/", "DEUDOR.U.OBLIGADO.2/", "FECHA.DE.VENCIMIENTO.27/", "TASA.EFECTIVA.13/")]
write.xlsx(registro_deuda_estatal, file = "resgistro_deuda_estatal.xlsx")







