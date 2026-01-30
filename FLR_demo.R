## FLR Demo 23.01.24 https://flr-project.org/doc/A_quick_introduction_to_FLR.html

install.packages(c("latticeExtra", "gridExtra", "ggplot2", "triangle", "copula", "coda", "mgcv"))
install.packages(c("FLCore", "ggplotFL", "FLa4a", "FLBRP", "FLash"), repos="http://flr-project.org/R")

library(FLCore)
library(ggplotFL)
FLQuant(1:10)

flq <- FLQuant(rlnorm(60), dimnames=list(age=1:4, year=2012:2017), units="t")

flq
summary(flq)


flq[1,] <- 0
flq

flq * 10

flq + (flq * 0.20)


yearSums(flq)

dir <- tempdir()
download.file("http://www.flr-project.org/doc/src/ple4.csv.zip", file.path(dir, "ple4.csv.zip"))
unzip(file.path(dir, "ple4.csv.zip"), exdir=dir)


dat <- read.csv(file.path(dir, "ple4.csv"))
head(dat)


landn <- subset(dat, slot=="landings.n", select=-slot)


landsn <- as.FLQuant(landn)


plot(landsn)

nple4 <- as.FLStock(dat)

summary(nple4)

m(nple4) <- 0.1


m.spwn(nple4) <- harvest.spwn(nple4) <- 0

mat(nple4) <- c(0, 0.5, 0.5, rep(1, 7))


landings(nple4) <- computeLandings(nple4)
discards(nple4) <- computeDiscards(nple4)


catch(nple4) <- computeCatch(nple4, slot="all")

stock.wt(nple4) <- catch.wt(nple4)

range(nple4, c("minfbar", "maxfbar")) <- c(2, 6)

summary(nple4)

plot(metrics(nple4, Catch=catch, Landings=landings))

data(ple4.index)

summary(ple4.index)

plot(ple4.index)

library(FLa4a)

data(ple4)

fit <- sca(ple4, FLIndices(BTS=ple4.index))

summary(fit)

stk <- ple4 + fit
plot(stk)
