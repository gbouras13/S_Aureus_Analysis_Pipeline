#!/bin/bash -l

#SBATCH --job-name=complete_staph
#SBATCH --mail-user=george.bouras@adelaide.edu.au
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --err="complete_staph.err"
#SBATCH --output="complete_staph.out"

# Resources allocation request parameters
#SBATCH -p batch
#SBATCH -N 1                                                    # number of tasks (sequential job starts 1 task) (check this if your job unexpectedly uses 2 nodes)
#SBATCH -c 1                                                    # number of cores (sequential job calls a multi-thread program that uses 8 cores)
#SBATCH --time=2-23:00:00                                         # time allocation, which has the format (D-HH:MM), here set to 1 hou                                           # generic resource required (here requires 1 GPUs)
#SBATCH --mem=1GB                                              # specify memory required per node


# run from Bacteria_Multiplex

SNK_DIR="/hpcfs/users/a1667917/S_Aureus_Analysis_Pipeline"
PROF_DIR="/hpcfs/users/a1667917/snakemake_slurm_profile"

cd $SNK_DIR

module load Anaconda3/2020.07
conda activate snakemake_clean_env

# snakemake -c 1 -s runner.smk --use-conda  --conda-frontend conda  --conda-create-envs-only \
# --config csv=complete_metadata.csv Output=/hpcfs/users/a1667917/S_Aureus_Analysis_Pipeline/Output

snakemake -c 1 -s runner.smk --use-conda  --conda-frontend conda --profile $PROF_DIR/bact_assembly  \
--config csv=complete_metadata.csv Output=/hpcfs/users/a1667917/S_Aureus_Analysis_Pipeline/Output


conda deactivate
