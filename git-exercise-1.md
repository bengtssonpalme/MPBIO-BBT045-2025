---
title: Git Tutorial
---
Log in to Vera using `ssh`, create a new directory for this tutorial (you can name it however you want but make it something informative like `git_tutorial`) and make it your working directory by moving into it. 

**Before you start:**
* Make sure you are in `/cephyr/users/YOUR_USERNAME/Vera/YOUR_GIT_TUTORIAL_DIRECTORY`
* Text that is in ALL_CAPS is meant to be replaced by your own text.
* If you are unsure about any command or want to explore the many possible options, run **`git help <command>`** (scroll with arrow keys and exit with `q`).
* You can also keep this [Git cheat sheet](https://training.github.com/downloads/github-git-cheat-sheet.pdf) or this  [Git interactive cheat sheet](https://ndpsoftware.com/git-cheatsheet.html#loc=workspace;) open in your browser to quickly lookup commands. 

___

# Part 1 - Tracking files

You and your friends are going to Norway for a ski trip in a few weeks. There are many things to organize and plan so you decide to make a list to keep track of everything you need to prepare.

Inside the `unix_tutorial` directory, create another directory for this ski trip.

```bash
mkdir ski_trip
cd ski_trip
```

Now you go ahead and create a git repository inside this directory. This will allow you to track changes to the files in the `ski_trip` directory.
Make sure you are in `/cephyr/users/YOUR_USERNAME/Vera/YOUR_GIT_TUTORIAL_DIRECTORY/ski_trip/` then **initialize a Git repository** (*repo*) inside your `ski_trp` directory by running:

```bash
git init
```
You will see a confirmation message telling you that a repo has been created. Now **run the `ls -a` command** to list all the files in the current directory, including the hidden ones.

You will see a hidden `.git` directory (you will not see it if you only run `ls`) that is used to store all the information about the project. Every time you save the state of your project (*commit*), Git basically takes a picture of what all your files look like at that moment and stores a reference to that snapshot.
If you delete the `.git` directory (don't do it) you will lose the entire project's history!

To **check the current status** of your project run:

```bash 
git status
```
The output of this command shows you a list of changes in the project and options on what to do with those changes. This command is very useful to understand what is going on so use it as oftern as you want.

Now let's **create a file** in which you will list the things you need for the ski trip. 

```bash
nano equipment.txt
```

Adding a few items to the file, for example: 
```
- skis
- boots
- helmet
- goggles
```

Then save `[Ctrl]-s` and close `[Ctrl]-x` the file.


How is this file handled by git? Take a look at the current status of the repo:

```bash
git status
```
Git detects the new file as *untracked*, this means that that Git isn’t keeping track of this file yet. You can tell Git to start tracking it with the **`git add`** command.

```bash
git add equipment.txt
```
Check what happened with `git status`.
The file has been added to the *staging area*, to actually record a snapshot of the file you need to **commit** what's in the staging area:

```bash
git commit -m "Start planning ski trip"
```

* `-m` stands for *message* &rarr; This should be short, imperative (i.e. "do thing" instead of "done thing") and state the context or purpuse of the change. It's not supposed to describe what has been done in detail, since that can be seen by inspecting the commit.

* If you only write `git commit`, Git will open your default text editor for you to write the commit message (git *really* wants you to write a commit message) where you can enter a longer description. 
If your default text editor is `Vim` and you find yourself trapped in the text editor, here is how you can write your commit message and exit:
  - Type your commit message in the first line after the comment lines.
  - To save and exit press `[Esc]` to ensure you are in normal mode, then type `:qw` and press `[Enter]` 

> **Notes**: 
>
> Everything that is to be tracked needs to pass through the **staging area** before being committed. While this seems tedious, it allows you to choose which changes to commit at any given point.
> If you think of Git as taking snapshots of changes over the life of a project, **`git add`** specifies what will go in a snapshot (putting things in the staging area), and **`git commit`** then actually takes the snapshot, and makes a permanent record of it (as a commit) inside the special `.git` directory.
> This allows us to commit our changes in stages and capture changes in logical portions rather than only large batches. 
> You can bypass it by saying `git commit --all`however, it’s almost always better to explicitly add things to the staging area, because you might commit changes you forgot you made. 
>
> If you want to add all changes made to the repo or add all untracked files, run `git add --all`.
> 
>Always remember to **commit as little as sensible in one go**. It will save people headaches in the future, especially when you're modifying an existing repo, with lots of files and data.  
>For instance, if you change several files, you should commit each file separately (unless it's critical that these changes be synchronized). This helps in at least 3 situations:
>- You need to undo changes in a single file at some point in the future.
>- Somebody else needs changes from only one of these files.
>- You can quickly make sense of what has been changed in any revision.


The staging area is now cleared and if you run `git status` again it should tell you that everything is up to date. 

Now that the current state of the project is saved, you can always compare future states to this one or come back to it.

To get the **list of all commits** made to a repository in reverse chronologiacl order run:

```bash
git log
```
For each commit it will show the **commit’s unique identifier**, the commit’s author, when it was created, and the log message Git was given when the commit was created.

*Sometimes output like this from git can be very long and Git will display this text through a program that allows scrolling vertically through the whole output (using up/down keys). You will notice when this happens since at the bottom of the screen you will see a `:` prompt, not the bash terminal. Press `q` to quit this scrollable display and return to the command line.*

If you only want the last `K` commits, run:

```bash
git log -n K
```

### Sumary
> `git init` &rarr; creates an empty repository.
> `git status`  &rarr; shows the current status of your project.
> `git add`  &rarr; adds the file to the staging area.
> `git commit -m`  &rarr; creates a commit with the staged changes.
> `git log` &rarr; shows the project history



___

# Part 2 - Making changes

Your ski trip is next week and the weather forecast says it will be very cold. Add some warm clother to your packing list. 

## Keeping track of new work

Open the file with `nano`, add *gloves* and *wool socks* to the list, then save and exit the editor. You can check your updated file using `cat`, it should look something like this: 
```
- skis
- boots
- helmet
- goggles
- gloves
- wool socks
```

How has this change affected the state of the repo? Run:
```bash
git status
```

You will see that Git lists `equipment.txt` as modified.

To **compare the current working directory status with the latest commit** you can use `git diff`. If you don't specify a file when running the command, by default it will show differences for all files that have changes in the working directory compared to the latest commit. To limit the `diff` to a specific file (or files), you can include the filename(s) as arguments.

This command is useful when you want to:
  * See what uncommitted changes you have made.
  * Review your edits before staging or committing them.

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

1.	**Header information**
    * diff --git a/file.txt b/file.txt &rarr; Indicates the comparison between two versions of file.txt.
    * abc123 &rarr; Hash of the committed version.
    * def456 &rarr; Hash of the working directory version.
    * 100644 &rarr; File permissions (regular file, read/write).

2.	**File versions**
    *	--- a/file.txt &rarr; The committed version.
    * +++ b/file.txt: &rarr; The current working directory version.

3.	**Line changes**
    *	-1,2 &rarr; The original file had 2 lines starting at line 1.
    *	+1,3 &rarr; The modified file now has 3 lines starting at line 1.
    *	+This is the third line. &rarr; A new line was added (indicated by the `+`).



Now look at the differences between the current version of the `equipment.txt` file and the latest commit by running:
```bash
git diff
```

After reviewing the changes, it's time to record them. Add the file to the staging area and then commit along with a commit message:

```bash
git add equipment.txt
git commit -m "add warm clothes"
```

Now that you have commited, inspect the log:

```bash
git log
```

To **compare any current file to its state in a specific commit**, give that revision ID (long alphanumerical sequence) as a parameter to the `git diff` command, as below.
*Note that your IDs will be different.*

```bash
git diff 0ecfb80ba19e5ede972ed3e6dc22c82f2015812c equipment.txt
```
You can also use only the first 6 letters:

```bash
git diff 0ecfb8 equipment.txt
```
___

You receive a message from one of your friends that is coming with you on this ski trip. They read in the AirBnB's description that there is a sauna. Add *swimsuit* to the packing list!

By now you should know the drill: modify, add and commit. You can run `git status` after each command to check what's happening.

1. Modify the file to add *swimsuit* to the packing list, save and exit the editor.
    ```bash 
    nano equipment.txt
    ```
2. Add the updated file to the staging area.
    ```bash 
    git add equipment.txt
    ```
3. Commit along with a commit message.
    ```bash 
    git commit -m "YOUR COMMIT MESSAGE"
    ```

## Reverting changes

It's the day before your ski trip and you get a message from you AirBnB host: unfortunately the sauna is broken (˙◠˙). This means that you will not need your swimsuit and you can remove it from your packing list.  

We should then revert the `equipment.txt` file to one of its previous versions using the **`git checkout <commit ID> <file>`**. This commans updates the working directory version of the specified file to match its state in the given commit. 

### Visual example
*Before running the `git checkout` command the `<file>` matches the version in *Commit 3*. Here’s how the repository looks like before checking out the file:*
```bash
o  Commit 3 (HEAD -> main)  <-- Current commit
|
o  Commit 2
|
o  Commit 1
```
*After you run the command:*
```bash
git checkout <commit-2> <file>
```
1.	*The working directory version of `<file>` is replaced with its state from *Commit 2*.*
2.	*`git status` will show that the `<file>`file has been modified.*
3.	*The commit history remains unchanged.*
    ```bash
    o  Commit 3 (HEAD -> main)  <-- Current commit
    |
    o  Commit 2
    |
    o  Commit 1
    ```
*To save the change, the file needs to be added and commited:*
```bash 
git add <file>
git commit -m "Revert <file> to its state in Commit 2"
```

*Now the commit history of our repository will look like this:*

```bash
o  Commit 4 (HEAD -> main)  <-- New commit
|
o  Commit 3
|
o  Commit 2
|
o  Commit 1
```
**Commit 4* contains only the reverted `<file>` from *Commit 2*, while the rest of the files remained as they were in *Commit 3*.*


Now you are ready to **checkout the `equipment.txt`file** so that it matches the version in which the swimsuit was not present in the list. 
You need to tell git which commit to get by giving its ID. Run `git log` to find the commit message that you know was set to the commit you're looking for. Then copy its ID (*note that your ID will be different from the one in the command below*) and use it to checkout the `equipment.txt` file to that commit. 

Careful that you **write the name of the file**, `checkout` does something quite different without a specified file name (*you would end up in the "detached HEAD state". Scary, I know.*)

```bash
git checkout 0ecfb80ba19e5ede972ed3e6dc22c82f2015812c equipment.txt
```
Git modifies the working directory version of the file to match the specified commit (0ecfb8).
If you run `git status` you will see that `equipment.txt` is marked as modified, you can now stage and commit the changes. 

```bash
git add THE_FILE_NAME
git commit -m "YOUR COMMIT MESSAGE"
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
* Book chapter: [Git basics](https://git-scm.com/book/en/v2/Git-Basics-Getting-a-Git-Repository)


<hr />

Chalmers University of Technology 

<footer style="font-size:0.6em">

<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">
<img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/80x15.png" />
</a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a>.

</footer>
