# Basic Unix operations for bioinformatics

## 0.1. How to connect to remote accounts

### Windows

* Install MobaXterm: https://mobaxterm.mobatek.net/download-home-edition.html
   * The portable edition should be quicker. It simply unpacks MobaXterm in a folder and you can start it from there
* Open MobaXtern
* In the toolbar: Session > SSH
* In the field "Remote host" write the IP address and in "Specify username" write *studentX* (the one you were assigned)
* Click OK
* Enter password  (you *won't* see any feedback - like `*******` - on the screen)

### Linux or macOS:

* Open Terminal
* Run:  `ssh <username>@<ip-address>`
* If promted about about host authenticity ("*ECDSA key fingerprint is SHA256:... Are you sure you want to continue connecting (yes/no)?"*) write, `yes` then pres `[Enter]`
* Enter password  (you *won't* see any feedback - like `*******` - on the screen)


## 0.2. Keep track of what you're doing

Create a text file called `unix_exercises_FIRSTNAME_LASTNAME.txt`
on your own computer (replacing first and second name with yours)
and keep it open in a text editor (not Word).
In there, paste the commands you use for the tasks below, e.g.

```markdown
# Contents of current directory
<command goes here>

Output:
file1 file2 ...
```

Use whatever format you like, but try to be consistent.

### Why
It's a good idea to save the list of commands you use, along with comments
about what you were doing and what results you got. This will help trace your steps.
The terminal does keep a history, but it's limited and you may want to reproduce results on a different computer.

Later on, you can rerun commands by pasting them into the terminal.
Even later on, you can change this file into a command script
(similar to a program in R, MATLAB, etc) that runs all the commands inside.


Use whatever text editor you prefer. If you're not sure,
some good ones are [Atom](https://atom.io/),
[Sublime](https://www.sublimetext.com/),
or [Notepad++](https://notepad-plus-plus.org/), and gedit (on Linux).
You can even use Notepad or TextEdit,
but these are a pain for any non-trivial editing.

**Avoid Word** though. It insists on replacing some characters
with visually similar versions that are not understood by the Unix commands.


## 0.3. Quick note on command syntax for beginners

Keep in mind that spelling
and spacing is crucially important. Generally, commands have the structure

```bash
command -option --option-with-long-name ARGUMENTS
```

Note the spaces separating the different elements.
Generally it's not important how many spaces there are.

Compare this with how you would write a command in a language like R or MATLAB:

```c
command(option, option_with_long_name, ARGUMENTS)
```

* *Arguments* are the things on which you issue the command on (e.g. files, directories). E.g. `fix all_problems.txt` (not a real command :) )
* *Options* or *"flags"* are parameters that control the command's behaviour.
  Multiple options can usually be written together if they don't require
  values. E.g. `command -abcd -e 3` (`-e` is not chained since it takes the numerical value).
  Going back to our comparison with other languages, something like this would look like `command(a, b, c, d, e = 3)` in e.g. R or Python.
* *Long options names* are often alternatives for one-letter options, to ease
  remembering/readability. Some options only have long names (usually the infrequently used).

You can get information on the various options by running `command --help`
(will print info in the terminal)  or `man command`
(will load the manual page - move up/down with arrow keys, exit by pressing `q`)

To issue a previous command, press the up arrow key to scroll
back through the command history until you reach it.
Press down to get back to the "present"

**Some words of caution**

* Unix environments (including macOS) are *case sensitive*, meaning
  `command` and `Command` are different things. Most commands have lower case names.
* Careful not to separate an option from its `-` sign. The command will understand
  it got 2 separate options.
* Also be careful that you actually use a minus sign (like you have on the keyboard).
  Some text processors like Word replace minus with a hyphen (a longer horizontal bar).
  While they look the same, programs ultimately only care about
  the numerical encoding of these symbols, so they will complain.

## 1. Managing files

**Note**
Here, we'll use ALL_CAPS words to mean placeholders for the actual things to write.

0. Start off by fetching a copy of the data we'll be working with.

Run these commands one at a time (i.e. a line at a time).
Just paste these at the command prompt (the `$` sign).
Everything following `#` on a line is a comment to the user and has no effect.
You don't need to actually run those.

```bash
# Download a reference yeast genome as compressed archive to the current directory
wget https://downloads.yeastgenome.org/sequence/S288C_reference/genome_releases/S288C_reference_genome_Current_Release.tgz

# Decompress the archive (will create a new diretory)
tar -xzvf S288C_reference_genome_Current_Release.tgz
```

This will download and extract the data to a directory called
`S288C_reference_genome_R64-2-1_20150113`

1. List the contents of the current directory.
   Command: `ls`

2. List the files in the newly created directory.
  Command: `ls DIRECTORY`. Try also using the `ls -l DIRECTORY`.
  It will give a detailed vertical list of directory contents.

3. Rename the `S288C_reference_genome_R64-2-1_20150113` to `data`.
  Command: `mv SOURCE DESTINATION`
  One "moves" the directory to the same place but with a new name.

4. See where you are on the system by running `pwd` ("print working directory").
  The tilde `~` you see next to the `$` sign is shorthand for your home directory.

5. Move your location to the `data` directory with `cd data` (*Hint*: as you start typing the name, press `[Tab]` to make the terminal complete the name for you; if multiple files share the first letters, only the common first part will be suggested and you need to continue typing). Confirm where you are by running `pwd`.

6. Inspect the contents of file `rna_coding_R64-2-1_20150113.fasta`. It's quite large, so you should use `less FILENAME` to view it. Press the arrow keys to move up/down and `q` to exit.

7. Make a directory called `results` and create an empty file inside it called `counts.txt`. One quick (and safe) way is `touch results/counts.txt` This command normally just changes the time the file was last accessed ("touched") but will crate an empty file if it doesn't exist.

8. Actually, let's timestamp the `results` directory for posterity. Rename it to `results_2019_01_22`


## 2. Analyze files

1. Count the lines in `orf_coding_all_R64-2-1_20150113.fasta` and `orf_trans_all_R64-2-1_20150113.fasta`  (Hint: the `wc` command)

2. Count how many genes are in `orf_coding_all_R64-2-1_20150113.fasta` (using `grep` or `wc`)

3. Save the number of genes in `results_2019_01_22/counts.txt` Use ether `nano` to manually edit (see section below) or use the redirect symbol `>` to save the output of the previous command to the file, like `count_genes_command > results_2019_01_22/counts.txt` If you do the latter, you'll no longer also get output to the screen (this is on purpose).

4. Count how many `tRNA` genes are in `rna_coding_R64-2-1_20150113.fasta` (Hint: `grep`)

5. Save the results of command 4 to `counts.txt` by appending to the file using the `>>` (double `>`) redirect symbol, similar to before. Make sure to not replace existing content. Or use  `nano`

6. Inspect that `counts.txt` has the content you expect.
  It's a small file so run `cat results_2019_01_22/counts.txt`.

7. Make a copy of `counts.txt` called `counts.txt.orig`
  (it should also be placed in the `results_2019_01_22` directory)

### How to use the `nano` editor

`nano` is a very simple text editor, available on most Unix distributions.
To open a file with it simply run `nano the_file.txt`.
If the file does not exist, an empty one will be created.

The editor will run "full screen", hiding the command line.
* To save, press `Ctrl-o`, then `[Enter]`.
* To exit, press `Ctrl-x`


## 3. Count yeast-human orthologs

First, move back the directory one level up. This relative location is always marked as `..`
Then download and decompress the EggNOG list of orthologous groups across Eukaryotes.

```bash
cd ..
wget http://eggnog5.embl.de/download/eggnog_5.0/data/2759/2759_members.tsv.gz
gunzip 2759_members.tsv.gz
```

The file `2759_members.tsv` contains 6 columns. Each row is an orthologous group.
The 2nd column is the group ID and the 5th column contains the list of protein IDs contained in that group.
The format of each protein ID is `Taxon_ID.Sequence_ID` (note the dot).

We want to find all the groups that contain genes in both humans and yeast.
There are multiple ways to do this. One way is to separately search for yeast and then human
and intersect the results.

We know that TaxonID for *H. sapiens* == `9606` and for
*Saccharomyces cerevisiae* == `4932`.

For each of the two organisms, the process consists of:
1. filtering in the lines that contain proteins found in the organism
2. take that result and extract the orthologous group IDs for each of those lines
3. sort this list (relevant later)
4. save it to a file

To achieve this micropipeline, we shall chain a few commands using
the pipe (`|`) redirector, which simply takes the output of one command and feeds
it as input to the next.

The structure is `filter "TaxonID." | cut out column 2 | sort > RESULTS_FILE`.
The actual commands for this are:

```bash
grep "4891." 2759_members.tsv | cut -f 2 | sort > groups_scerevisiae.txt
grep "9606." 2759_members.tsv | cut -f 2 | sort > groups_hsapiens.txt
```

Quickly inspect what a result file looks like: `less -S groups_hsapiens.txt`
(the `-S` option disables word wrap - press left/right arrow keys to scroll horizontally).

**Question** Why did we use the dot in the filtering?

Now time to produce the intersection of these two lists, since we want the groups
that contain both human and yeast.

The `comm` command returns:
- the elements only present in list 1
- the elements only present in list 2
- the *common* part of two *sorted* lists

We only care about the size of the intersectin, so we run

```bash
comm -12 groups_hsapiens.txt groups_scerevisiae.txt | wc -l
```

where `-12` inhibits the first 2 results and we pipe to `wc -l` (only counts lines).

**Bonus** One can get fancier, avoid intermediate files, and do all of the above in one go:

```bash
comm -12 <(grep "4891." 2759_members.tsv | cut -f 2 | sort) <(grep "9606." 2759_members.tsv | cut -f 2 | sort) | wc -l
```

Here we're feeding `comm` with two ad-hoc data streams as if they were files. 
The pattern here is `<(command that yields text output)` which replaces the result files.

## 4. Sequence Processing

### Produce the complementary RNA sequence of a DNA string

We're going to use a standard Unix tool called `sed` (stream editor).
Like the name implies, it takes either a file or the output of another command
and processes the text according to various rules.
These rules can be very complex (it's a full programming language),
but here's a simple use for it:

```bash
sed 'y/ACGT/UGCA/' FILE > FILE_RNA
```

The sed command (between quotes) substitutes (`/y`)
each letter in the first list (`ACGT`)
with each corresponding letter in the second (`UGCA`).
This command is applied on FILE and, since `sed` outputs to screen by default,
we redirect the result to a new file.

We can also make sed skip FASTA header lines with a slightly more complex
(and less understandable) command:

```bash
sed '/^>/!y/ACGT/UGCA/' FILE.fasta > FILE_RNA.fasta
```

The first part (`/^>/!`) selects locations in the file. The exclamation mark
makes it a negative, in the sense "please de-select these lines and don't process them".
The hat `^` means beginning of line, so the inner part simply says lines starting with `>` which is how the FASTA header is marked.

**Task** Try this out on
`S288C_reference_genome_R64-2-1_20150113/orf_coding_all_R64-2-1_20150113.fasta`


## 5. Homework

Write your answers in the text file you've used to keep track of commands and output so far.
Create a repo on GitHub to keep track of this file and send us the link to this repo.
For the homework tasks, make sure to explain shortly what each command and option in your solution does.

1. How many genes are on chromosome II in `saccharomyces_cerevisiae_R64-2-1_20150113.gff` ?
2. Count GC content in `S288C_reference_sequence_R64-2-1_20150113.fsa`
3. Download another strain: `TODO` and:

   a) compare GC content
   (make sure you're not also counting letters in the headers)

   b) compare number of coding ORFs

   c) find common ORFs between the diff yeast strains.
      Note: remove strain suffixes from names in the non-reference strain.


## Recommended Reading

1. [The Unix Shell](https://swcarpentry.github.io/shell-novice/) from Software Carpentry Foundation
2. [The Philosophy of UNIX Tools](unix-philosophy.md) - some motivation for command line work
3. [Perl and Unix for Bioinformaticians](http://www.cbs.dtu.dk/courses/27619/) course from DTU (initial inspiration for this exercise)
