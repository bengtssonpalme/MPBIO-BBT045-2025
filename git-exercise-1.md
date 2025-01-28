---
title: Git Tutorial
---
Log in to Vera using `ssh`, create a new directory for this tutorial (you can name it however you want but make it something informative like `git_tutorial`) and make this new directory your working directory by moving into it. 
Before moving on to the actual tutorial make sure you are in `/cephyr/users/YOUR_USERNAME/Vera/YOUR_GIT_TUTORIAL_DIRECTORY`.

Before you start:
* Git has extensive documentation. If you are unsure about any command or want to explore the many possible options, run **`git help <command>`** to get this information. (Scroll with arrow keys and
exit with `q`.)

* Here is a comprehensive [Git cheat sheet](https://training.github.com/downloads/github-git-cheat-sheet.pdf), but you can find many others online.

* And here you can find a very nice [Git interactive cheat sheet](https://ndpsoftware.com/git-cheatsheet.html#loc=workspace;)

* Check the *course website homepage* and the *"Further reading"* section at the bottom of this page for more Git resources.
___

# Part 1 - Tracking files

You and your friends are going to Norway for a ski trip in a few weeks. There are many things to organize and plan so you decide to make a list to keep track of everything you have to prepare.

Inside the `unix_tutorial`directory, create another directory for this ski trip:

```bash
mkdir ski_trip
cd ski_trip
```

## Start tracking changes
Now we can create a git repository inside this directory to track changes to the files in the `ski_trip` directory.
To  initialize a Git repository (*repo*) inside your `ski_trp` directory run:
```bash
git init
```
You will see a confirmation message telling you that a repo has been created and a hidden subdirectory called `.git`. 
Type:

```bash
ls -a
```
The `.git` directory stores all the information about the project, including the tracked files and sub-directories located within the project’s directory. If you delete the `.git` subdirectory (don't do it) you will lose the entire project's history!

To check the current status of your project run:

```bash 
git status
```
The output of this command shows you a list of changes in the project and options on what to do with those changes. This command is very useful to understand what is going on so use it as oftern as you want.

Now let's create a list of things we need for the ski trip. 

```bash
nano equipment.txt
```

Start adding things to the file, for example: 
```
- skis
- boots
- helmet
- goggles
```

Then save and close the file.
- To save, press `[Ctrl]-s` (So the `Control` and `S` key at the same time)
- To exit, press `[Ctrl]-x`

How is this file handled by git? It isn't yet!
Take a look at the current status of the repo:

```bash
git status
```
Git detects the new file as untracked when you run git status. This means that that Git isn’t keeping track of this file yet. We can tell Git to track it by using `git add`.

Let's **add** our new file:

```bash
git add equipment.txt
```
The content of the file has been added to the staging area and will be included in the next commit.
Check what happened with `git status`

To actually record a snapshot of the file run:

```bash
git commit -m "Start planning ski trip"
```

* `-m` stands for "message". 
This should be short and in the imperative mood (i.e. "do thing" instead
of "done thing") and state the context or purpuse of the change. It's not supposed to describe *what* has been done in detail, since that can be seen by inspecting the revision.

* If you only write `git commit`, git will open your default text editor for you to write the commit message (git *really* wants you to write a commit message). Here you can enter a longer description. 
If your default text editor is `Vim` and you find yourself trapped in the text editor, here is how you can write your commit message and exit:
  - Type your commit message in the first line after the comment lines.
  - To save and exit press `[Esc]` to ensure you are in normal mode, then type `:qw` and press `[Enter]` 

When we run git commit, Git takes everything we have told it to save by using `git add` and stores a copy permanently inside the special `.git` subdirectory. This permanent copy is called a commit (or revision). The staging area is now cleared.

Now that the current state of the project is saved and you can always compare future states to this one or come back to it.

If you run `git status` again it should tell you that everything is up to date. 

> **Recap**
> 1.	`git init` creates an empty repository.
> 2.	`git add` moves the file to the staging area.
> 3.	`git commit` creates a commit with the staged changes.
> 4. `git status` shows the current status of your project.

To get the **list of all commits** made to a repository in reverse chronologiacl order run:

```bash
git log
```

If you only want the last `K` commits, run:

```bash
git log -n K
```

For each commit it will show the **commit’s unique identifier**, the commit’s author, when it was created, and the log message Git was given when the commit was created.

*Sometimes output like this from git can be very long.  Git will display this text through a program that allows scrolling vertically through the whole output (using up/down keys). You will notice this happens since at the bottom of the screen you will see a `:` prompt, not the bash terminal. Press `q` to quit this scrollable display and return to the command line.*

## Take-aways
  
* To initializes a repository use `git init` 
* All the repository data gets stored in the `.git` hidden subdirectory
* To check the status of the project use `git status`
* Save a snapshot of your work by adding the file to the staging area with `git add` and then committing `git commit -m "your commit message"`
* To show the project's history use `git log`

___

# Part 2 - Making changes

Your ski trip is next week, it's time to start adding clothes to the packing list. 
The weather forecast says it will be very cold so you will need very warm clothes. 

## Keeping track of new work

Open the file with `nano`, add *gloves* and *wool socks* to the list, then save and exit the editor. You can check your updated file using `cat`, it should look like this: 
```
- skis
- boots
- helmet
- goggles
- gloves
- wool socks
```

How has this changed the state of the repo? Run:
```bash
git status
```

Git will list `equipment.txt` as modified, but we still haven’t told Git we will want to save (commit) those changes.

To **compare** the current working directory version of a file (or files) with the latest committed version, run:
```bash
git diff
```
This command is useful when you want to:
  * See what uncommitted changes you have made.
  * Review your edits before staging or committing them.

If you don't specify a file when running `git diff`, by default it will show differences for all files that have changes in the working directory compared to the latest commit.
If you want to limit the diff to a specific file (or files), you can include the filename(s) as arguments.

In the output you will see:

```bash 
### EXAMPLE OUTPUT
diff --git a/file.txt b/file.txt
index abc123..def456 100644
--- a/file.txt
+++ b/file.txt
@@ -1,2 +1,3 @@
 Hello, world!
 This is the second line.
+This is the third line.
```
1.	Header Information
    * diff --git a/file.txt b/file.txt &rarr; Indicates the comparison between two versions of file.txt.
    * abc123 is the hash of the committed version.
    * def456 is the hash of the working directory version.
    * 100644 is the file permissions (regular file, read/write).
2.	File Versions
    *	--- a/file.txt: Represents the committed version (HEAD).
    * +++ b/file.txt: Represents the current working directory version.
3.	Line Changes
    *	-1,2 &rarr; The original file had 2 lines starting at line 1.
    *	+1,3 &rarr; The modified file now has 3 lines starting at line 1.
    *	+This is the third line. &rarr; A new line was added (indicated by the `+`).


This ability to inspect differences using standard tools is another reason so many projects have documentation in plain text formats (Markdown, HTML, etc.).  While possible, diffing e.g. PDFs and Word files require extra programs that may or may not work and the process is no longer transparent. Text is (almost) universal and is accessible by any program.

After reviewing the changes, it's time to record them. The file first needs to be added to the staging area and then commited along with a commit message:

```bash
git add equipment.txt
git commit -m "add warm clothes"
```

> **Notes**: 
>
> Everything that is to be tracked needs to pass through the **staging area** before being committed. While this seems tedious, it allows you to choose which changes to commit at any given point.
> If you think of Git as taking snapshots of changes over the life of a project, **`git add`** specifies what will go in a snapshot (putting things in the staging area), and **`git commit`** then actually takes the snapshot, and makes a permanent record of it (as a commit).
> This allows us to commit our changes in stages and capture changes in logical portions rather than only large batches. 
> You can bypass it by saying `git commit --all`however, it’s almost always better to explicitly add things to the staging area, because you might commit changes you forgot you made.. 
>
> If you want to add all changes made to the repo or add all untracked files, run `git add --all`.
> 
>Always remember to **commit as little as sensible in one go**. It will save people headaches in the future, especially when you're modifying an existing repo, with lots of files and data.  
>For instance, if you change several files, you should commit each file separately (unless it's critical that these changes be synchronized). This helps in at least 3 situations:
>- You need to undo changes in a single file at some point in the future.
>- Somebody else needs changes from only one of these files.
>- You can quickly make sense of what has been changed in any revision.

Now that you have commited, inspect the log:

```bash
git log
```

You will see the commits in reverse chronological order, marked by their unique IDs (long alphanumerical sequences). 

To **compare any current file to its state in a certain revision**, give that revision ID as a parameter to the `git diff` command, as below.

*Note that your IDs will be different.*

```bash
git diff 0ecfb80ba19e5ede972ed3e6dc22c82f2015812c living_room.txt
```

You can use only the first 6 letters:

```bash
git diff 0ecfb8 living_room.txt
```

You get a message from one of the friends that is coming with you on this ski trip. They read in the description of the AirBnB you will be staying at that there is a sauna so you should also pack a swimsuit!

By now you should know the drill: modify, add and commit. You can run `git status` after each command to check what is happening.

1. Modify the file to add *swimsuit* to the packing list, save and exit the editor.
    ```bash 
    nano equipment.txt
    ```
2. Add the file with the changes to the staging area.
    ```bash 
    git add equipment.txt
    ```
3. Commit the changes along with a commit message.
    ```bash 
    git commit -m "add swimsuit"
    ```

## Reverting changes

It's the day before your ski trip and you get a message from you AirBnB host: unfortunately the sauna is broken (˙◠˙). This means that you will not need your swimsuit and you can remove it from your packing list.  

We should then revert the `equipment.txt` file to one of its previous version using the `git checkout` command to update the file in your working directory to match its state in a previous commit.

When you use **`git checkout <commit ID> <file>`**, it updates the working directory version of the specified file to match its state in the given commit. However, the repository history and branch pointers (*like HEAD, more about this below*) remain unchanged. 

Before running the `git checkout` command the `<file>` matches the version in *Commit 3*. Here’s how the repository looks like before checking out the file:
```bash
o  Commit 3 (HEAD -> main)  <-- Current commit
|
o  Commit 2
|
o  Commit 1
```
After you run the command:
```bash
git checkout <commit-2> <file>
```
1.	The working directory version of `<file>` is replaced with its state from *Commit 2*.
2.	`git status` will show that the `<file>`file has been modified.
3.	The branch and commit history remain unchanged.
    ```bash
    o  Commit 3 (HEAD -> main)  <-- Current commit
    |
    o  Commit 2
    |
    o  Commit 1
    ```
To save the change we made to our file:
1. Stage the file
    ```bash 
    git add <file>
    ```
2. Commit the change
    ```bash 
    git commit -m "Revert <file> to its state in Commit 2"
    ```
After commiting the change this, the commit history of our repository will look like this:
```bash
o  Commit 4 (HEAD -> main)  <-- New commit
|
o  Commit 3
|
o  Commit 2
|
o  Commit 1
```
*Commit 4* contains only the reverted `<file>` from *Commit 2*, while the rest of the files remain as they were in *Commit 3*.

Now we are ready to reverse our `equipment.txt`file so that it matches the version in which "swimsuit" was not present in the list. You need to tell git which commit to get by giving its ID.
Run `git log`, find the commit message that you know was set to the commit you're looking for and copy its ID (*note that your ID will be different from the one in the command below*) and use it to checkout the `equipment.txt` file to that commit. 
Careful that you **write the name of the file**, `checkout` does something quite different without a specified file name (*you would end up in the so-called "detached HEAD state". Scary, I know.*)

```bash
git checkout 0ecfb8 equipment.txt
```
Git modifies the working directory version of the file to match the specified commit (0ecfb8).
If you run `git status` you will see that `equipment.txt` is marked as modified, you can now stage (`git add`) and commit the changes. 

```bash
git commit -m "Your commit message"
```

___

# Extras
The information in this section is just for your own knowledge and understanding of Git. It is good to know that these things exist even though we don't have the time to cover them in this tutorial. 

## Undoing all uncommited changes
The `HEAD`tag refers to the latest commit on the current branch. It represents the current state of the repository.
If we run **`git checkout HEAD equipment.txt`** we replace the version of the file in our working directory with the version in the latest commit &rarr; This command **undoes any uncommitted changes** to the file, restoring it to its last committed state.
  * *Unstaged changes are overwritten* &rarr; If you’ve modified the file in your working directory but haven’t staged or committed those changes, this command will discard them.
  * *Staged changes are not affected* &rarr; If the file has changes staged for commit, running the command does not affect the staged changes, it only updates the working copy.

## Undoing changes made by a specific commit
In this tutorial we have looked at how to go back to a *previous verion of a file* . You can also perform similar operations to undo all the changes done by a specific commit using `git revert <commit ID>`. This command is a safe and history-preserving way to undo a specific commit: it creates a new commit that undoes the changes made by the specified commit.
Instead of removing the commit from the repository’s history, it reverses the changes made by the specified commit while preserving the repository’s history.
This ensures that:
* The repository’s history remains intact (linear and traceable).
* No commits are deleted or rewritten, which is important in collaborative environments.

Assume your commit history looks like this:
```bash
o  Commit 3 (HEAD -> main)
|
o  Commit 2
|
o  Commit 1
```
If you run:
```bash
git revert <Commit 2>
```
You’ll get a new commit that reverses the changes made in *Commit 2*:
```bash
o  Revert "Commit 2" (HEAD -> main)
|
o  Commit 3
|
o  Commit 2
|
o  Commit 1
```
## Detached HEAD state
**Do not use `git checkout <commit ID>` to undo changes** that were committed since then. This command allows you to inspect or temporarily work with the state of the repository at a specific commit. However, IT moves you to a detached HEAD state, meaning that the HEAD is no longer attached to a branch. Instead, it points directly to the specified commit.
In this state:
  * You are not on a branch.
  * Any changes you make and commit will not be associated with the current branch unless you explicitly create a new branch to hold those changes.

If you just check out a commit, it does not undo changes in the repository’s history. Instead, it allows you to inspect or temporarily work with the state of the repository at that commit. If you create commits in this detached HEAD state, you must create a branch or lose those commits when switching back to a branch.
 
See the *Reset,Checkout, and Revert* page under *Further Reading* below for more details.


## Take-aways
* To displays differences between commits use `git diff`
* You can see unique commit IDs with `git log`
* You can  explore and retrieve any committed version of a file with `git checkout`
* Make small commits

## Further reading
* A very good [Git tutorial by software carpentry](https://swcarpentry.github.io/git-novice/index.html) (inspiration for this tutorial)
* [Good commit messages](https://chris.beams.io/posts/git-commit/)
* [Reset, Checkout, and Revert](https://www.atlassian.com/git/tutorials/resetting-checking-out-and-reverting)
* The many ways you can [diff](https://git-scm.com/docs/git-diff) between revisions (including ranges and across branches)
* The many ways to [refer to revisions](https://git-scm.com/docs/gitrevisions) (including things like "5 revisions before X")


<hr />

Chalmers University of Technology 

<footer style="font-size:0.6em">

<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">
<img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/80x15.png" />
</a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a>.

</footer>
