#!/bin/bash
#SBATCH --job-name=large-convert
#SBATCH --account=project_462000002
#SBATCH --partition=standard
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=128
#SBATCH --mem=0
#SBATCH --time=5:00:00
#SBATCH --output=slurm-convert_zip-%j.out

module use /appl/local/training/modules/AI-20240529
module load singularity-userfilesystems singularity-CPEbits

CONTAINER=/appl/local/containers/sif-images/lumi-pytorch-rocm-6.2.1-python-3.12-pytorch-20240918-vllm-4075b35.sif

#mkdir -p data-formats/hdf5/
#mkdir -p data-formats/lmdb/
#mkdir -p data-formats/tfrecords/

# srun singularity exec $CONTAINER bash -c '$WITH_CONDA && source venv-extension/bin/activate && python scripts/hdf5/convert_large_to_hdf5.py'
srun singularity exec $CONTAINER bash -c '$WITH_CONDA && source venv-extension/bin/activate && python scripts/lmdb/convert_large_to_lmdb.py'
#srun singularity exec $CONTAINER bash -c '$WITH_CONDA && source venv-extension/bin/activate && python scripts/tfrecords/convert_to_tfrecords.py && python3 -m tfrecord.tools.tfrecord2idx data-formats/tfrecords/train && python3 -m tfrecord.tools.tfrecord2idx data-formats/tfrecords/val'
