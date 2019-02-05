# Very basic gene finding/annotation tutorial

We will analyze two genomes, one from prokaryote and one from eukaryote - 
Escherichia coli ATCC 25922 and Candida albicans A123 respectively. 
We will use two standard tools for finding genes, i.e. Prodigal (https://github.com/hyattpd/Prodigal) and Augustus (https://github.com/Gaius-Augustus/Augustus).

## Prokaryotic gene annotation

### Step 1: Obtain data files
Try and navigate the links and obtain the data yourselves (raw sequence (contigs/scaffolds) without annotation). 
In this particular example we will work with NCBI database, alternative databases are European Nucleotide Archive (https://www.ebi.ac.uk/ena) that you might be using in you project. Try to download both to the server and your computer as well.

The link to the genome assembly:  
https://www.ncbi.nlm.nih.gov/assembly/GCF_000401755.1/

Login to machine using ssh and create and enter the directory for the exercise.

Use wget or curl to download data to a remote machine:

`wget ftp://ftp.ncbi.nlm.nih.gov/genomes/genbank/bacteria/Escherichia_coli/all_assembly_versions/GCA_000401755.1_Escherichia_coli_ATCC_25922/GCA_000401755.1_Escherichia_coli_ATCC_25922_genomic.fna.gz`

Alternatively, you can copy file from your computer. On linux/mac use command:

`scp yourfilename studentX@ip_adress:/home/studentX/your_directory`
On Windows use file transfer function integtated into client.

Unarchive file:

gunzip GCA_000401755.1_Escherichia_coli_ATCC_25922_genomic.fna.gz

### Step 2: Use prodigal to predict all open reading frames of protein coding genes
Get yourself familiar with different Prodigal options, more information: https://github.com/hyattpd/Prodigal
Find protein-coding sequences (CDS), familirase yourself with the output files:

`prodigal -i GCA_000401755.1_Escherichia_coli_ATCC_25922_genomic.fna -o GCA_000401755.1_Escherichia_coli_ATCC_25922_genomic.gff -a GCA_000401755.1_Escherichia_coli_ATCC_25922_genomic.fasta -f gff`


### Step 3: Predict tRNA genes
Get yourself familiar with tRNAscan-SE options. To predict genes in prokaryote run the following command:

`tRNAscan-SE -B GCA_000401755.1_Escherichia_coli_ATCC_25922_genomic.fna -o GCA_000401755.1_Escherichia_coli_ATCC_25922_genomic.rna -a GCA_000401755.1_Escherichia_coli_ATCC_25922_genomic.rna.fasta`



## Eukaryotic gene finding
### Step 1: Obtain data files

Try to find navigate yourself NCBI FTP site yourself and find GCA_000447455.1_Cand_albi_A123_V1 genome, 
Alternatively, download genome to remote computer by running the following command:

`wget ftp://ftp.ncbi.nlm.nih.gov/genomes/genbank/fungi/Candida_albicans/all_assembly_versions/GCA_000447455.1_Cand_albi_A123_V1/GCA_000447455.1_Cand_albi_A123_V1_genomic.fna.gz`

Unarchive file:
`gunzip GCA_000447455.1_Cand_albi_A123_V1/GCA_000447455.1_Cand_albi_A123_V1_genomic.fna.gz`

### Step 2: Use Augustus to predict all open reading frames of protein coding genes

For eukaryotes it might take considerable time to run, instead copy the file from the existing precomputed directory:
`#augustus GCA_000447455.1_Cand_albi_A123_V1_genomic.fna --species=candida_albicans > GCA_000447455.1_Cand_albi_A123_V1_genomic.gff`

`cp  /home/ubuntu/gene_prediction/GCA_000447455.1_Cand_albi_A123_V1_genomic.gff .`


Extract proteins from the generated gff file using the following command:

`getAnnoFasta.pl GCA_000447455.1_Cand_albi_A123_V1_genomic.gff`


Analogously like with prokaryotes you can use `tRNAscan-SE` to find tRNAs in the Candida yeast genome. Please see command help to specify correct arguments.

### Step 3: Use Uniprot/(Swiss-Prot) manually curated sequences to annotate identified proteins

First dowload database of sequences from https://www.uniprot.org/downloads. The sequences were already downloaded for you, just simply use the following command to copy them to your working directory:

`cp /home/ubuntu/gene_prediction/uniprot_sprot.fasta .`

We will use `blastp` to blast your identified sequences to the database of Uniprot sequences, but before this we need to create a blast database (takes time to run).

`#makeblastdb -in uniprot_sprot.fasta -dbtype prot -out uniprot_database`

`#blastp -query GCA_000447455.1_Cand_albi_A123_V1_genomic.aa -db uniprot_database -outfmt 7 -out results`

`cp /home/ubuntu/gene_prediction/results .`


 
 
 



















