###
# 
# Title: Python-Intro-HW.sh
# Date: 2025.01.24
# Author: Vi Varga
#
# Description: 
# This script creates the environment to run JupyterLab on C3SE Vera 
# using the Open OnDemand portal for the Python introduction/tutorial and homework.
# 
# Usage: 
# You should place this script in your ~/portal/jupyter/ directory.
# If the directory doesn't exist, create it with: 
#   mkdir -p ~/portal/jupyter/
# 
# Acknowledgements: 
# The content of this script is based on the TensorFlow-2.6.0-PyTorch-1.12.1.sh script
# provided by C3SE, which can be found in the /apps/portal/jupyter/ directory.
# 
###


# Ensure we don't have any conflicting modules loaded
ml purge; 

# Load necessary modules for Python tutorial & homework
ml Biopython/1.79-foss-2021a; 
ml Seaborn/0.11.2-foss-2021a; 
ml matplotlib/3.4.2-foss-2021a; 

# Load version of JupyterLab
ml JupyterLab/3.0.16-GCCcore-10.3.0; 

# You can launch jupyter notebook or lab, but you must specify the config file as below: 
jupyter lab --config="${CONFIG_FILE}"; 
