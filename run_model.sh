# variable
data=$(date +'%Y-%m-%dT%H:%M:%S')

# conda path
conda_path='/home/natan/miniconda3'

# activate env
source $conda_path/etc/profile.d/conda.sh
conda activate base

# cluster env
conda activate clusterenv


papermill /home/natan/Documents/pa05/notebooks/12-nm-deploy-final.ipynb /home/natan/Documents/pa05/src/12-nm-deploy-$data.ipynb
