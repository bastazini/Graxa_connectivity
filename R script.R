require(adehabitatHS)
require(sp)
require(raster)
require(adehabitatLT)
require(scales)

rm(list = ls())
###abrindo arquivo
#Raster de resist6encia de cada bicho
mapa=raster(file.choose())
NAvalue(mapa)<- 0
plot(mapa)
##encontrando as áreas de cada porporçao
f = freq(mapa) 
prop = data.frame(f, p=f[,2] / sum(f[,2])) 
prop*100
###dados dos graxains
### importar tabela shape
graxas=read_sf(file.choose())
graxas1=as.data.frame(graxas)
###pontos epsaciais
###separar individuos
table(graxas1$ind)
ind.graxa=graxas1 %>% filter(graxas1$ind=="Noel")
cord.dec = SpatialPoints(cbind(ind.graxa$Longitude, ind.graxa$Latitude), proj4string=CRS("+proj=longlat"))
cord.UTM <- spTransform(cord.dec, CRS("+init=ESRI:102033"))
points(cord.UTM, col="white", cex=2,pch=16)
#South America Albers Equal Area Conic - ESRI:102033 "South_American_Datum_1969"



##extraindo values
rasValue=extract(mapa,cord.UTM )
teste1=combinePointValue=cbind(ind.graxa,rasValue);teste1
table(teste1$rasValue)

###uso de habitat
dados1=read.table(pipe("pbpaste"), header=T, row.names=1,sep="\t")
par(mar=c(5,12,2,2))
dados2=read.table(pipe("pbpaste"), header=T, row.names=1,sep="\t")
barplot(t(as.matrix(dados1)), beside=TRUE, las=2,horiz=TRUE,xlab="Porcentagem de uso")

###Calculando  razão de seleção
wi <- widesII(dados1, dados2$proporçao, avknown = TRUE, alpha = 0.1)
razao=wi$wi
## plot the values of the selection ratios
opar <- par(mfrow=c(1,2))

plot(wi)
resitencia=function(x){
  rescalonado=rescale(razao,from =c(min(x),max(x)),to=(c(1,100)))
  resu=(100-rescalonado)
  resu[resu == 0] =1
  print(resu)
}
resitencia(razao)

100-teste
m <- c(0, 1, 0.17,  1, 2, 0.89,  2, 3, 0, 3,4 ,0,4,5,0,5,6,0.2,6,7,0.02,7,8,1,8,9,0.1)
rclmat <- matrix(m, ncol=3, byrow=TRUE)
rclmat
rc <- reclassify(mapa, rclmat)
rc
plot(rc)

