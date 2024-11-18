library(tidyverse)

# r1,r2,r3,v1,v2,v3
# Based on https://towardsdatascience.com/modelling-the-three-body-problem-in-classical-mechanics-using-python-9dc270ad7767
threebody<- function(t, y, parms)
{
	with( as.list(parms), {
	     r1 = y[1:3]
	     r2 = y[4:6]
	     r3 = y[7:9]
	     v1 = y[10:12]
	     v2 = y[13:15]
	     v3 = y[16:18]

	     r12 = norm(matrix(r2-r1), "E")
	     r13 = norm(matrix(r3-r1), "E")
	     r23 = norm(matrix(r3-r2), "E")

	     dv1bydt=m2*(r2-r1)/r12**3+m3*(r3-r1)/r13**3
	     dv2bydt=m1*(r1-r2)/r12**3+m3*(r3-r2)/r23**3
	     dv3bydt=m1*(r1-r3)/r13**3+m2*(r2-r3)/r23**3
	     dr1bydt=v1
	     dr2bydt=v2
	     dr3bydt=v3

	     return(list(c(
	                   dr1bydt,dr2bydt,dr3bydt,
	                   dv1bydt, dv2bydt, dv3bydt
	                   )))

	})
}


#' solve_threebody
#'
#' @description Get the numerical solution to the three body problem
#'
#' yinit should be in the form (rx1,ry1,rz1, rx2,ry2,rz2, rx3,ry3,rz3,
#' vx1,vy1,vz1, vx2, vy2, vz2, vx3, vy3, vz3) where r and v are the initial
#' positions and velocities
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd
solve_threebody <- function(parms=c(m1=1,m2=1,m3=1),
                            yinit=c(0,0,0,
                                    3,0,0,
                                    0,4,0,
                                    rep(0,9)),
                            times=seq(from=0, by=1e-3, length.out= 1000)) {


  stopifnot(names(parms)==c("m1","m2","m3"))
  stopifnot(is.numeric(parms[["m1"]]))
  stopifnot(is.numeric(parms[["m2"]]))
  stopifnot(is.numeric(parms[["m3"]]))
  stopifnot(length(yinit)==18)

	path <- deSolve::ode(func=threebody,
	                     times=times,
	                     y=yinit,
	                     parms=parms)

	results <- bind_rows(tibble(t=path[,1], x=path[,"1"], y=path[,"2"], z=path[,"3"], thread=1),
	                     tibble(t=path[,1], x=path[,"4"], y=path[,"5"], z=path[,"6"], thread=2),
	                     tibble(t=path[,1], x=path[,"7"], y=path[,"8"], z=path[,"9"], thread=3)
	)
	return(results)
}

#
# # ICs from http://www.simplyintegrate.de/sib/index.html#x1-40002
# # Note parameter ordering is different on website
# # Eight
# eight_ics <- c(0.9700436,-0.24308753,0,
#  -0.9700436, 0.24308753, -0,
#  0, 0, 0,
#  0.466203685, 0.43236573, 0,
#  0.466203685, 0.43236573, 0,
#  -0.93240737, -0.86473146, -0 )
#
#
# # Didn't solve
# # swimmer <- c(0,0, 0,
# #              -1, 0, 0,
# #              1, 0, 0,
# #              0, 1.2050, 0,
# #              0, -0.6025, 0,
# #              0, -0.6025, 0)
#
# # Ducatti
# ducatti <- c(-1, 0, 0,
# 0.5, -0.647584, 0,
# 0.5, 0.6475840, 0,
# 0, -0.93932504689, 0,
# -0.505328085163, 0.46962523449, 0,
# 0.505328085163, 0.46962523449, 0 )
#
# # Heart
# heart <- c(-5.54504183347047, 0, 0,
# 2.772520916735235, -1.678453738023547, 0,
# 2.772520916735235, 1.678453738023547, 0,
# 0, -0.414526370749686, 0,
# 0.3933483781289587, 0.207263185374843, 0,
# -0.3933483781289587, 0.207263185374843, 0 )
#
# results <- solve_threebody(yinit=heart, times=seq(from=0,to=80, length.out=5000))
#
# # Unequal masses for this one
# pythagorean <- c(1,3, 0, -2, -1, 0, 1, -1, 0, rep(0,9))
# results <- solve_threebody(parms=c(m1=3,m2=4,m3=5),
#                            yinit = pythagorean,
#                            times=seq(from=0,to=30, length.out=1000))

