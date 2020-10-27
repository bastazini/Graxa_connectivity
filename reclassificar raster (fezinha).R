# Pacotes necessarios
install.packages("landscapemetrics")
install.packages("raster")
install.packages("sp")
install.packages("rgdal")

library(landscapemetrics)
library(raster)
library(sp)
library(rgdal)
library(dplyr)


Mapbiomas<- raster("C:/Users/ferna/OneDrive/BR 392/SIG/Conectividade/Mapbiomas_AEBacias_AF.tif") # raster do mapa do mapbiomas reclassificado com as classes agrupadas



#Reclassificacao do raster do mapbiomas para as classes que temos interesse (agrupamos algumas classes)
#Essa reclassificacao foi feita no raster do mapbiomas e depois salvamos um novo raster, que e a camada carregada a seguir no script, por isso que essa parte do script esta inativa


# Valores de resistencia para Tamandua tetradactyla
reclass_df <- c(0.9, 1.1, 1,
                1.9, 2.1, 50,
                2.9, 3.1, 90,
                3.9, 4.1, 80,
                4.9, 5.1, 90,
                5.9, 6.1, 90,
                6.9, 7.1, 100,
                7.9, 8.1, 90,
                8.9, 9.1, 100,
                -0.1, 0.1, NA)

reclass_m <- matrix(reclass_df, 
                    ncol = 3,
                    byrow = TRUE)

rc <- reclassify(Mapbiomas, reclass_m) #reclassificacao

writeRaster(rc, filename="C:/Users/ferna/OneDrive/BR 392/SIG/Conectividade/Resistencia_Tamandua.tif", format="GTiff", overwrite=TRUE)

# Valores de fonte/alvo para Tamandua tetradactyla
reclass_df <- c(0.9, 1.1, 1,
                1.9, 2.1, NA,
                2.9, 3.1, NA,
                3.9, 4.1, NA,
                4.9, 5.1, NA,
                5.9, 6.1, NA,
                6.9, 7.1, NA,
                7.9, 8.1, NA,
                8.9, 9.1, NA,
                -0.1, 0.1, NA)

reclass_m <- matrix(reclass_df, 
                    ncol = 3,
                    byrow = TRUE)

rc <- reclassify(Mapbiomas, reclass_m) #reclassificacao

writeRaster(rc, filename="C:/Users/ferna/OneDrive/BR 392/SIG/Conectividade/Fontes_Tamandua.tif", format="GTiff", overwrite=TRUE)