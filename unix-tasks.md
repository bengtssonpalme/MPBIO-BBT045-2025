# Introduction to Unix for bioinformatics

## How to connect to Vera

### Linux or macOS:
* Open Terminal
* Run: `ssh CID@vera1.c3se.chalmers.se`  
  * Your have to replace `CID` with your presonal CID username.
  * If it’s your first time connecting, you’ll be prompted to accept the server’s fingerprint. Type yes and press `[Enter]`.
* Enter your CID password (the password will not appear as you type for security reasons), then press `[Enter]`

### Windows
* Open Windows Terminal or PowerShell 
* Run: `ssh CID@vera1.c3se.chalmers.se`  
  * Your have to replace `CID` with your presonal CID username.
  * If it’s your first time connecting, you’ll be prompted to accept the server’s fingerprint. Type yes and press `[Enter]`.
* Enter your CID password (the password will not appear as you type for security reasons), then press `[Enter]`

## Keep track of what you're doing
It is a good idea to **keep track of the commands you run**. They might be usefult in the fututre to understand how you got your results or you might need to re-run some steps. The easiest way to do it is to copy-paste the commands you run (and that work the intended way) to a text file on your own computer. Save the list of commands you use, **along with comments** about what you were doing and what results you got.
It should be something like this:

```markdown
# Comment explaining what the command does
<command>

Output:
...
```
The terminal does keep a history, but it's limited and you may want to reproduce results on a different computer.
Later on, you can rerun commands by pasting them into the terminal or can change this file into a acript that runs all the commands.
### Text editors
Notepad (windows) and TextEdit (mac) come pre-installed, but if you want a tool with more advanced functionalities some good options are [Sublime Text](https://www.sublimetext.com/) or [Notepad++](https://notepad-plus-plus.org/).

If you want work directly on the server, you can open a second terminal window
with the [nano](https://www.nano-editor.org/dist/latest/nano.html) text editor.  
Nano is a very simple text editor, available on most Unix distributions.
To open a new empty text file, simply run `nano my_new_text_file.txt`.
The editor will run "full screen", hiding the command line, so open it in a separate window. 
* To save, press `Ctrl-o`, then `[Enter]`.
* To exit, press `Ctrl-x`

Use whatever text editor you prefer but avoid using Word: it insists on replacing some characters with visually similar versions that are not understood by the Unix commands. This means that pasting your saved commands into the terminal to re-run some steps of your analyses might not work.

## Quick note on commands and syntax

```bash
command -option x --option-with-long-name ARGUMENTS
```
* **Spacing** is important, note the spaces separating the different elements. 
* **Arguments** are the things on which you issue the command on (e.g. files, directories). 
* **Options** (also called **flags**) are parameters that control the command's behaviour.
  * Multiple options can usually be written together if they don't require
  values.  
    ```bash
    command -abcd -e 3
    ```
    In this command the `-e` is not chained since it takes the numerical value 3.
  * Careful not to separate an `option` from its `-` sign, the command will interpret it as 2 separate options.
  * Also be careful that you actually use a minus sign. Some text processors like Word replace minus with a hyphen (a longer horizontal bar). While they look the same, programs ultimately only care about the numerical encoding of these symbols, so they will complain.
* **Long options names** are often alternatives for one-letter options, to ease
  remembering/readability. Some options only have long names (usually the infrequently used).
* Unix environments are *case sensitive*, meaning `command` and `Command` are different things. Most commands have lower case names.

You can get information on the various options by running `command --help` which will print the info in the terminal or `man command` which will load the manual page. You can move up/down with arrow keys and exit by pressing `q`.

You can use the the up arrow key to scroll back through your command history. If you want to re-run a comman you ran proviously, press the arrow up key until you reach it and then `[ENTER]`. Press the arrow down key to get back to the "present".

## Files and directories
The Unix file system has a hierarchical structure and it is organized as an inverted tree: 
* The root directory is at the top of the tree.
* Files and directories (containing files and/or subdirectories) branch out from the root. 

Files and directories can be accessed through their: 
* Absolute path = full path from the root directory.  
`/home/user/documents/bioinformatics/some_sequences.fasta`

* Relative Path = path relative to the current directory.  
`/bioinformatics/some_sequences.fasta` if you are in the `documents` directory.

### Some commands to navigate the file system
* Print the full path to the current **working directory** 
  ```bash
  pwd
  ```
  Especially at the beginning, it can be easy to "get lost" in the file system, `pwd` is an easy and quick way to check where you are.


* **List** files and directories in the current directory
  ```bash
  ls
  ```

* To **change the current directory** you need to provide the path to the new directory.
  ```bash
  cd path/to/new/directory
  ```
  If you just want to move one step up in the file system you can type:
  ```bash
  cd ..
  ```

* To **create a new directory** you use the command: 
  ```bash
  mkdir directory_name
  ```
  and to **create a new empty file** the command:
  ```bash
  touch file_name
  ```
  If you are in your home directory and want to create a *documents* directory, you would run the command `mkdir documents`. Then, to create an empty text file called *my_file.txt* in the *documents* directory, you would run the command `touch documents/my_file.txt`

* To **move** a file (or a directory) to a new location, you use the `mv` command: 
  ```bash
  mv path/to/original/location path/to/new/location
  ```
  For example, if you want to move  *my_file.txt* from the *documents* diretory to the *homework* directory, you would use the command `mv documents/my_file.txt homework/`

* The mv command can also be used to **rename** a file:
  ```bash
  mv old_file_name new_file_name
  ```
* To **delete** files can use the `rm` command
  ```bash
  rm my_file.txt
  ```
  If you want to **delete a directory** you need to add the -r flag.
  ```bash
  rm -d homework/
  ```
  The `-r` option will make `rm` delete all the files and other directories recursively in the specified directory. 

  The `rm` command removes files and directories **without any additional warning!**

## Downloading the datasets
To download the datasets we need for this tutorial we will use `wget`, a command-line utility used to download files and datasets from the web. If `wget` is not working, you can copy the files from `/cephyr/NOBACKUP/groups/bbt045_2025/Resoursec/Unix/`.

# Tutorial
Before you start:
* In this tutorial ALL_CAPS words are used as placeholders for things you need to write, you should therefore replace them with your text.
* Connect to Vera (if you haven't already).
* Open a text editor to save your commands (not compulsory but recommended)

After you have logged in to Vera, **make sure you are in the right place** by running `pwd`. You should see: 
```bash
/cephyr/users/your_username/Vera
```

**Make a directory for this tutorial** and move into it:
```bash
mkdir unix_tutorial
cd unix_tutorial
```
If you run `pwd` you should see that the path has changed to `/cephyr/users/your_username/Vera/unix_tutorial`

Now you are ready to **download the dataset** we'll be working with. Run the following commands one at a time (i.e. one line at a time) by pasting them after the command prompt (the `$` sign) and pressing `[ENTER]`. Everything following the `#` on a line is a comment and has no effect, so you don't need to run those. 

```bash 
# Download the data
wget http://sgd-archive.yeastgenome.org/sequence/S288C_reference/genome_releases/S288C_reference_genome_Current_Release.tgz

# Decompress the archive (will create a new diretory)
tar -xzvf S288C_reference_genome_Current_Release.tgz

# Remove the compressed archive
rm S288C_reference_genome_Current_Release.tgz
```
You should now have a directory called `S288C_reference_genome_R64-5-1_20240529` inside your `unix_tutorial` directory.

1. **List** the content of the current directory using `ls`.  

2. **List the files in the newly created directory** with `ls DIRECTORY`. Replace `DIRECTORY` with the actual name of the directory. It is quite a long name but if you start to type and then press `[TAB]`, the terminal will complete the name for you.
*If multiple files or directories share the first letters, only the common first part will be suggested. Continue typing and then press `[Tab]` again.*

3. Try also using the ls -l DIRECTORY, it will give a detailed vertical list of directory contents which is easier to read.

4. **Rename** the `S288C_reference_genome_R64-5-1_20240529` diretory to `data` using the `mv` command. 5. It will “move” the directory to the same place but with a new name: `mv OLD_NAME NEW_NAME`
*Don’t forget to use [TAB]!*

5. Check that the directory has been correctly renamed using `ls`.

6. **Move into the data directory** with `cd data` and confirm where you are by running `pwd`.

Now we want to inspect the content of file `rna_coding_R64-5-1_20240529.fasta.gz`. Before we can do that, we need to **decompress** it using the command `gzip -d rna_coding_R64-5-1_20240529.fasta.gz`.   
What does the `-d` flag mean? See if you can find out with `gzip --help`.  

Now that the file is decompressed (check with `ls`) we can finally view its content. 
1. Use `head rna_coding_R64-5-1_20240529.fasta` to print the first 10 lines.
2. Then use `less FILENAME` to show the file's content one screen at a time. Use the arrow keys to move up/down and `q` to exit.

**Move one step back** in the files system (outside of `data`) with `cd .. ` (note the space between cd and ..) and check where you are using the `pwd` and `ls` commands. 

You should now be back in the `unix tutorial` directory. In here, **create a new directory** called `results` using the `mkdir` command and a **new empty file** with the command `touch counts.txt`. The `touch` command normally just changes the time the file was last accessed (*"touched"*), but will crate an empty file if it doesn't exist.

Finally, **move** the `counts.txt` file into the `results` directory using `mv`.

## 2. Analyzing files
**Move into the** `data` **directory** (use `pwd` and `ls` if you are unsure of where you are) and **unzip** the `orf_coding_all_R64-5-1_20240529.fasta.gz` and 
`orf_trans_all_R64-5-1_20240529.fasta.gz` files.  
Use `ls -l` to check that the files names changed from `.fasta.gz` to `.fasta`.

Now we are gonna **count the lines** in the two files using the `wc` command. Which flag should you use to print only the number of lines? (*Hint: `wc --help`*)

We have counted how many lines are in the `orf_coding_all_R64-5-1_20240529.fasta` file, but the number of lines in a FASTA file does not correspond to the number of genes in the file.  
A sequence in FASTA format consists of:
* One line starting with a ">" sign followed by a sequence identification code (and opionally a description of the sequence).
* One or more lines containing the sequence itself.

Therefore, to **count how many genes** are in the `orf_coding_all_R64-5-1_20240529.fasta` file we need to count how many ">" are present in the file. To do this we can use `grep`, a very powerful text search tool.  
The general usage is `grep "TEXT_PATTERN" FILE` to search for the text pattern in the specified file.

Try run `grep ">" orf_coding_all_R64-5-1_20240529.fasta`. What is the output of this command? 

Look at the manual page of `grep` to find out which flag you need to add to your command to get a count of the selected lines.

Instead of printig the number of genes to the screen (*standard output*), we want to save the number of genes to a file. You can use the the symbol `>` to **redirect** the output of the `grep command` to the `counts.txt` file you created before.
```bash
`YOUR_GREP_COMMAND > ../results/counts.txt`
```
The `..` in the file's path are used to take us one step back in the file system, where the results directory is located.
You can take a look at the `counts.txt` file using `cat ../results/counts.txt `

Using a similar approach as before, **count how many tRNA genes** are in `orf_coding_all_R64-5-1_20240529.fasta`. This time the text pattern we are looking for in the file is *"tRNA"*.  

Save the results of the tRNA count to the same `counts.txt` file as before. Since the `counts.txt` file is not empty, you need to **append** the count to the file using `>>`.  
If you mistakenly use `>`, the original content of `counts.txt` will be overwritten by the new output, so make sure you use `>>` and not `>`. 

Check that `counts.txt` has the content you expect using `cat`.

**Move back to your home directory** by running `cd` with no argument.  

## 3. Working with text columns

For this part of the tutorial we'll be using another data set with gene expression data. Check where you are (`pwd` and `ls`), then move into the `data` directory we created earlier and download the new datasets.

```bash
# gene experssion data (fold change)
wget https://web.archive.org/web/20130211035221/http://www.cbs.dtu.dk/courses/27619/ex1.dat

# annotation
wget https://web.archive.org/web/20170706124217/http://www.cbs.dtu.dk/courses/27619/ex1.acc
```

You should now have two new files: the experimental result `ex1.dat` and the annotations `ex1.acc`. 
Take a quick look at them using `head`. 

What we want to do is to **merge the two files** using the `paste` command:

```bash
# Merge the two files and save the output to a new file
paste ex1.acc ex1.dat > ../results/merged_files.txt

# Look at the first ten lines of the new file
head ../results/merged_files.txt
```

What did the command do? Look at the manual page `paste --help` and compare the output you got from `paste` with the original files.


## 4. Counting yeast-human orthologs
Check that you are in the `data` directory (if you are not, move there) and then download the EggNOG list of orthologous groups across Eukaryotes, as well as a table of taxonomic IDs:

```bash
wget http://eggnog5.embl.de/download/eggnog_5.0/per_tax_level/2759/2759_members.tsv.gz
gzip -d 2759_members.tsv.gz
wget http://eggnog5.embl.de/download/eggnog_5.0/e5.taxid_info.tsv
```

In the file `2759_members.tsv`:
* Each row is an orthologous group. 
* The 2nd column is the group ID.
* The 5th column contains the list of protein IDs contained in that group.
* The format of each protein ID is `Taxon_ID.Sequence_ID` (*note the dot*).

You can **view the file** with  `less -S 2759_members.tsv` (press `q` to exit).

We want to **find all the orthologous groups that contain genes in both humans and yeast**.
One way to do this is to separately search for yeast and human and then intersect the results.

The first thing we need to do is to **find the TaxonID for *Homo sapiens* and *Saccharomyces cerevisiae***. We can do this by using `grep` to look for "cerevisiae" and "sapiens" in the taxonomic information table `e5.taxid_info.tsv`.

You should see that the TaxonID for *Homo sapiens* is 9606 and for *Saccharomyces cerevisiae* is 4932.

Then, for each of the two organisms, we need to:
1. **Extract the lines** that contain proteins found in the organism using `grep`
2. Take that result and **extract the orthologous group IDs** for each of those lines using `cut`
3. **Sort** this list (relevant later) using `sort`
4. **Save** it to a file using `>`

To avoid creating intermediate files, we can **chain the commands using
the pipe** `|` **redirector** to create a pipeline. The pipe simply takes the output of one command and feeds it directly as input to the next command. 

The general structure of the pipeline will be:  
`GREP_COMMAND | CUT_COMMAND | SORT_COMMAND > RESULTS_FILE`

### Step by step implementation 
We start by **taking all the lines that contain proteins found in *S. cerevisiae*** by grepping for its TaxonID in the `2759_members.tsv` file.  
```bash
grep "4932." 2759_members.tsv 
```
You can pipe (`|`) the output of the grep command into `less -S` for more user-friendly visualization. The output is a list of all the orthologous groups that contain proteins found in *Saccharomyces cerevisiae*.

**Question:** Why do we use the dot in the filtering?  

The next step is to **extract the orthologous group IDs (second column) for each of those lines**. To do this we use `cut` and with the `-f` flag we select the second column.  
Since the output is quite long, we pipe it to `head`.
```bash
grep "4932." 2759_members.tsv | cut -f 2 | head
```

The only thing that is left to do now is to **sort the list of orthologous group IDs** and **save it to a file**.
```bash
grep "4932." 2759_members.tsv | cut -f 2 | sort > ../results/groups_scerevisiae.txt
```

**Task:** Use the same approach for *Homo sapiens* (TaxonID: 9606) and create the `groups_hsapiens.txt` file.  

Move to the `results` directory and take a look at the files using `head` or `less`.

Since we want the groups that contain both human and yeast, we need to produce the **intersection** of these two lists. To archive this we use the `comm` command (have a look at the man page) which reads two files and returns: 
- The elements only present in file 1
- The elements only present in file 2
- The *common* part of two *sorted* files

We only care about the size of the intersection, so we run:

```bash
comm -12 groups_hsapiens.txt groups_scerevisiae.txt | wc -l
```

In this command `-12` suppresses the printing of column 1 and column 2 and `wc -l` only counts lines.
___
***Bonus:** One can do all of the above in one go by feeding `comm` with two ad-hoc data streams as if they were files*
```bash
comm -12 <(grep "4932." 2759_members.tsv | cut -f 2 | sort) <(grep "9606." 2759_members.tsv | cut -f 2 | sort) | wc -l
```
*The pattern here is `<(command that yields text output)` which replaces the result files.*

## 5. Sequence Processing
In the last part of this tutorial we will produce the **complementary RNA sequence of a DNA string**.

For replacing single characters, one could use the `tr` (translate) command like:

```bash
tr "A" "C" < FILE.fasta | less
```
This would replace all occruences of "A" with "C" in `FILE.fasta` and use `less` to show
the content of the FASTA file on the screen.
We use the `<` before the file name since `tr` expects the actual content of the file, not
the file name. The `<` redirector feeds the content as a stream to `tr`.
Normally, `tr` will print results to screen so we can pipe the output to `less` which will only show you a screen at a time. 

While useful for one-shot substitutions, this tool is a bit limited.
If we were to use multiple `tr` runs for each nucleotide, given the complementary nature
of the pairs, we would revert previous substitutions. Additionally we can't do it all in one go with `tr`.

For these reasons we're instead going to use another standard Unix tool called `sed` (stream editor).
`sed` takes either a file or the output of another command and processes the text according to various rules.

For our purpose, we need something like this: 

```bash
sed 'y/ACGT/UGCA/' FILE_DNA.fasta > FILE_RNA.fasta
```
The *"y"* is used to **map** characters, then sed **replaces** each character in the first set (ACGT) with the corresponding character in the second set (UGCA), one-to-one. So in this case A becomes U, C becomes G, G becomes C and T becomes A.  
This command is applied on FILE_DNA.fasts and, since `sed` outputs to screen by default, we redirect the result to a new file.

We can also make sed **skip FASTA header lines** with a slightly more complex command:

```bash
sed '/^>/!y/ACGT/UGCA/' FILE.fasta > FILE_RNA.fasta
```
The added part `/^>/!` is used to apply a condition to lines in the file:
- `/^>/` matches lines starting with the > character (FASTA header lines).

- `!` negates the match, meaning this command applies to all lines that *do not* start with >.

Let's try this out on the fatsa file `orf_coding_all_R64-5-1_20240529.fasta` in the `data` directory and save the output to a file in the `results` directory.


## 6. Bonus: Useful Commands

These are not required for the homework but it's good to be aware of them.
You can read about them online or by reading their documentation.

* `man` (manual) gives the documentation for a given command (e.g. `man ls`).
* most commands accept a `--help` and/or `-h` flag that gives brief instructions on their usage.
* `scp` and `rsync` are commands that allow you to transfer files between computers. The second one is recommended (more flexible and generally has better performance)
* `pushd` and `popd` are handy alternatives to `cd`.  
They manage a list of visited locations: `pushd DIR` takes you to that directory and `popd` (no argument) brings you back to your original location. You can use `pushd` however many times and `popd` will always be a "step back".
* `find` is the command to use if searching for files by name. 
* `ls -larth` is a useful way to use the list command: `-l` gives a detailed list, `-a` shows all files, even hidden ones, `-h` shows file sizes in human-readable format (i.e. 'KB', 'MB' instead of bytes), `-t` sorts by file modification time, `-r` is reveresed order, so that the most recent files are at the bottom, closest to your prompt (useful for long file lists).

* `column` allows displaying tablular files in nice, aligned columns, regardless of how columns are separated in the file (i.e. by `,`, `;`, tab).  
It's however slower than using processing commands like `cut`, `sed` etc. so it's recommended for small files or on `head`/`tail` of files.


## 7. Homework

The homework is posted [here](homework1.md)


## Additional recommended Reading

[The Unix Shell](https://swcarpentry.github.io/shell-novice/) from Software Carpentry Foundation  
[The Philosophy of UNIX Tools](unix-philosophy.md) - some motivation for command line work



<hr />

Chalmers University of Technology 2019

<footer style="font-size:0.6em">

<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">
<img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/80x15.png" />
</a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a>.

</footer>
