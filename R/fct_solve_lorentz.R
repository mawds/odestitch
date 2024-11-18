
lorenz <- function(t, y, parms)
{
	with( as.list(parms), {
	     xdot <- sigma*(y[2]-y[1])
	     ydot <- y[1]*(rho-y[3])-y[2]
	     zdot <- y[1]*y[2]-beta*y[3]
	     return(list(c(xdot, ydot, zdot)))
	})
}

#' solve_lorentz
#'
#' @description Solve the lorentz system.
#'
#' @param parms parameters for the equation.
#' @param ynit Initial values for y
#' @param times a vector of times to run at
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd
solve_lorentz <- function(parms=c(sigma= 10, beta= 8/3, rho= 28),
                          yinit=runif(3),
                          times=seq(from=0, by= 1e-3, length.out= 5e4)) {

  stopifnot(names(parms)==c("sigma", "beta", "rho"))
  stopifnot(is.numeric(parms[["sigma"]]))
  stopifnot(is.numeric(parms[["beta"]]))
  stopifnot(is.numeric(parms[["rho"]]))

	path <- deSolve::ode(func=lorenz,
	                     times=times,
	                     y=yinit,
	                     parms=parms,
	                     method="rk4")

	results <- tibble(t=path[,1],
	                  x=path[,2],
	                  y=path[,3],
	                  z=path[,4],
	                  thread=1
	                  )

	return(results)
}
