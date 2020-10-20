require(adehabitatHR)
## Example dataset used by Benhamou (2011)
data(buffalo)
## The trajectory:
buffalo$traj
## The habitat map:
buffalo$habitat
## Show the dataset
plot(buffalo$traj, spixdf = buffalo$habitat)
## Estimate the diffusion component for each habitat type
## Using the plug-in method
vv <- BRB.D(buffalo$traj, Tmax = 180*60, Lmin = 50,
            habitat = buffalo$habitat, activ = "act")
vv
## Note that the values are given here as m^2/s, whereas
## they are given as m^2/min in Benhamou (2011). The
## values in m^2 per min are:
vv[[1]][,2]*60
## Approximately the same values, with slight differences due to
## differences in the way the program of Benhamou (2011) and the present
## one deal with the relocations occurring on the boundary between two
## different habitat types
## Note that an alternative estimation of the Diffusion coefficient
## could be found using maximum likelihood
vv2 <- BRB.likD(buffalo$traj, Tmax = 180*60, Lmin = 50,
                habitat = buffalo$habitat, activ = "act")
vv2
vv[[1]][,2]*60
## Estimation of the UD with the same parameters as those chosen by
## Benhamou (2011)
ud <- BRB(buffalo$traj, D = vv, Tmax = 180*60, tau = 300, Lmin = 50, hmin=100,
          habitat = buffalo$habitat, activity = "act", grid = 50, b=0,
          same4all=FALSE, extent=0.5)
ud
## Show the UD.
image(ud)
## Not run:
## Example of the decomposition of the UD into a recursion distribution
## and a intensity distribution (Benhamou and Riotte-Lambert 2012).
##
## 1. Intensity Distribution using the same parameters as Benhamou and
## Riotte-Lambert (2012)
id <- BRB(buffalo$traj, D = 440/60, Tmax = 3*3600, Lmin = 50, type = "ID",
          hmin=100, radius = 300, maxt = 2*3600, activity="act", filtershort=FALSE,
          grid = 200, extent=0.1)
rd <- BRB(buffalo$traj, D = 440/60, Tmax = 3*3600, Lmin = 50, type = "RD",
          hmin=100, radius = 300, maxt = 2*3600, activity="act", filtershort=FALSE,
          grid = 200, extent=0.1)
ud <- BRB(buffalo$traj, D = 440/60, Tmax = 3*3600, Lmin = 50,
          hmin=100, radius = 300, maxt = 2*3600, activity="act", filtershort=FALSE,
          grid = 200, extent=0.1)
par(mfrow = c(2,2), mar=c(0,0,2,0))
image(getvolumeUD(id))
title("ID")
image(getvolumeUD(rd))
title("RD")
image(getvolumeUD(ud))
title("UD")