# bulldog-scripts

Collection of examples and setup scripts for HPC at Yale University

## What?

This repository has a set of toy example scripts to help illustrate how your
code can use and interact with the HPC resources and scheduling environment.

The focus is on R-based HPC, but there are examples with Python and MATLAB,
too. All examples rely on Slurm. They can be adapted for other resource
managers, but that's not included.

# Table of Topics

| Topic                                                      | Examples |
| common scheduler directives and options                    |          |
| sequential execution of scripts                            |          |
| misc. shell commands in job scripts                        |          |
| job arrays                                                 |          |
| passing command line args into jobs                        |          |
| reading environmental variables                            |          |
| dynamic parallelization                                    |          |
| single-node, multiple-core parallelization (shared memory) |          |
| multiple-node parallelization (distributed memory)         |          |

# Using these examples

Each example can be used to submit a perfectly valid job that demonstrates
certain aspects of computing in HPC environments. Even though they are toy, they
should demonstrate certain features realistically enough to be useful.

The shell scripts with a `.slurm` suffix are SLURM scripts.

## Example 0: Bare Bones

This is a bare bones example. It requests 1 task with 1 processor. It allows the
scheduler to kill the job after 10 minutes. The script simply generates 1,000
random numbers using the Rscript interface to R.

To run under SLURM:
```
cd ./examples/ex0/
sbatch ex0.slurm
```

## Example 1: A reasonable Default

This script represents a reasonable starting point for simple jobs. It is more
explicit about how the job should be managed than Example 0.

- It still requests 1 task with 1 processor.
- It requests only 10 minutes of time.
- It uses a custom name in the queue and has both the error log and the output
  log merged into one file which begins with log.* and has a suffix determined
  by the job ID.
- It requests emails when it begins, ends, and aborts (the email address can be
  specified manually the defaults email the submitting user)

Every line beginning with # is just a scheduler directive. The remainder
comprises an actual shell script. The script is verbose about where it is, when
it starts, and what resources were given to it by the scheduler.

The script ultimately generates 1,000 random numbers using the `Rscript`
interface to R.

## Example 2: Example 1 + an R script

This script includes all the reasonable defaults from Example 1. The only change
is that it uses `Rscript` to run an external R script, which is how the job
would usually be programmed.

The computational task in R is a copy of the example usage of `ideal()` from the R
package **pscl**.

To run under SLURM:
```
cd ./examples/ex2/
sbatch ex2.slurm
```

## Example 3: Example 2 + parallel execution + passing args at the command line

This job script uses the sample reasonable defaults from above, but it requests
3 tasks with 1 processor each. These tasks may land on the same physical node or
not.

The R script uses an MPI backend to parallelize an R `foreach` loop across
multiple nodes. A total of 3 * 1 = 3 processors will be used for this job (but 1
task is kept for the "master" process). When running the R script, we pass the
value "10" as an unnamed argument. The R script then uses this value to
determine how many iterations of the `foreach` loop to run.

Each iteration of the `foreach` loop simply pauses for 1 second and then returns
some contextual information in a `data.frame`. This information includes where
that MPI process is running and what it's "id" is.

To run under SLURM:
```
cd ./examples/ex3/
sbatch ex3.slurm
```

## Example 4: Example 2 + job arrays + passing arguments to R

This script now requests an array of jobs based on the template. For jobs in
this array (indexed from 1 to 3), the shell script will run given the requested
resources. Because the log file depends on the job ID, each of the three jobs
will generate different log.* output.

Because R can read environmental variables we are able to use the index on an
object of interest to us in R (e.g., a vector of names of files in a directory
to be processed).

With this setup, each sub-job is requesting the same resources.
- 1 task with 1 core each

To run under SLURM:
```
cd ./examples/ex4/
sbatch ex4.slurm
```

##### Example 6: "Substantive" Example Supporting Cross-Node Execution

This example is less a demonstration of features available (e.g., there is no
use of job arrays or command line arguments) and, instead, shows a computational
job that provides a reasonable template for many other embarrassingly parallel
computational tasks.

Here, the goal is to use a non-parametric bootstrap to approximate the sampling
distribution of correlation coefficients based on samples of size 25. The
correlation of interest is between average undergraduate GPA and average LSAT
scores among students at 82 different law schools.

The output generated from the R script is just the deciles from this
distribution (without acceleration or bias-correction).

To run under SLURM:
```
cd ./examples/ex6/
sbatch ex6.slurm
```
