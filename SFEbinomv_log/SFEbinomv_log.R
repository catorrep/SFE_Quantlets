# clear variables and close windows
rm(list = ls(all = TRUE))
graphics.off()


# Set function 

SFEbinomv = function(n,k,p){

  if (n<=0){
    stop("please input n > 0!")
  }   
  if (k<=0){
    stop("please input k > 0!")
  }   
  if (p<=0|p>=1){
    stop("please choose p in the interval of (0,1)!")
  }   
  
  # make sure number of steps is integer
  n = floor(n) 
  
  # make sure number of path is integer
  k = floor(k) 
  
  
  set.seed(0)
  
  # generate n*k random numbers between 0 and 1
  z = matrix(runif(n*k), n, k)
  
  # scale ordinary binomial processes z (-1, 1)
  z1 = ((floor(-z+p)) + 0.5)*2          
  
  # end values of the k binomial processes
  x = apply(z1, MARGIN = 2, FUN = sum) 
  
  # bandwidth used to estimate the density of end values
  h = 0.3*(max(x) - min(x))            
  
  # Kernel-based density estimation of x with specified bandwidth
  xdens = density(x, bw=h)                 
  
  # Normal approximation of x
  trend    = n *(2 * p - 1)
  std      = sqrt(4 * n * p * (1 - p))
  norm     = std * rnorm(k) + trend
  normdens = density(norm, bw=h)
  
  # title of the plot
  Title = paste("Distribution of ", k, " generated logarithmic binomial processes", sep = "")
  
  # plot of logs of densities
  plot(as.matrix(xdens$x), log(as.matrix(xdens$y)), type="l", lwd=2, col=4, 
       xlim = c(min(xdens$x,normdens$x), max(xdens$x,normdens$x)),
       ylim = c(min(log(xdens$y),log(normdens$y)), max(log(xdens$y),log(normdens$y))),
       main = Title,
       xlab = "x",
       ylab = "log[f(x)]")
  lines(as.matrix(normdens$x), log(as.matrix(normdens$y)), col=2, lwd=2, lty=2)
  legend("topleft", c("Binomial", "Normal"), col = c(4,2), lwd=2, lty=1:2)
}

SFEbinomv(n = 100, k = 100, p = 0.5)
