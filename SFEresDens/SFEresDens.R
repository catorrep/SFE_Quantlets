# clear variables and close windows
rm(list = ls(all = TRUE))
graphics.off()

# set working directory
# setwd("C:/...")
setwd("D:/Trabajo HU")

# install and load packages
libraries = c("data.table", "fGarch")
lapply(libraries, function(x) if (!(x %in% installed.packages())) {
  install.packages(x)
})
lapply(libraries, library, quietly = TRUE, character.only = TRUE)

# load data
dataset = fread("2004-2014_dax_ftse.csv", select =  c("DEUTSCHE TELEKOM", "VOLKSWAGEN"))
dataset = as.data.frame(dataset)

# the entries of this data frame will be replaced by the log-returns
X = dataset[-1,]

# number of observations
obs = nrow(dataset)

# log-returns
for (i in seq_len(ncol(dataset))) {
  X[,i] = log(dataset[-1, i] / dataset[-obs, i])
}

garchModel = lapply(X, 
                    function(x){
                      garchFit(~garch(1, 1), data = x, trace = F)
                    })

eps = lapply(garchModel, 
             function(x){
               x@residuals/x@sigma.t
             })

eps = as.data.frame(eps)

means = colMeans(eps)
sds   = sapply(eps, sd)

# Plot: kernel density estimator of the residuals and of the normal density
layout(matrix(1:ncol(X), 1, ncol(X), byrow = TRUE))
for(i in 1:ncol(X)){
  par(mai = c(1, 0.8, 0.2, 0.1)) 
  plot(density(eps[[i]], kernel = "biweight"), main = "", xlab = "x",  ylab = "f(x)", col = "blue", lwd = 2)
  x.norm = seq(means[i] - 6*sds[i], means[i] + 6*sds[i], length.out = 100)
  y.norm = dnorm(x.norm, means[i], sds[i])
  lines(x.norm, y.norm, col = "red", type = "l", lwd = 2)
}
dev.off()
