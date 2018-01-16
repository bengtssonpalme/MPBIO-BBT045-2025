---
title: Git Exercise 2
---

# Git Exercise 2 - Making changes


## Keeping track of new work

You thought of a few more things for the living room after talking
with your friends.  Open the file with `nano living_room.txt`, then
add "decorate" and "change lights". The file should now look like
below. Save it and exit the editor.

~~~
- paint
- move furniture
- decorate
- change lights
~~~

How has this changed the state of the repo? Run:

~~~
git status
~~~

Git will list `living_room.txt` as modified. You can always inspect
how the current working version differs from any previous revision
version. To simply compare with the latest committed version, execute:

~~~
git diff
~~~

This will list all differences from the last revision. If you had more
files and only wanted to see differences in some of these, run `git
diff` followed by the file names you want to see, separated by space.

The format can be a bit hard to read, but look for lines marked with
`-` and `+`. These mark lines that were removed and added,
respectively.

> **Notes**:
>
> The diff tool marks changes per line. So for changes inside a line,
> you'll see that line removed and added with the changes.
>
> While not guaranteed to be available for any given system, visual
> diff tools can make life much easier. For Windows and Linux, check
> out [Meld](http://meldmerge.org) and for macOS there are
> [DiffMerge](https://sourcegear.com/diffmerge/) and FileMerge
> (included in XCode). These can be used independently of any
> versioning tracking system to compare any files and directories.
>
> This ability to inspect differences using standard tools is another
> reason so many projects have documentation in plain text formats
> (Markdown, HTML, etc.).  While possible, diffing e.g. PDFs and Word
> files require extra programs that may or may not work and the
> process is no longer transparent. Text is (almost) universal and is
> accessible by any program.


Let's record the changes. These first need to be added to the staging
area:

~~~
git add living_room.txt
~~~

> **Notes**: 
>
> Everything that is to be tracked needs to pass through the
> staging area before being committed. While this seems tedious, it
> allows you to choose which changes to commit at any given point.
> And if you really hate the feature, you can bypass it by saying `git
> commit --all` but be careful about adding unwanted files and changes. 
>
> If you want to add all changes made to the repo or add all untracked
> files (in all files!), run `git add --all`.


> **_Important Note_**: 
> 
>Always remember to commit as little as sensible in one go. It will
>save people headaches in the future, especially when you're modifying
>an existing repo, with lots of files and data.  For instance, if you
>change several files, you should commit each file separately (unless
>it's critical that these changes be synchronized). This helps in at
>least 3 situations:
>
>- you need to undo changes in a single file at some point in the
>future
>- somebody else needs changes from only one of these files
>- quickly making sense of what has been changed in any revision

And now commit the changes and inspect the log.

~~~
git commit -m "Add items as per discussion"
git log
~~~

You will see the revisions in reverse chronological order.
To compare any file to its state in any of the listed revisions,
give the revision ID as a parameter, as below.
(You should be able copy and paste in the terminal window, to spare
yourself the typing.)

~~~
git diff 0ecfb80ba19e5ede972ed3e6dc22c82f2015812c living_room.txt
~~~

> **Note**: Some tools (e.g. Github) will show you a shorter ID.
> The reason is that for a single repo, shorter sequences may be used
> to uniquely identify revisions, but git tries to be absolutely sure
> each ID is unique, hence the longer "true" ID.
> You're of course not supposed to know these IDs. 
> Rather, go through the log and look for the appropriate commit message
> and use whatever ID is given there.

## Reverting changes

Let's say you've changed your mind and the extra tasks aren't
feasible. So we should revert the living room file to a previous
state.  We can use the `checkout` command for this. (Think of it like
"checking out" a book copy from a library.)

You will need to tell git which revision to get by giving its ID. So
run `git log` first (or look at the output from the last time you ran
it), then find the commit message that you know was set to the
revision you're looking for. When in doubt, diff with revision to
check.

**Note**: your IDs will be different.

**Careful** though that you write the name of the file. 
`checkout` without a specified file name does something quite different
(confusingly enough).

~~~
git checkout 0ecfb80ba19e5ede972ed3e6dc22c82f2015812c living_room.txt
~~~

But remember that git considers anything deviating from the **last**
revision as a difference. (Well, technically, from the revision marked
as `HEAD` - more below). If you run `git status` you will see
that `living_room.txt` is marked as modified and it's already in the
staging area.
This is because we haven't modified the version we checked out any way.

So we only need to commit this change:

~~~
git commit -m "Revert file after further consideration"
~~~

This action can be performed on uncommitted changes. To undo any
changes since then, simply run the command below. The `HEAD` tag
points to the current revision in the repo, normally the last to be
committed. Some operations can move this tag to a given branch or
revision.

~~~
git checkout HEAD living_room.txt
~~~

> **_Important Note_**
>
> Here we have looked at operations per file. You can also perform
> similar operations on entire revisions. *However*, the commands work
> differently.
>
> _Do not_ use `git checkout <revision ID>` to undo changes that were
> committed since then. This "detaches" the `HEAD` tag and would
> naturally be followed by a branching operation or deletion of all
> revisions after that point. You should use `git revert <revision
> ID>` instead, which simply adds a new commit undoing the changes in
> the given revision, not touching the repo history. See the *Reset,
> Checkout, and Revert* page under *Further Reading* below for more
> details.


## Take-aways

* `git status` and `git log` are your friends :octocat:
* make small commits
* you can always explore and retrieve any committed version of a file


## Further Reading
* [Reset, Checkout, and Revert](https://www.atlassian.com/git/tutorials/resetting-checking-out-and-reverting)


# Next

[Exercise 3](git-exercise-3.md)



<hr />

Chalmers University of Technology 2018

<footer style="font-size:0.6em">

<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">
<img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/80x15.png" />
</a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a>.

</footer>
