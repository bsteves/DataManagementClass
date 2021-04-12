##########################
# Douglas.R
# Harold S.J. Zald
# February 10th, 2018
# This R script includes all statistical analyses and plots in manuscript

# load RData file containing two dataframes
load("Douglas.RData")

# douglas.fire.progression.rdnbdr.wx
# dataframe of daily hectares burned daily mean RdNBR and daily fire weather variables 

# blm.pi.sample.allvars.xy.df
# dataframe of plot RdNBR and predictor variables

##########################################
# fire severity in relation to CALVERT RAWS station Wx
# regressions of daily mean RdNBR  in relation to individual fire weather (Wx) variables
attach(douglas.fire.progression.rdnbdr.wx)
lm1 <- lm(rdnbr_mean ~  I(WindMinBP^2))
lm2 <- lm(rdnbr_mean ~  I(WindMaxBP^2))
lm3 <- lm(rdnbr_mean ~  I(TempMax^2))
lm4 <- lm(rdnbr_mean  ~  log(RhMinBP))
lm5 <- lm(rdnbr_mean ~  I(ERCMeanBP^2))
lm6 <- lm(rdnbr_mean ~  I(SCMeanBP^2))
lm7 <- lm(rdnbr_mean ~  I(BIMeanBP^2))
lm8 <- lm(rdnbr_mean ~  1)
detach(douglas.fire.progression.rdnbdr.wx)

# get adjR2 AIC deltaAIC L and w for models
lm1.adj.rsq <- summary(lm1)$adj.r.squared
lm2.adj.rsq <- summary(lm2)$adj.r.squared
lm3.adj.rsq <- summary(lm3)$adj.r.squared
lm4.adj.rsq <- summary(lm4)$adj.r.squared
lm5.adj.rsq <- summary(lm5)$adj.r.squared
lm6.adj.rsq <- summary(lm6)$adj.r.squared
lm7.adj.rsq <- summary(lm7)$adj.r.squared
lm8.adj.rsq <- summary(lm8)$adj.r.squared

# merge adjusted R2 values into a vector
adj.rsq.rdnbr <- c(lm1.adj.rsq, lm2.adj.rsq, lm3.adj.rsq, lm4.adj.rsq, lm5.adj.rsq, lm6.adj.rsq, lm7.adj.rsq, lm8.adj.rsq)

# get AIC for all models
lm1.aic <- AIC(lm1)
lm2.aic <- AIC(lm2)
lm3.aic <- AIC(lm3)
lm4.aic <- AIC(lm4)
lm5.aic <- AIC(lm5)
lm6.aic <- AIC(lm6)
lm7.aic <- AIC(lm7)
lm8.aic <- AIC(lm8)

# merge AIC values into a vector
AIC.rdnbr <- c(lm1.aic, lm2.aic, lm3.aic, lm4.aic, lm5.aic, lm6.aic, lm7.aic, lm8.aic)

# create vectors of  model predictor nparameters deltaAIC L and w
model.terms <- c("WindMinBP^2", "WindMaxBP^2", "TempMax", "LogRHMinBP","ERCMeanBP^2", "SCMeanBP^2", "BIMeanBP^2", "NULL")
n.parms <- c(1,1,1,1,1,1,1,1)
delta.AIC <- AIC.rdnbr - min(AIC.rdnbr)
L <- exp(-(1/2)*delta.AIC)
w <- L/(sum(L))

# merge into dataframe and sort by deltaAIC
rdnbr.Wx.lm.models <- data.frame(model.terms, n.parms, adj.rsq.rdnbr, AIC.rdnbr, delta.AIC, L, w)
rdnbr.Wx.lm.models <- rdnbr.Wx.lm.models[order(rdnbr.Wx.lm.models$delta.AIC),]
rdnbr.Wx.lm.models

###############################################
# summary stats (mean and standard deviation) of response and predictor variables by ownership
# response variable: RdNBR
# predictor variables: age biomass elevation tpi-fine slope heatload bi

# install and load plyr package
install.packages("plyr")
library(plyr)

blm.pi.sample.summary.stats <- ddply(blm.pi.sample.allvars.xy.df, .(Ownership), summarize,
                                          RdNBR_mean = mean(RdNBR, na.rm = TRUE),
                                          RdNBR_sd = sd(RdNBR, na.rm = TRUE),
                                          Biomass_mean = mean(Biomass, na.rm = TRUE),
                                          Biomass_sd = sd(Biomass, na.rm = TRUE),
                                          Age_mean = mean(Age, na.rm = TRUE),
                                          Age_sd = sd(Age, na.rm = TRUE),
                                          Elevation_mean = mean(Elevation, na.rm = TRUE),
                                          Elevation_sd = sd(Elevation, na.rm = TRUE),
                                          TPI_fine_mean = mean(TPI_fine, na.rm = TRUE),
                                          TPI_fine_sd = sd(TPI_fine, na.rm = TRUE),
                                          TPI_coarse_mean = mean(TPI_coarse, na.rm = TRUE),
                                          TPI_coarse_sd = sd(TPI_coarse, na.rm = TRUE),
                                          Heatload_mean = mean(Heatload, na.rm = TRUE),
                                          Heatload_sd = sd(Heatload, na.rm = TRUE),
                                          Slope_mean = mean(Slope, na.rm = TRUE),
                                          Slope_sd = sd(Slope, na.rm = TRUE),
                                          BI_mean = mean(BI_mean_bp, na.rm = TRUE),
                                          BI_sd = sd(BI_mean_bp, na.rm = TRUE))
blm.pi.sample.summary.stats

# Mann-Whitney-Wilcoxon Test of differences in distributions of response and predictor variables between ownerships
W.RdNBR <- wilcox.test(RdNBR ~ Ownership, data=blm.pi.sample.allvars.xy.df, paired = FALSE, conf.int = TRUE) 
W.Biomass <- wilcox.test(Biomass ~ Ownership, data=blm.pi.sample.allvars.xy.df, paired = FALSE, conf.int = TRUE) 
W.Age <- wilcox.test(Age ~ Ownership, data=blm.pi.sample.allvars.xy.df) 
W.Elevation <- wilcox.test(Elevation ~ Ownership, data=blm.pi.sample.allvars.xy.df) 
W.TPI.Fine <- wilcox.test(TPI_fine ~ Ownership, data=blm.pi.sample.allvars.xy.df) 
W.Heatload <- wilcox.test(Heatload ~ Ownership, data=blm.pi.sample.allvars.xy.df)
W.Slope <- wilcox.test(Slope ~ Ownership, data=blm.pi.sample.allvars.xy.df) 
W.BI <- wilcox.test(BI_mean_bp ~ Ownership, data=blm.pi.sample.allvars.xy.df) 

# merge test results into single dataframe
W.name <- c(W.RdNBR$data.name, W.Biomass$data.name, W.Age$data.name, W.Elevation$data.name, W.TPI.Fine$data.name,
            W.Heatload$data.name, W.Slope$data.name, W.BI$data.name)
W.statistic <- c(W.RdNBR$statistic, W.Biomass$statistic, W.Age$statistic, W.Elevation$statistic, W.TPI.Fine$statistic, 
                 W.Heatload$statistic, W.Slope$statistic, W.BI$statistic)
W.pvalue <- c(W.RdNBR$p.value, W.Biomass$p.value, W.Age$p.value, W.Elevation$p.value, W.TPI.Fine$p.value, 
              W.Heatload$p.value, W.Slope$p.value, W.BI$p.value)
W.combined <- data.frame(W.name, W.statistic, W.pvalue)
W.combined 


###############
# Random Forest Analysis
# response variable: RdNBR
# forest explanatory variables: ownership age biomass
# topo explanatory variables: elevation slope tpi15030 heatload
# wx explanotry variables: burn period mean ERC burn period mean SC burn period mean BI
# Two step variable selection using VSRUF package

# install and load packages
install.packages("randomForest","VSURF")
library(randomForest)
library(VSURF)

# remove xy coordinates from dataframe
blm.pi.sample.allvars.df <- blm.pi.sample.allvars.xy.df[,c(-11:-12)]

# make ownership a factor
blm.pi.sample.allvars.df$Ownership <- as.factor(blm.pi.sample.allvars.df$Ownership)

# subset samples by ownership
blm.sample.allvars.df <- subset(blm.pi.sample.allvars.df, Ownership == 0)
pi.sample.allvars.df <- subset(blm.pi.sample.allvars.df, Ownership == 1)

# make lists of x and y variables for VSURF
x <- blm.pi.sample.allvars.df[,c("Ownership","Age","Biomass","Elevation","Slope","TPI_fine","Heatload","BI_mean_bp")]
x$Ownership <- as.numeric(as.character(x$Ownership))
y <- blm.pi.sample.allvars.df[,c("RdNBR")]
blm.pi.vars.list <- list(x, y)
names(blm.pi.vars.list) <- c("x","y")

x <- blm.sample.allvars.df[,c("Age","Biomass","Elevation","Slope","TPI_fine","Heatload","BI_mean_bp")]
y <- blm.sample.allvars.df[,c("RdNBR")]
blm.vars.list <- list(x, y)
names(blm.vars.list) <- c("x","y")

x <- pi.sample.allvars.df[,c("Age","Biomass","Elevation","Slope","TPI_fine","Heatload","BI_mean_bp")]
y <- pi.sample.allvars.df[,c("RdNBR")]
pi.vars.list <- list(x, y)
names(pi.vars.list) <- c("x","y")

# two step variable selectiom for interpretation with VSURF package
# set seed
set.seed(41)

# all ownerships
blm.pi.vsurf <- VSURF(x = blm.pi.vars.list$x, y = blm.pi.vars.list$y)
blm.pi.thres <- VSURF_thres(x = blm.pi.vars.list$x, y = blm.pi.vars.list$y)
blm.pi.interp <- VSURF_interp(x = blm.pi.vars.list$x, y = blm.pi.vars.list$y, vars = blm.pi.thres$varselect.thres)
blm.pi.pred <- VSURF_pred(blm.pi.vars.list$x, blm.pi.vars.list$y,
                               err.interp = blm.pi.interp$err.interp,
                               varselect.interp = blm.pi.interp$varselect.interp)
# BLM ownership 
blm.vsurf <- VSURF(x = blm.vars.list$x, y = blm.vars.list$y)
blm.thres <- VSURF_thres(x = blm.vars.list$x, y = blm.vars.list$y)
blm.interp <- VSURF_interp(x = blm.vars.list$x, y = blm.vars.list$y, vars = blm.thres$varselect.thres)
blm.pred <- VSURF_pred(blm.vars.list$x, blm.vars.list$y,
                               err.interp = blm.interp$err.interp,
                               varselect.interp = blm.interp$varselect.interp)
# private ownership 
pi.vsurf <- VSURF(x = pi.vars.list$x, y = pi.vars.list$y)
pi.thres <- VSURF_thres(x = pi.vars.list$x, y = pi.vars.list$y)
pi.interp <- VSURF_interp(x = pi.vars.list$x, y = pi.vars.list$y, vars = pi.thres$varselect.thres)
pi.pred <- VSURF_pred(pi.vars.list$x, pi.vars.list$y,
                            err.interp = pi.interp$err.interp,
                            varselect.interp = pi.interp$varselect.interp)

##############################################################
# random forest models with all variables 
set.seed(41)

# all ownerships
blm.pi.rf <-randomForest(RdNBR ~ Ownership + Age + Biomass + Elevation + Slope + TPI_fine + Heatload + BI_mean_bp,
                              data = blm.pi.sample.allvars.df,
                              ntree= 1500, mtry = 5, importance = TRUE, replace = FALSE)
# BLM ownership
blm.rf <-randomForest(RdNBR ~ Age + Biomass + Elevation + Slope + TPI_fine + Heatload + BI_mean_bp,
                           data = blm.sample.allvars.df,
                           ntree= 1500, mtry = 5, importance = TRUE, replace = FALSE)
# private ownership
pi.rf <-randomForest(RdNBR ~ Age + Biomass + Elevation + Slope + TPI_fine + Heatload + BI_mean_bp,
                          data = pi.sample.allvars.df,
                          ntree= 1500, mtry = 5, importance = TRUE, replace = FALSE)

# variable importance values from random forest models
blm.pi.rf.imp <- importance(blm.pi.rf, type =1 , scale = TRUE)
blm.rf.imp <- importance(blm.rf , type =1 , scale = TRUE)
pi.rf.imp <- importance(pi.rf , type =1 , scale = TRUE)

# create variable importance plots for all three random forest models
# color coded by selected versus removed variables based on VSRUF interp model
par(mfrow=c(1,3),oma=c(0,0,0,0),mar=c(4,1,2,1)) 
dotchart(sort(blm.pi.rf.imp[,1],), labels = c("Slope","Heatload","Elevation","Biomass","TPI-Fine","Ownership","Age","BI"),
         pch = c(1,rep(16, time = 7)), cex =1, cex.main = 0.9, col = "black", main = "Entire Douglas Complex", xlab = "% increase in MSE")
dotchart(sort(blm.rf.imp[,1]), labels = c("Biomass","Slope","TPI-Fine","Heatload","Elevation","Age","BI"),
         pch = c(1,1,rep(16, time = 5)), cex =1, cex.main = 0.9, col = "black", main = "BLM", xlab = "% increase in MSE")
dotchart(sort(pi.rf.imp[,1]), labels = c("Biomass","Slope","Age","Elevation","Heatload","TPI-Fine","BI"),
         pch = c(16,1,rep(16, time = 5)), cex =1, cex.main = 0.9, col = "black", main = "PI", xlab = "% increase in MSE")

##############################
# rerun random forest with only variables selected in VSRUF interp
set.seed(41)

# all ownerships
blm.pi.rf.2 <-randomForest(RdNBR ~ Ownership + Age + Biomass + Elevation + TPI_fine + Heatload + BI_mean_bp,
                                data = blm.pi.sample.allvars.df,
                                ntree= 1500, mtry = 5, importance = TRUE, replace = FALSE)
# BLM ownership
blm.rf.2 <-randomForest(RdNBR ~ Age + Elevation + TPI_fine + Heatload + BI_mean_bp,
                             data = blm.sample.allvars.df,
                             ntree= 1500, mtry = 5, importance = TRUE, replace = FALSE)
# private ownership
pi.rf.2 <-randomForest(RdNBR ~ Age + Biomass + Elevation + TPI_fine + Heatload + BI_mean_bp,
                            data = pi.sample.allvars.df,
                            ntree= 1500, mtry = 5, importance = TRUE, replace = FALSE)

# variable importance values for random forest models with selected variables 
blm.pi.rf.2.imp <- importance(blm.pi.rf.2 , type =1 , scale = TRUE)
blm.rf.2.imp <- importance(blm.rf.2 , type =1 , scale = TRUE)
pi.rf.2.imp <- importance(pi.rf.2 , type =1 , scale = TRUE)


# create data for partial dependency plots individually for each explanatory variable
# merge into a single df 
# all ownerships 
blm.pi.pdp.1 <- partialPlot(blm.pi.rf.2, blm.pi.sample.allvars.df, BI_mean_bp, plot=FALSE)
blm.pi.pdp.2 <- partialPlot(blm.pi.rf.2, blm.pi.sample.allvars.df, Age, plot=FALSE)
blm.pi.pdp.3 <- partialPlot(blm.pi.rf.2, blm.pi.sample.allvars.df, Elevation, plot=FALSE)
blm.pi.pdp.4 <- partialPlot(blm.pi.rf.2, blm.pi.sample.allvars.df, TPI_fine, plot=FALSE)
blm.pi.pdp.5 <- partialPlot(blm.pi.rf.2, blm.pi.sample.allvars.df, Biomass, plot=FALSE)
blm.pi.pdp.6 <- partialPlot(blm.pi.rf.2, blm.pi.sample.allvars.df, Heatload, plot=FALSE)
blm.pi.pdp <- data.frame(blm.pi.pdp.1, blm.pi.pdp.2, blm.pi.pdp.3,
                              blm.pi.pdp.4, blm.pi.pdp.5, blm.pi.pdp.6)
names(blm.pi.pdp) <- c("BI_mean_bp","RdNBR_BI_mean_bp","Age","RdNBR_Age",
                            "Elevation","RdNBR_Elevation","TPI_fine","RdNBR_TPI_fine",
                            "Biomass","RdNBR_Biomass","Heatload","RdNBR_Heatload")

# BLM ownership 
blm.pdp.1 <- partialPlot(blm.rf.2, blm.sample.allvars.df, BI_mean_bp, plot=FALSE)
blm.pdp.2 <- partialPlot(blm.rf.2, blm.sample.allvars.df, Age, plot=FALSE)
blm.pdp.3 <- partialPlot(blm.rf.2, blm.sample.allvars.df, Elevation, plot=FALSE)
blm.pdp.4 <- partialPlot(blm.rf.2, blm.sample.allvars.df, TPI_fine, plot=FALSE)
blm.pdp.5 <- partialPlot(blm.rf.2, blm.sample.allvars.df, Heatload, plot=FALSE)
blm.pdp <- data.frame(blm.pdp.1, blm.pdp.2, blm.pdp.3,
                           blm.pdp.4, blm.pdp.5)
names(blm.pdp) <- c("BI_mean_bp","RdNBR_BI_mean_bp","Age","RdNBR_Age",
                         "Elevation","RdNBR_Elevation","TPI_fine","RdNBR_TPI_fine","Heatload","RdNBR_Heatload" )

# private ownership 
pi.pdp.1 <- partialPlot(pi.rf.2, pi.sample.allvars.df, BI_mean_bp, plot=FALSE)
pi.pdp.2 <- partialPlot(pi.rf.2, pi.sample.allvars.df, Age, plot=FALSE)
pi.pdp.3 <- partialPlot(pi.rf.2, pi.sample.allvars.df, Elevation, plot=FALSE)
pi.pdp.4 <- partialPlot(pi.rf.2, pi.sample.allvars.df, TPI_fine, plot=FALSE)
pi.pdp.5 <- partialPlot(pi.rf.2, pi.sample.allvars.df, Biomass, plot=FALSE)
pi.pdp.6 <- partialPlot(pi.rf.2, pi.sample.allvars.df, Heatload, plot=FALSE)
pi.pdp <- data.frame(pi.pdp.1, pi.pdp.2, pi.pdp.3,
                          pi.pdp.4, pi.pdp.5, pi.pdp.6)
names(pi.pdp) <- c("BI_mean_bp","RdNBR_BI_mean_bp","Age","RdNBR_Age",
                        "Elevation","RdNBR_Elevation","TPI_fine","RdNBR_TPI_fine","Biomass","RdNBR_Biomass","Heatload","RdNBR_Heatload" )


# plot random forest partial dependency plots with plot frequency histograms
# this is only for variables that were slected by VSURF interperature procedure 
par(mfrow = c(3,6),
    oma = c(5,4,0,1) + 1,
    mar = c(0,0,1,1) + 1,
    mgp = c(3,1,0),
    xpd = NA,
    ps = 10, cex = 1, cex.axis = 0.75)

# all ownership 
h <- hist(blm.pi.sample.allvars.df$BI_mean_bp, breaks = seq(0,90,10), plot=FALSE)
barplot(h$density, col = "gray", border = "gray", space = c(0,0), ylim=c(0,0.10), axes = FALSE)
axis(4,pretty(range(h$density),4))
par(new=TRUE)
plot(blm.pi.pdp$RdNBR_BI_mean_bp ~ blm.pi.pdp$BI_mean_bp, type = 'l', lwd =2, ylim = c(200,700),
     xlim = c(min(blm.pi.sample.allvars.df$BI_mean_bp),max(blm.pi.sample.allvars.df$BI_mean_bp)),
     main = "BI", ylab = "BLM & PI RdNBR (N = 1090)", xaxt = 'n', xlab = "")
mtext(paste("VI","=",round(blm.pi.rf.2.imp[7],1)), side = 3, adj=0, line =-1.5, at = 25, cex =0.8)

h <- hist(blm.pi.sample.allvars.df$Age, breaks = seq(0,275,25), plot=FALSE)
barplot(h$density, col = "gray", border = "gray", space = c(0,0), ylim=c(0,0.03), axes = FALSE)
axis(4,pretty(range(h$density),4))
par(new=TRUE)
plot(blm.pi.pdp$RdNBR_Age ~ blm.pi.pdp$Age, type = 'l', lwd =2, ylim = c(200,700),
     xlim = c(min(blm.pi.sample.allvars.df$Age),max(blm.pi.sample.allvars.df$Age)),
     main = "Stand Age", ylab='', yaxt = 'n', xaxt = 'n', xlab = "")
mtext(paste("VI","=",round(blm.pi.rf.2.imp[2],1)), side = 3, adj=0, line =-1.5, at = 20, cex =0.8)

h <- hist(blm.pi.sample.allvars.df$Biomass, breaks = seq(0,550,50), plot=FALSE)
barplot(h$density, col = "gray", border = "gray", space = c(0,0), ylim=c(0,0.015), axes = FALSE)
axis(4,pretty(range(h$density),4))
par(new=TRUE)
plot(blm.pi.pdp$RdNBR_Biomass ~ blm.pi.pdp$Biomass, type = 'l', lwd =2, ylim = c(200,700),
     xlim = c(min(blm.pi.sample.allvars.df$Biomass),max(blm.pi.sample.allvars.df$Biomass)),
     main = "Biomass", ylab='', yaxt = 'n', xaxt = 'n',xlab = "")
mtext(paste("VI","=",round(blm.pi.rf.2.imp[3],1)), side = 3, adj=0, line =-1.5, at = 50, cex =0.8)

h <- hist(blm.pi.sample.allvars.df$TPI_fine, breaks = seq(-90,90,10), plot=FALSE)
barplot(h$density, col = "gray", border = "gray", space = c(0,0), ylim=c(0,0.04), axes = FALSE)
axis(4,pretty(range(h$density),4))
par(new=TRUE)
plot(blm.pi.pdp$RdNBR_TPI_fine ~ blm.pi.pdp$TPI_fine, type = 'l', lwd =2, ylim = c(200,700),
     xlim = c(min(blm.pi.sample.allvars.df$TPI_fine),max(blm.pi.sample.allvars.df$TPI_fine)),
     main = "TPI fine", ylab='', yaxt = 'n', xaxt = 'n', xlab = "")
mtext(paste("VI","=",round(blm.pi.rf.2.imp[5],1)), side = 3, adj=0, line =-1.5, at = -75, cex =0.8)

h <- hist(blm.pi.sample.allvars.df$Elevation, breaks = seq(225,1150,50), plot=FALSE)
barplot(h$density, col = "gray", border = "gray", space = c(0,0), ylim=c(0,0.01), axes = FALSE)
axis(4,pretty(range(h$density),4))
par(new=TRUE)
plot(blm.pi.pdp$RdNBR_Elevation ~ blm.pi.pdp$Elevation, type = 'l', lwd =2, ylim = c(200,700),
     xlim = c(min(blm.pi.sample.allvars.df$Elevation),max(blm.pi.sample.allvars.df$Elevation)),
     main = "Elevation", ylab='', yaxt = 'n', xaxt = 'n',xlab = "")
mtext(paste("VI","=",round(blm.pi.rf.2.imp[4],1)), side = 3, adj=0, line =-1.5, at = 275, cex =0.8)

h <- hist(blm.pi.sample.allvars.df$Heatload, breaks = seq(0.2,1.1,0.05), plot=FALSE)
barplot(h$density, col = "gray", border = "gray", space = c(0,0), ylim=c(0,7), axes = FALSE)
axis(4,pretty(range(h$density),4))
par(new=TRUE)
plot(blm.pi.pdp$RdNBR_Heatload ~ blm.pi.pdp$Heatload, type = 'l', lwd =2, ylim = c(200,700),
     xlim = c(min(blm.pi.sample.allvars.df$Heatload),max(blm.pi.sample.allvars.df$Heatload)),
     main = "Heatload", ylab='', yaxt = 'n', xaxt = 'n',xlab = "")
mtext(paste("VI","=",round(blm.pi.rf.2.imp[6],1)), side = 3, adj=0, line =-1.5, at = 0.3, cex =0.8)

# BLM ownership 
h <- hist(blm.sample.allvars.df$BI_mean_bp, breaks = seq(0,90,10), plot=FALSE)
barplot(h$density, col = "gray", border = "gray", space = c(0,0), ylim=c(0,0.1), axes = FALSE)
axis(4,pretty(range(h$density),4))
par(new=TRUE)
plot(blm.pdp$RdNBR_BI_mean_bp ~ blm.pdp$BI_mean_bp, type = 'l', lwd =2, ylim = c(200,700),
     xlim = c(min(blm.pi.sample.allvars.df$BI_mean_bp),max(blm.pi.sample.allvars.df$BI_mean_bp)),
     main = "", ylab = "BLM RdNBR (N = 571)", xaxt = 'n', xlab = "")
mtext(paste("VI","=",round(blm.rf.2.imp[5],1)), side = 3, adj=0, line =-1.5, at = 25, cex =0.8)

h <- hist(blm.sample.allvars.df$Age, breaks = seq(0,275,25), plot=FALSE)
barplot(h$density, col = "gray", border = "gray", space = c(0,0), ylim=c(0,0.03), axes = FALSE)
axis(4,pretty(range(h$density),4))
par(new=TRUE)
plot(blm.pdp$RdNBR_Age ~ blm.pdp$Age, type = 'l', lwd =2, ylim = c(200,700),
     xlim = c(min(blm.pi.sample.allvars.df$Age),max(blm.pi.sample.allvars.df$Age)),
     main = "", ylab='', yaxt = 'n', xaxt = 'n', xlab = "")
mtext(paste("VI","=",round(blm.rf.2.imp[1],1)), side = 3, adj=0, line =-1.5, at = 20, cex =0.8)

##biomass is empty panel b/c removed via VSRUF
##just make an empty figure
barplot(h$density, col = "white", border = "white", space = c(0,0), ylim=c(0,0.03), axes = FALSE)

h <- hist(blm.sample.allvars.df$TPI_fine, breaks = seq(-90,90,10), plot=FALSE)
barplot(h$density, col = "gray", border = "gray", space = c(0,0), ylim=c(0,0.04), axes = FALSE)
axis(4,pretty(range(h$density),4))
par(new=TRUE)
plot(blm.pdp$RdNBR_TPI_fine ~ blm.pdp$TPI_fine, type = 'l', lwd =2, ylim = c(200,700),
     xlim = c(min(blm.pi.sample.allvars.df$TPI_fine),max(blm.pi.sample.allvars.df$TPI_fine)),
     main = "", ylab='', yaxt = 'n', xaxt = 'n', xlab = "")
mtext(paste("VI","=",round(blm.rf.2.imp[3],1)), side = 3, adj=0, line =-1.5, at = -75, cex =0.8)

h <- hist(blm.sample.allvars.df$Elevation, breaks = seq(225,1150,50), plot=FALSE)
barplot(h$density, col = "gray", border = "gray", space = c(0,0), ylim=c(0,0.01), axes = FALSE)
axis(4,pretty(range(h$density),4))
par(new=TRUE)
plot(blm.pdp$RdNBR_Elevation ~ blm.pdp$Elevation, type = 'l', lwd =2, ylim = c(200,700),
     xlim = c(min(blm.pi.sample.allvars.df$Elevation),max(blm.pi.sample.allvars.df$Elevation)),
     main = "", ylab='', yaxt = 'n', xaxt = 'n',xlab = "")
mtext(paste("VI","=",round(blm.rf.2.imp[2],1)), side = 3, adj=0, line =-1.5, at = 275, cex =0.8)

h <- hist(blm.sample.allvars.df$Heatload, breaks = seq(0.2,1.1,0.05), plot=FALSE)
barplot(h$density, col = "gray", border = "gray", space = c(0,0), ylim=c(0,8), axes = FALSE)
axis(4,pretty(range(h$density),4))
par(new=TRUE)
plot(blm.pdp$RdNBR_Heatload ~ blm.pdp$Heatload, type = 'l', lwd =2, ylim = c(200,700),
     xlim = c(min(blm.pi.sample.allvars.df$Heatload),max(blm.pi.sample.allvars.df$Heatload)),
     main = "", ylab='', yaxt = 'n', xaxt = 'n',xlab = "")
mtext(paste("VI","=",round(blm.rf.2.imp[4],1)), side = 3, adj=0, line =-1.5, at = 0.3, cex =0.8)

# private ownership 
h <- hist(pi.sample.allvars.df$BI_mean_bp, breaks = seq(0,90,10), plot=FALSE)
barplot(h$density, col = "gray", border = "gray", space = c(0,0), ylim=c(0,0.1), axes = FALSE)
axis(4,pretty(range(h$density),4))
par(new=TRUE)
plot(pi.pdp$RdNBR_BI_mean_bp ~ pi.pdp$BI_mean_bp, type = 'l', lwd =2, ylim = c(200,700),
     xlim = c(min(blm.pi.sample.allvars.df$BI_mean_bp),max(blm.pi.sample.allvars.df$BI_mean_bp)),
     main = "", ylab = "PI RdNBR (N = 519)", xlab = "Index")
mtext(paste("VI","=",round(pi.rf.2.imp[6],1)), side = 3, adj=0, line =-1.5, at = 25, cex =0.8)

h <- hist(pi.sample.allvars.df$Age, breaks = seq(0,275,25), plot=FALSE)
barplot(h$density, col = "gray", border = "gray", space = c(0,0), ylim=c(0,0.03), axes = FALSE)
axis(4,pretty(range(h$density),4))
par(new=TRUE)
plot(pi.pdp$RdNBR_Age ~ pi.pdp$Age, type = 'l', lwd =2, ylim = c(200,700),
     xlim = c(min(blm.pi.sample.allvars.df$Age),max(blm.pi.sample.allvars.df$Age)),
     main = "", ylab='', yaxt = 'n', xlab = "Years")
mtext(paste("VI","=",round(pi.rf.2.imp[1],1)), side = 3, adj=0, line =-1.5, at = 20, cex =0.8)

h <- hist(pi.sample.allvars.df$Biomass, breaks = seq(0,275,25), plot=FALSE)
barplot(h$density, col = "gray", border = "gray", space = c(0,0), ylim=c(0,0.03), axes = FALSE)
axis(4,pretty(range(h$density),4))
par(new=TRUE)
plot(pi.pdp$RdNBR_Age ~ pi.pdp$Age, type = 'l', lwd =2, ylim = c(200,700),
     xlim = c(min(pi.sample.allvars.df$Age),max(pi.sample.allvars.df$Age)),
     main = "", ylab='', yaxt = 'n', xlab = "Years")
mtext(paste("VI","=",round(pi.rf.2.imp[2],1)), side = 3, adj=0, line =-1.5, at = 20, cex =0.8)

h <- hist(pi.sample.allvars.df$TPI_fine, breaks = seq(-90,90,10), plot=FALSE)
barplot(h$density, col = "gray", border = "gray", space = c(0,0), ylim=c(0,0.04), axes = FALSE)
axis(4,pretty(range(h$density),4))
par(new=TRUE)
plot(pi.pdp$RdNBR_TPI_fine ~ pi.pdp$TPI_fine, type = 'l', lwd =2, ylim = c(200,700),
     xlim = c(min(blm.pi.sample.allvars.df$TPI_fine),max(blm.pi.sample.allvars.df$TPI_fine)),
     main = "", ylab='', yaxt = 'n', xlab = "Index")
mtext(paste("VI","=",round(pi.rf.2.imp[4],1)), side = 3, adj=0, line =-1.5, at = -75, cex =0.8)

h <- hist(pi.sample.allvars.df$Elevation, breaks = seq(225,1150,50), plot=FALSE)
barplot(h$density, col = "gray", border = "gray", space = c(0,0), ylim=c(0,0.01), axes = FALSE)
axis(4,pretty(range(h$density),4))
par(new=TRUE)
plot(pi.pdp$RdNBR_Elevation ~ pi.pdp$Elevation, type = 'l', lwd =2, ylim = c(200,700),
     xlim = c(min(blm.pi.sample.allvars.df$Elevation),max(blm.pi.sample.allvars.df$Elevation)),
     main = "", ylab='', yaxt = 'n', xlab = "Meters")
mtext(paste("VI","=",round(pi.rf.2.imp[3],1)), side = 3, adj=0, line =-1.5, at = 275, cex =0.8)

h <- hist(pi.sample.allvars.df$Heatload, breaks = seq(0.2,1.1,0.05), plot=FALSE)
barplot(h$density, col = "gray", border = "gray", space = c(0,0), ylim=c(0,6), axes = FALSE)
axis(4,pretty(range(h$density),4))
par(new=TRUE)
plot(pi.pdp$RdNBR_Heatload ~ pi.pdp$Heatload, type = 'l', lwd =2, ylim = c(200,700),
     xlim = c(min(blm.pi.sample.allvars.df$Heatload),max(blm.pi.sample.allvars.df$Heatload)),
     main = "", ylab='', yaxt = 'n',xlab = expression('MJ '*'cm'^2*' yr'^-1))
mtext(paste("VI","=",round(pi.rf.2.imp[5],1)), side = 3, adj=0, line =-1.5, at = 0.3, cex =0.8)


#############################################
# generalized least squares model 
# response variable: RdNBR
# forest explanatory variables: ownership age biomass
# age variable is age 
# topo explanatory variables: elevation slope tpi15030 heatload
# wx explanotry variables: burn period mean BI
# spatial exponential correlation structure
# the model is fit by maximizing the restricted loglikelihood

# install and load packages 
install.packages("nlme", "AICcmodavg")
library(nlme)
library(AICcmodavg)

##make ownership a factor
blm.pi.sample.allvars.xy.df$Ownership <- as.factor(blm.pi.sample.allvars.xy.df$Ownership)

# gls model
gls.1 <- gls(RdNBR ~ Age + BI_mean_bp + Ownership + Elevation + TPI_fine + Heatload + Slope + Biomass,
                  data = blm.pi.sample.allvars.xy.df, correlation=corExp(form = ~ X + Y), method = "REML")

# gls model coefficients
gls.1coeff <- summary(gls.1)$tTable

# get mean values of all explanaotry variables by ownership

blm.pi.sample.means <- ddply(blm.pi.sample.allvars.xy.df, .(Ownership), summarise,
                                  Age = mean(Age, na.rm = TRUE),
                                  BI_mean_bp = mean(BI_mean_bp, na.rm = TRUE),
                                  Elevation = mean(Elevation, na.rm = TRUE),
                                  TPI_fine = mean(TPI_fine, na.rm = TRUE),
                                  Heatload = mean(Heatload, na.rm = TRUE),
                                  Slope = mean(Slope, na.rm = TRUE),
                                  Biomass = mean(Biomass, na.rm = TRUE))

# convert ownership to numeric
blm.pi.sample.means$Ownership <- as.numeric(blm.pi.sample.means$Ownership)-1
blm.pi.sample.means$Ownership <- as.factor(blm.pi.sample.means$Ownership)

# predict RdNBR mean values by ownership while accoutning for mean values of covariates
gls.fit.sample <- data.frame(predictSE.gls(gls.1, blm.pi.sample.means, SE.fit = T))


# end of script