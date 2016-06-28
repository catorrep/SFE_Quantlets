# clear variables and close windows
rm(list = ls(all = TRUE))
graphics.off()

# set working directory
# setwd("C:/...")
setwd("D:/Trabajo HU/SFE5dim")

# load libraries
# install and load packages
libraries = c("data.table", "fGarch")
lapply(libraries, function(x) if (!(x %in% installed.packages())) {
  install.packages(x)
})
lapply(libraries, library, quietly = TRUE, character.only = TRUE)

# load data
dataset = fread("2004-2014_dax_ftse.csv", select =  c( "BAYER", "DEUTSCHE TELEKOM", "VOLKSWAGEN"))
dataset = as.data.frame(dataset)

# the entries of this data frame will be replaced by the log-returns
X = dataset[-1,]

# number of observations
obs = nrow(dataset)

# log-returns
for (i in seq_len(ncol(dataset))) {
  X[,i] = log(dataset[-1,i]/dataset[-obs,i])
}

garchModel = lapply(X, 
                    function(x){
                      garchFit(~garch(1, 1), data = x, trace = F)
                    })

eps = lapply(garchModel, 
             function(x){
               x@residuals/x@sigma.t
             })


panel.cor <- function(x, y, pch)
{
  par(usr = c(-0.01, 1.01, -0.01, 1.01))
  x = rank(x) / (length(x) + 1)
  y = rank(y) / (length(y) + 1)
  points(x, y, pch = pch)
}

pairs(eps, lower.panel = panel.cor, pch = 20)
