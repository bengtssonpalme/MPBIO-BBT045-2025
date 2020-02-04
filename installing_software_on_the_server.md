# How to intall software on the exercise server

## Using the conda package manager

`conda` is a cross-platform package manager that can install both full programs, and Python and R libraries for you, 
without the need for administrative privileges.
(If you've used Linux before, it's similar to `apt`.)

Many standard bioinformatics tools have been published for conda, most notably on the "bioconda" channel (list of packges).

### Environment

While it's possible to intall packages globally, for all users, that quickly leads to problems and clashes in
software versions.

Therefore, you should **create your own work environment** where you can install the software you need.

Run the following (from anywhere), replacing `test_fburic` with the name you want.
Since on this server the environments are visible and accessible for everyone, please **add a unique identifier**
(e.g. "stX" for student X) in the name to avoid accidentally using the same name as your colleagues (e.g. `test_st3`)

```bash
conda create --name test_fburic
```

To see a list of environemnts, run:

```bash
conda env list
```

To **activate** (start using) the environment, run:

```bash
source activate test_fburic
```

You will see a `(test_fburic)` to the left of your prompt. 
You are now in that environment and anything you install will only be usable inside here.

**Note**: You will have to re-activate the environment every time you log in. 
(You can add the command at the end of your `.bashrc` file to have it executed on each login)

#### Further reading

See the documentation about [managing environments](https://conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html)


### Software installation

Alternatives:

1. The typical way is to google the tool you need and check if they provide instructions for conda
2. If not, somebody else may have published it on a conda channel, so goole "<software> conda"
3. Search for that package on the Bioconda list:  https://anaconda.org/bioconda/repo  or, failing that, on (Ana)conda globally: https://anaconda.org/
3.5. You can also search from command line: `conda search <software>`

#### Example 1

Let's install the `cufflinks` RNA-seq assembler. 
On their [webpage](https://cole-trapnell-lab.github.io/cufflinks/install/) they don't list conda.

So, alternative 2. Googling for "cufflinks assembly conda" sent me to the listing of the package on the bioconda channel:
https://anaconda.org/bioconda/cufflinks

So, the command to install it is:

```bash
 conda install -c bioconda cufflinks 
```

#### Example 2

Let's install `STAR`. It's a standard tool so we expect it's on bioconda.

```bash
conda install -c bioconda star
``` 

will just work.

Otherwise, we could have run a seach:

```bash
conda search star
```

### Software installtion 2 - getting different versions

You may require a specific version (to reproduce results, other limitations)
Running the `conda search` command or browsing online will list available version.
If you search online, make sure the package has a Linux (pengion) logo. 
The search command only shows you what's availalbe on the machine you're on.

### Example 3 

If you for whatever reason want version `2.4.0j` of `star`, run

```bash
conda install -c bioconda star==2.4.0j
```

## Managing packages

* list installed packages: `conda list`
* see if a package is installed `conda list | grep <NAME>`

For more operations, see the [conda package management docs](https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-pkgs.html)



