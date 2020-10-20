require(adehabitatHR)
require(sp)
require(raster)
require(SiMRiv)
require(adehabitatLT)

###abrindo arquivo
#Raster de resist6encia de cada bicho
mapa=raster(file.choose())
NAvalue(mapa)<- 0
crs(mapa)=("+proj=utm +zone=22+south+datum=WGS84")
## Example dataset used by Benhamou (2011)
data(pheasant)
## Second order habitat selection
## Selection of home range within the
## study area (example of parametric test)
pheana2 <- compana(pheasant$mcp, pheasant$studyarea,
                   test = "parametric")
pheana2
## The ranking matrix:
print(pheana2$rm, quote = FALSE)
## Third order habitat selection
## (relocation within home range)
## We remove the first pheasant of the analysis
## (as in the paper of Aebischer et al.)
## before the analysis
pheana3 <- compana(pheasant$locs[-1,], pheasant$mcp[-1,c(1,2,4)])
pheana3
data(pheasant)
## Second order habitat selection
## Selection of home range within the
## study area (example of parametric test)
pheana2 <- compana(pheasant$mcp, pheasant$studyarea,
                   test = "parametric")
pheana2
## The ranking matrix:
print(pheana2$rm, quote = FALSE)
## Third order habitat selection
## (relocation within home range)
## We remove the first pheasant of the analysis
## (as in the paper of Aebischer et al.)
## before the analysis
pheana3 <- compana(pheasant$locs[-1,], pheasant$mcp[-1,c(1,2,4)])
pheana3