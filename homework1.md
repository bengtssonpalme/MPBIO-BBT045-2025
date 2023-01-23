# Homework 1: Basic Unix operations for bioinformatics

* Write your answers in the text file you've used to keep track of commands and output so far.
* Use the repo you were assigned to and commit your file in there. Remember to also push.
* For the homework tasks, make sure to explain shortly what each command and option in your solution does.

**Note** Make sure to save your work often on the server and/or on your laptop. 
SSH connections to remote computers like our exercise server can be interrupted for many reasons: 
e.g. loss of Wi-Fi connection, computer going to sleep, network issues, server overload.

*Advice*: It's always a good idea to spend some time inspecting your data.
What are the possible values for a given variable of interest?
Is data represented in a uniform way? 
What type of unique identifiers or numerical codes does the data use? 
Is the formatting consistent?
etc.

**Testing your answers before hand-in** You should test your answers before handing in your solutions. You do this by writing your answers down in a separate file and running the command:
`/storage/Test/unix_test.py <your_results_file.txt>`
Configure your results file so that you have the answers on separate lines. Only put the numerical answers on the lines and when answers are fractions round to 2 significant digits. Solutions for Task 3 a, b and c go on separate lines.  

## Tasks:

1. How many genes are on chromosome II in `saccharomyces_cerevisiae_R64-2-1_20150113.gff` ?
   Note that the chromosome column is followed by a TAB charachter, which is encoded as `\t`. Here we're primarily concerned with protein-coding genes (just "gene") so you can ignore other things like "tRNA_gene" (though either count is fine).

2. Count GC content in `S288C_reference_sequence_R64-2-1_20150113.fsa`. You can do the final part (i.e. calculating a percentage) by hand or using Unix tools like `expr` or `bc`. The important thing is to get the base counts. **Note** that the sequence files may contain characters like `N` ("nucleobase" - basically unknown) or lowercase letters in the sequence. The `N`s you can ignore and the lowercase letters you can either convert to uppercase or ignore (they're not that many)

3. Download and decompress the ORFs of another strain (Y55) from
   http://sgd-archive.yeastgenome.org/sequence/strains/Y55/Y55_SGD_2015_JRIF00000000/archive/Y55_JRIF00000000_SGD_cds.fsa.gz
   
   (Careful to use the right program to decompress - see in the exercises above which to use for the `.gz` format)

   Then:

   a) compare GC content in this file with the value in task 7.2. above
      (make sure you're not also counting letters in the headers)

   b) compare number of ORFs in this Y55 strain (basically all the enties in the Y55 file you downloaded since it only contains ORFs) 
      with the number in the S288C reference genome (file `orf_coding_all_R64-2-1_20150113.fasta` we worked with in the exercises, When testing with the automated script return S288C-Y55)

   c) count the common ORFs between this Y55 yeast strain and the S288C reference we
      worked with in the exercises.
      *Note*: Remove strain suffixes from names in the Y55 strain.
