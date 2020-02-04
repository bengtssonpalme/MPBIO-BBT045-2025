# NGS Aligners practical

(Slightly adapted version of Rui Pereira's exercise protcol)

## Prep

Please copy the exercise data directory `/home/fburic/NGS_algorithms` to your own home directory:

`cp -r /home/fburic/NGS_algorithms ~/`

## Exercise 1

Using `bowtie2` to align short-read sequencing data to a reference genome and 
`samtools` to visualize process the result:

Go to the appropriate directory:

`cd ~/NGS_algorithms/Exercise_1`

Material/Files needed

- Varicella reference genome: `data/varicella.gb`
- Sequencing files: `data/varicella1.fastq`, `data/varicella2.fastq`



### Protocol

#### Step 1

`Bowtie2` requires an index file for the reference sequence.
Create an index file from the varicella genome using bowtie2-build.

Command:

```bash
bowtie2-build -f data/varicella.gb varicella
```

Did it work? What went wrong? 

`bowtie2-build` requires a FASTA file, not a GenBank (GFF3) file.

Convert `varicella.gb` to FASTA using the 
[seqret](http://emboss.sourceforge.net/apps/cvs/emboss/apps/seqret.html) converter from the EMBOSS package,
then build the bowtie index accordingly.

```bash
# Convert GFF3 > FASTA
seqret -sequence data/varicella.gb -feature -fformat gff3 -osformat fasta data/varicella.fasta
# Save index files in own directory
mkdir bowtie_index
# Build the bowtie2 index
bowtie2-build -f data/varicella.fasta bowtie_index/varicella
```

(Computation time: seconds)

#### Step 2

Align the sequencing data to the reference genome using Bowtie2

```bash
mkdir alignment
bowtie2 -x bowtie_index/varicella -1 data/varicella1.fastq -2 data/varicella2.fastq -S alignment/varicella.sam
```

(Computation time: 1 min)

#### Step 3

To make reading the alignment info easier for the computer,
convert the sequence alignment map (SAM) file to binary alignment map (BAM)
using the `samtools` `view` command:

```bash
samtools view -b -S -o alignment/varicella.bam alignment/varicella.sam
```

(Computation time: seconds)

#### Step 4

To optimize the lookup in the alignment map,
sort the BAM file using `samtools` `sort` command.

```bash
samtools sort alignment/varicella.bam -o alignment/varicella.sorted.bam
```

(Computation time: seconds)

#### Step 5

To speed up reading the BAM file even more,
index the sorted BAM file using `samtools` `index` command:

```bash
samtools index alignment/varicella.sorted.bam
```

This will create a BAI file called `alignment/varicella.sorted.bam.bai`

(Computation time: seconds)

#### Step 6

Calculate the average coverage of the alignment using the `samtools` `depth` command
and the Unix `awk` text processor to extract the values of interest:

```bash
samtools depth alignment/varicella.sorted.bam | awk '{sum+=$3} END {print "Average = ",sum/124884}'
```

Output should be: `Answer: average =  199.775`

(Computation time: 1s)

### Questions

#### Q1

Use the `samtools depth` command to extract coverage info 
and create a coverage map of the genome (position vs. coverage).
Read the help for the tool with `samtools help depth`. 
The output format is described at the end of the help.

Answer:  

```bash
samtools depth alignment/varicella.sorted.bam > alignment/coverage.tsv
```

Plot the result with R / Excel / similar

## Exercise 2

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
See [What is a VCF and how should I interpret it?](https://gatkforums.broadinstitute.org/gatk/discussion/1268/how-should-i-interpret-vcf-files-produced-by-the-gatk)

Are all mutations homozygous? Should you expect any heterozygous mutations in this case?

#### Q3

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

#### Q4

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
