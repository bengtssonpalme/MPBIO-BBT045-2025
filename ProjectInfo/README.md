# README - Project Container

Author: Vi Varga

Last Modified: 19.02.2024


## Introduction

This README.ipynb file provides a brief explanation/guide for how to use the container that has been prepared for students in BBT045 to use for their projects. A README.md file will also be provided, with all markdown-formatted text included therein. 

The `bbt045-projects.sif` container has been created for students to use to run their projects, so that students do not have to install their own software on the Vera cluster. Please contact the teaching staff (especially Vi), if you would like access to a program that is not included in the container, or if something malfunctions. 

If you do not have it already, you can download this information in Jupyter Notebook format from [here](README.ipynb).


## Installed software

The full list of programs installed in the `bbt045-projects.sif` container can be found in the `bbt045-projects.yml` and `conda_environment_args_proj.def` files included in the same directory as the container (`/cephyr/NOBACKUP/groups/bbt045_2024/ProjectSoftware/`). Below is a list of the most important software: 
 - FastQC
 - TrimGalore!
 - Trimmomatic
 - MetaCompass
 - SPAdes (including metaSPAdes)
 - Prokka
 - CD-HIT
 - MetaPhlan2
 - Bowtie2
 - Python
    - Biopython
    - Jupyter
    - matplotlib, seaborn
    - numpy, pandas
    - scipy


## Using the container

In order to use the `bbt045-projects.sif` container, please use the `run_jupyter_proj.sh` script found in the same directory as the container, and modify the time requirement and ID as you have done for the `run_jupyter.sh` script before. ALternatively, you can continue using your copy of the `run_jupyter.sh`, script, and simply change the PATH to the container to read: 

```bash
container=/cephyr/NOBACKUP/groups/bbt045_2024/ProjectSoftware/bbt045-projects.sif
```

Of the programs mentioned above, all but MetaCompass have been installed using `conda`. All programs installed via `conda` can be run directly from within your Jupyter Notebook, like so: 

```bash
! metaspades.py -h
```

MetaCompass does not have a `conda` package available, so it has been installed in the container from source. In order to use it, you must call the program using the full path to the executable, like so: 

```bash
! /opt/MetaCompass-2.0-beta/go_metacompass.py -h
```

And of course, you can run Python code directly from within the code cells of your Jupyter Notebook, like so: 

```python
print("Jupyter Notebook cells are Python cells by default.")
```
