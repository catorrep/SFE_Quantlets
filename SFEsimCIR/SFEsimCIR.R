# clear variables and close windows
rm(list = ls(all = TRUE))
graphics.off()


# set parameters for the simulation
T.obs = 360
alpha = 5
mu    = 1
sigma = 0.2

dt = 1/T.obs

# initial value of X (X_0):
X = mu

# we set a seed to assure that this simmulation can be reproduced
set.seed(123) 

# simulates a mean reverting square root process around mu
for (i in 1:T.obs) {
  dW = rnorm(1) * sqrt(dt)
  dX = alpha * (mu - X[i]) * dt + sigma * sqrt(abs(X[i])) * dW
  X  = c(X, X[i] + dX)
}
  
X = X[-1]

# plot
plot(X, main = 'Simulated CIR process', xlab = 't', ylab = expression(X[t]), type = "l", col = "blue3", lwd = 2)
