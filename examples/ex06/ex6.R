### ##################################################################
### (Naive) Non-Parametric Bootstrap of the Sampling Distribution of a
### Correlation Coefficient for a Sample of Size 10
### ##################################################################

## Data: law82 dataset from
##       <http://cran.r-project.org/web/packages/bootstrap/index.html>

## Goal: Characterize the sampling distribution of the correlation coefficent on
##       samples of size 25 between average LSAT score and average UG GPA for
##       students at the 82 different law schools (universe).

## Parallelization: MPI Backend and a foreach() loop


## ############
## Dependencies
## ############

suppressMessages({

    library("foreach")
    library("doMPI")
    library("doRNG")
                                        #
                                        # Packges needed for the parallelization

    library("bootstrap")
                                        #
                                        # Packages need for the "substantive"
                                        # example
}
                 )

## ################
## Init MPI Backend
## ################

cl <- startMPIcluster()
registerDoMPI(cl)

                                        #
                                        #

## ##############################
## Naive Non-Parametric Bootstrap
## ##############################

nBS <- 1000
sizeBS <- 25
                                        #
                                        # Number of BS iterations and BS sample
                                        # size

data(law82)
registerDoRNG(1)
                                        #
                                        # Reproducible Parallel RNG
output <- foreach(i = (1:nBS),
                  .combine = rbind,
                  .export = c("law82", "sizeBS")
                  ) %dopar% {
                      ##
                      indsBS <- sample(x = 1:nrow(law82),
                                       size = sizeBS,
                                       replace = FALSE
                                       )
                      subBS <- law82[indsBS, ]
                      corBS <- cor(subBS$LSAT, subBS$GPA)
                      ##
                      return(corBS)
                  }
                                        #
                                        #

quantile(output, probs = seq(0, 1, .1))


## ########################
## Close Everything Cleanly
## ########################

closeCluster(cl)
mpi.quit()
