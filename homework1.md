# Homework 1: Introduction to Unix for bioinformatics
* Submission deadline: January 29th (on Canvas).
* Write your **commands** and their **output** to a text file.
* For each command make sure to add a **comment line** (starting with #) to shortly explain what it does.
* Write your answers to the questions in the same text file as comment lines.

**Notes:** 
* Make sure to **save your work often** on the server and/or on your laptop. SSH connections to remote computers can be interrupted for many reasons (loss of Wi-Fi connection, computer going to sleep, network issues, server overload) and whatever has not been saved will be lost.

* It's always a good idea to spend some time **inspecting your data**: 
   * What is the structure of the data? 
   * What are the possible values for a given variable of interest?
   * What type of unique identifiers or numerical codes does the data use? 
   * Is the formatting consistent?

   You don't need to answer these questions for the homework, they are just intended to be used as guidelines when working with new data. 


* If the files are in the compressed format (`.gz`), remember to **decompress** them (`gzip -d`) before starting the exercises. 
* *Task 1* and *task 2* will use the same data as the tutorial. 
* You can do this homework in the same directory where you did the tutorial or you can create a new directory in `/cephyr/users/your_username/Vera/`.

## Tasks:

1. How many protein-coding genes are on chromosome II in `saccharomyces_cerevisiae_R64-5-1_20240529.gff`?  
   * Here we're interested in protein-coding genes, which are recorded as just "gene". You can ignore other things like "tRNA_gene" etc.  

2. Calculate the GC-content in yeast strain S288C. The fasta file is  `S288C_reference_sequence_R64-5-1_20240529.fsa`.   
   * The GC-content is the percentage of nitrogenous bases in a DNA or RNA molecule that are either G or C.
   * You can calculate the percentage by hand or using Unix tools like `expr` or `bc`. The important thing is to get the base counts.   
   * Note that sequence files may contain characters like "N" ("nucleobase" - basically unknown) or lowercase letters. Ignore the "N"s and convert the lowercase letters to uppercase.

3. Copy the file `/cephyr/NOBACKUP/groups/bbt045_2025/Resources/Unix/Y55_JRIF00000000_SGD_cds.fsa.gz` and decompress it. This file contains the ORFs of the yeast strain Y55.
   Then:

   1. Compare the GC content of the Y55 strain with the GC content of the of the S288C strain you calculated before.  
   Which strain has the highest GC content?  

   2. Compare number of ORFs in the Y55 strain (all the enties in the `Y55_JRIF00000000_SGD_cds.fsa` file since it only contains ORFs) with the number of ORFs in the S288C reference genome (you should have downloaded the file `orf_coding_all_R64-5-1_20240529.fasta` during the tutorial).

   3. Count the common ORFs between the Y55 and the S288C strains.  
      * You can download this file http://sgd-archive.yeastgenome.org/sequence/strains/Y55/Y55_SGD_2015_JRIF00000000/Y55.README to take a look at which information is included in the header of the Y55 ORFs and its format. 
      * *Hint 1:  You will need to extract the ORFs names for both strains. The ORF name is usually the first field in the FASTA header, but it's always good to double-check!.* 
      * *Hint 2: As you can see in the Y55.README file, the ORFs names in the `Y55_JRIF00000000_SGD_cds.fsa` file contain the strain name, it might be a good idea to remove it.*
