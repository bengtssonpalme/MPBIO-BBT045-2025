# Sequencing Technologies Tutorial

(Slightly adapted version of Rui Pereira's exercise protcol)

## Prep

We will be working in RStudio and writing the commands in a notebook.
The notebook will serve as a rudimentary pipeline.

Please create a directory for this tutorial and inside there
copy the starter notebook from my directory. So:

```bash
mkdir sequencing
cp /home/fburic/sequencing/sequencing_technologies_tutorial.Rmd sequencing/
cd sequencing
```

The starter notebook contains instructions for setting up your conda
environment. Please follow these instructions, then continue using
the notebook to write the commands used here and take notes for the exercises.
If you have not done so already, you need to first install conda.
See instructions [here](../unix/conda_install.md)

**Make sure you activated the `sequencing` environment!**

> (Explained in class:) R notebooks can contain Linux terminal (bash) commands,
> and you are encouraged to write the commands inside these "bash chunks".
> The only thing to remember is that each chunk is run independently,
> so each one starts from the same location as the notebook and without the conda environment activated.


Now fetch a copy of the data we will be using:

```bash
cp -r /home/fburic/sequencing/data .
```

To nicely see the contents of (small) directories, you can use
the `tree` program, but you need to install it first (`conda install tree`)

```bash
tree data
```

You can also run `ls *` (which works on any system)

To make sure this data is protected from accidental writes, 
remove the write permission (`-w`) for anyone on the server (`ugo`) 
on it by running:

```bash
chmod -R ugo-w data  # -R means "recursive" (exhaustively apply to all files)
```

Then create results directory

```bash
mkdir results
```


## Exercise 1: Alignment

We'll be aligning sequencing data against the reference genome of a Varicella virus.

This mainly involves using `bowtie2` to align short-read sequencing data to the reference genome and 
`samtools` to post-process and visualize the result:

Raw data files:

- Varicella reference genome: `data/ref/varicella.gb`
- Sequencing files: `data/seq/varicella1.fastq`, `data/seq/varicella2.fastq`

You can run the commands in the terminal directly, but we'll be building a
rudimentary pipeline using the R notebook, so copy the code chunks 
(including the surrounding `{bash}` marker) and run the chunk from the notebook.

### Protocol

#### Step 1: Init

Create a separate results dir

~~~
```{bash}
mkdir results/exercise1
```
~~~

#### Step 2: Preprocess

`bowtie2` requires an index file for the reference sequence.
This index can only be constructed from a FASTA file but it's common practice to
find reference genomes in GenBank (GFF3) format.

Convert `varicella.gb` to FASTA using the 
[seqret](http://emboss.sourceforge.net/apps/cvs/emboss/apps/seqret.html) converter from the EMBOSS package,
then build the bowtie index accordingly.

> (Computation time: seconds)

~~~
```{bash}
conda activate sequencing

# Convert GFF3 > FASTA
seqret -sequence data/ref/varicella.gb -feature -fformat gff3 -osformat fasta data/ref/varicella.fasta

# This file is outptut by seqret in the current directory (because bad design)
# So we move it where it belongs
mv varicella.gff data/ref/

# Document how the FASTA file was created
echo "vaircella.fasta converted from GFF as:" > data/ref/README.txt
echo "seqret -sequence data/ref/varicella.gb -feature -fformat gff3 -osformat fasta data/ref/varicella.fasta" >> data/ref/README.txt

# Save index files in own directory
mkdir results/exercise1/bowtie_index
# Build the bowtie2 index
bowtie2-build -f data/ref/varicella.fasta results/exercise1/bowtie_index/varicella
```
~~~



#### Step 3: Align sequences to reference

Align the sequencing data to the reference genome using `bowtie2`.
The `\` symbol simply breaks the command across multiple lines for readability.

> (Computation time: 1 min)

~~~
```{bash}
conda activate sequencing
mkdir results/exercise1/alignment
bowtie2 -x results/exercise1/bowtie_index/varicella \
	-1 data/seq/varicella1.fastq -2 data/seq/varicella2.fastq \
	-S results/exercise1/alignment/varicella.sam
```
~~~



#### Step 4: Convert alignment to binary format

To make reading the alignment info easier for the computer,
convert the sequence alignment map (SAM) file to binary alignment map (BAM)
using the `samtools` `view` command:

> (Computation time: seconds)
> 
~~~
```{bash}
conda activate sequencing
samtools view -b -S -o results/exercise1/alignment/varicella.bam \
    results/exercise1/alignment/varicella.sam
```
~~~


#### Step 5: Optimize alignment (part 1)

To optimize the lookup in the alignment map,
sort the BAM file using `samtools sort` command.

> (Computation time: seconds)

~~~
```{bash}
conda activate sequencing
samtools sort results/exercise1/alignment/varicella.bam -o \
    results/exercise1/alignment/varicella.sorted.bam
```
~~~


#### Step 6: Optimize alignment (part 2)

To speed up reading the BAM file even more,
index the sorted BAM file using `samtools` `index` command:

> (Computation time: seconds)

~~~
```{bash}
conda activate sequencing
samtools index results/exercise1/alignment/varicella.sorted.bam
```
~~~

This will create a BAI file called `results/exercise1/alignment/varicella.sorted.bam.bai`



#### Step 7: Calculate alignment coverage

Calculate the average coverage of the alignment using the `samtools depth` command
and the Unix `awk` text processor to extract the values of interest:

> (Computation time: 1s)

~~~
```{bash}
conda activate sequencing
samtools depth results/exercise1/alignment/varicella.sorted.bam | awk '{sum+=$3} END {print "Average = ", sum/124884}'
```
~~~

Output should be: `Answer: average =  199.775`


### Question

Use the `samtools depth` command to extract coverage info 
and create a coverage map of the genome (position vs. coverage).
Read the help for the tool with `samtools help depth`. 
The output format is described at the end of the help.

Answer:  

~~~
```{bash}
conda activate sequencing
samtools depth results/exercise1/alignment/varicella.sorted.bam > results/exercise1/alignment/coverage.tsv
```
~~~

Plot the result with R

~~~
```{r, message=F}
library(tidyverse)

alignment_coverage <-
  read_tsv('results/exercise1/alignment/coverage.tsv',
           col_names = c("reference_name", "position", "coverage_depth"))

alignment_coverage %>% 
  ggplot() + geom_histogram(aes(x = coverage_depth))
```
~~~




## Exercise 2: Finding Mutations

We now look at a second set of sequencing data, with mutations.

Using `bowtie2` and `samtools` to:

* align short-read sequencing data 
* compute the mutations present

Material/Files needed:

- Varicella reference genome: `data/varicella.fasta`
- Sequencing files from *dumas* strain: `data/varicella_mut1.fastq`, `data/varicella_mut2.fastq`

### Protocol

#### Step 1

Go to the appropriate directory `cd ~/NGS_algorithms/Exercise_2`

Create a sorted and indexed BAM file using the steps 1-5 from exercise 1.

Commands: Same Exercise 1, except skip converting GFF3 > FASTA 
(you already have a reference `data/varicella.fasta`).
Tip: Run `ls -l data` if you forget what files you're working on.

(Computation time: 5 minutes)

#### Step 2

Use the `samtools mpileup` command to identify genomic variants 
(aka single nucleotide variants, [SNVs](https://en.wikipedia.org/wiki/SNV_calling_from_NGS_data))
in the alignment:

```bash
mkdir results
samtools mpileup -g -f data/varicella.fasta alignment/varicella_mut.sorted.bam > results/varicella_variants.bcf
```

#### Step 3

Use `bcftools call` command to convert the binary call format (BCF) to 
(human-readable) variant call format ([VCF](https://en.wikipedia.org/wiki/Variant_Call_Format))

```bash
bcftools call -c -v results/varicella_variants.bcf > results/varicella_variants.vcf 
```

If you wish to inspect it, run `less -S results/varicella_variants.vcf`
The file contains quite a lot of information, which we'll use later on.
See https://en.wikipedia.org/wiki/Variant_Call_Format for more info.

#### Step 4

Visualize the mutation detected on site `77985` using the `samtools tview` command.
For this, you only need the BAM file. Remember that this files stores mutant-to-reference alignment information.
VCF (and BCF) contain only the information needed for some downstream tasks.

```bash
samtools tview alignment/varicella_mut.sorted.bam data/varicella.fasta -p NC_001348:77985 
```

### Questions

#### Q1

Inspect the VCF file columns using the (Unix) commands `grep -v "^#"  results/varicella_variants.vcf | column -t | less -S` 
(skip header, align columns, less)

How can you interpret the [PHRED](https://en.wikipedia.org/wiki/Phred_quality_score) 
score values in the last column? 
See [What is a VCF and how should I interpret it?](https://gatkforums.broadinstitute.org/gatk/discussion/1268/how-should-i-interpret-vcf-files-produced-by-the-gatk) (Section 5)

Are all mutations homozygous? Should you expect any heterozygous mutations in this case?

#### Q2

What assumption does `samtools mpileup` make about the model of genetic mutations?
(Try running `bcftools mpileup` for help and scroll down.) 
Is this model appropriate for a virus?

Answer: 
<font color="white">
samtools mpileup assumes the data originates from a diploid organism
and models mutations based on the existence of two similar copies of the same sequence.
Since viruses only have one copy of the genome, this model is not correct and 
it is not possible for a single genomic position to have two different bases.
</font>

#### Q3

Use `samtools mpileup` to inspect the site 73233. What is the frequency of each base on this site?
Rune the command below and see [Pileup format](https://en.wikipedia.org/wiki/Pileup_format)

```bash
samtools mpileup -r NC_001348:73233-73233 -f data/varicella.fasta alignment/varicella_mut.sorted.bam
```

Answer:  <font color="white"> 170 T, 1 A, 2 G </font>



## Exercise 3

Using the `breseq` pipeline to compute the mutations present in the mutant strain 
in comparison to the reference sequence provided for the varicella virus.

Material/Files needed

- Varicella reference genome: `data/varicella.gb`
- Sequencing files from dumas strain: `data/varicella_mut1.fastq`, `data/varicella_mut2.fastq`

### Protocol

#### Step 1

`cd ~/NGS_algorithms/Exercise_3`

Run `breseq`

```bash
breseq -j 1 -o results -r data/varicella.gb data/*.fastq
```

(Computation time: 5 minutes)

### Questions

#### Q1

Open the `index.html` file in the `results/output` folder 
and compare the mutations detected in comparison to exercise 2. 

Download that folder by running the following from your own computer:
`rsync -avP studentX@<IP number>:~/NGS_algorithms/Exercise_3/results/output .`

You can also try out `lynx results/output/index.html` to browse in the terminal.

Answer: All mutation are present in the list from exercise 1, one mutation is missing in breseq

#### Q2

Use the `breseq bam2aln` command to investigate the missing mutations
(the `\` simply means "command continues on next line")

Answer: 

```bash
breseq bam2aln \
    -f ~/NGS_algorithms/Exercise_2/data/varicella.fasta \
    -b ~/NGS_algorithms/Exercise_2/alignment/varicella_mut.sorted.bam \
    -r NC_001348:117699-117699 -o results/output.html
```

Then from your computer:

`rsync -avP studentX@<IP number>:~/NGS_algorithms/Exercise_3/results/output.html .`

The alignment shows a consensus change from C to T (scroll a bit to the right if you don't see it).
Breseq missed this mutation in the output table.

#### Q3

Open the `summary.html` file and find the mean coverage of the alignment.
Find also the coverage plot.

## Exercise 4

De novo genome assembly of the varicella virus strain *dumas* using the `abyss` assembler

Material/Files needed

- Sequencing files from *dumas* strain: `data/varicella_l1.fastq`, `data/varicella_l2.fastq`

### Protocol

#### Step 1

Assemble the reads provided into a genome using abyss-pe for k=128

```bash
cd ~/NGS_algorithms/Exercise_4
abyss-pe name=varicella k=128 in='data/varicella_l1.fastq data/varicella_l2.fastq'
```

(Computation time: 5 minutes)

### Questions

#### Q1

How many unitigs, contigs and scaffolds were assembled?

Hint: `less varicella-stats.md`

Answer: <font color="white">14, 12, 6</font>

#### Q2

How big is the largest scaffold?

Answer: <font color="white">107578</font>

#### Q3

Use NCBI nucleotide blast (https://blast.ncbi.nlm.nih.gov/Blast.cgi) 
to find similar sequences to the scaffolds obtained. 
What is the most similar sequence obtained?

## Extra exercise

Finding mutation in a human sample and the disease associated with it

Material/Files needed

- Sequencing files from *dumas* strain: `chrX1.fq`, `chrX2.fq`

### Protocol

#### Step 1

Align the datafiles and generate a VCF file with the mutations detected

```bash
cd ~/NGS_algorithms/Exercise_human
bowtie2 -x chrX -1 chrX1.fq -2 chrX2.fq -S chrx.sam
samtools view -b -S -o chrx.bam chrx.sam
samtools sort chrx.bam -o chrx.sorted.bam
samtools index chrx.sorted.bam
samtools mpileup -g -f chrx.fasta chrx.sorted.bam > chrx.bcf
bcftools call -c -v chrx.bcf > chrx.vcf
```

#### Step 2

Use the Variant Effect Predictor tool to find out which mutation detected can cause disease, 
which gene it affects and which disease it causes.
https://www.ensembl.org/Tools/VEP
