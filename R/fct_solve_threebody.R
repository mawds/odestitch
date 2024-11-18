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

	results <- dplyr::bind_rows(tibble::tibble(t=path[,1], x=path[,"1"], y=path[,"2"], z=path[,"3"], thread=1),
	                     tibble::tibble(t=path[,1], x=path[,"4"], y=path[,"5"], z=path[,"6"], thread=2),
	                     tibble::tibble(t=path[,1], x=path[,"7"], y=path[,"8"], z=path[,"9"], thread=3)
	)
	return(results)
}

#
