---
title: Git Exercise 1
---

# Git Exercise 1 - Start tracking files

Quick note: Git has extensive documentation. If you are unsure about
any command or want to explore the many possible options, run `git
help <command>` to get this information. (Scroll with arrow keys and
exit with `q`.)

## Create a directory to house your work

You and your friends need to plan some apartment work.  Let's start
writing all those ideas down. Create a directory for this project:

At the terminal, type:

```bash
mkdir apartment
cd apartment
```


## Start tracking changes

Now we can create a git repository inside this directory to track our
work. This step can be done at any time but let's see what happens in
a very simple situation:

```bash
git init
```

> **Note**: Git will give you a confirmation message that a repo has
> been created.  Note that a hidden directory called `.git` has been
> created in your project directory. This contains the actual revision
> database (all snapshots are in there).

Now let's add some tasks for the living room. 

> **Note**: We'll be using a very basic text editor called `nano`.
>
> - To save, press `[Ctrl]-s` (So `the Control and S key at the same time`)
> - To exit, press `[Ctrl]-x`
>
> Note thtat the Control key is used if you have a Mac as well

```bash
nano living_room.txt
```

Add some tasks to this file, e.g.

```
- paint
- move furniture
```

then save and close it.

How is this file handled by git? It isn't yet!
Take a look at the current status of the repo:

```bash
git status
```

Git tries to be helpful. It's worth reading the messages it outputs.
Sometimes they will tell you exactly what to do next.

Let's **add our new file**:

```bash
git add living_room.txt
```

Look at the status again. You will see that the file is now marked for
tracking. But right now, it's only in the *staging area* as a "new"
file.

To actually **record** its addition, we need to *commit* the contents of
the staging area:

```bash
git commit -m "Start planning living room"
```

> **Notes**: 
>
> `-m` stands for "message". According to widespread practice, this
> should be short and in the imperative mood (i.e. "do thing" instead
> of "done thing") to reflect project to-do items. It's also not
> supposed to describe *what* has been done in detail, since that can
> be seen by inspecting the revision. Stating the context or purpose
> is preferred.
>
> Git really wants you to write a commit message. So if you only write
> `git commit`, git will open a text editor in which you are to write
> a description of the commit. Here you can also enter a longer
> description. Just add a blank line after the message and write what
> you think is informative.

That's it! Now the current state of the project is saved and you can
always compare future states to this one or come back to it.

To get the **list of all revisions**, along with relevant information, run:

```bash
git log
```

If you only want the last `K` revisions, run

```bash
git log -n K
```

Sometimes output like this from git can be very long.  Git will
display ("pipe") this text through a program that allows scrolling
vertically through the whole output (using up / page up and down /
page down keys). You will notice this happens since at the bottom of
the screen you will see a `:` prompt, not the bash terminal. Press `q`
to quit this scrollable display and return to the command line.

> **Note**: The long alphanumeric code after the word "commit" is the
> unique identifier of the revision. After merging branches, simply
> saying "revision 1" and "revision 2" stops making sense since the
> history is no longer linear.


## Take-aways

* `git help <command>` probably has the information you need, if
  slightly technical. Scroll down to the bottom of these pages for
  examples.
  
* A git repo can be created anywhere with ease. A hidden directory
  called `.git` is created at that location and contains all the
  bookkeeping.
  
* Save a snapshot of your work by committing a git revision.


## Further reading

* [Good commit messages](https://chris.beams.io/posts/git-commit/)


# Next

[Exercise 2](git-exercise-2.md)



<hr />

Chalmers University of Technology 2018

<footer style="font-size:0.6em">

<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">
<img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/80x15.png" />
</a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a>.

</footer>
