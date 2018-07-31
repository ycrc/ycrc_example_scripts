import os

arraysize = int(os.environ['SLURM_ARRAY_TASK_COUNT'])
thisrank = int(os.environ['SLURM_ARRAY_TASK_ID'])

for idx in range(1, arraysize + 1) :
    if idx ==  thisrank :
        bigstring = 'This is array rank ' + os.environ['SLURM_ARRAY_TASK_ID'] + ' from job ' + os.environ['SLURM_JOB_ID']
        bigstring += ' out of ' + os.environ['SLURM_ARRAY_TASK_COUNT']
        print(bigstring)
