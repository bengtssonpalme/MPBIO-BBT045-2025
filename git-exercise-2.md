---
title: Git Exercise 2
---

# Git Exercise 2 - Making changes

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

How has this changed the state of the repo? Run

~~~
git status
~~~

Git will list `living_room.txt` as modified. You can always inspect
how the current working version differs from any previous revision
version. To simply compare with the latest committed version, execute

~~~
git diff
~~~

This will list all differences from the last revision. If you had more
files and only wanted to see differences in some of these, run `git
diff` followed by the file names you want to see, separated by space.

The format can be a bit hard to read, but look for lines marked with
`-` and `+`. These mark lines that were removed and added,
respectively.

> *Notes*:
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

Let's record the changes. These first need to be added to the staging
area:

~~~
git add living_room.txt
~~~

> *Notes*: 
>
> Everything that is to be tracked needs to pass through the
> staging area before being committed. While this seems tedious, it
> allows you to choose which changes to commit at any given point.
> And if you really hate the feature, you can bypass it by saying `git
> commit --all` but be careful about adding unwanted files and changes. 
>
> If you want to add all changes made to the repo or add all untracked files (in all files!), run
> `git add -all`.


> **Important Note**: 
> 
>Always remember to commit as little as sensible in one go. It will
>save people headaches in the future. For instance, if you change
>several files, you should commit each file separately (unless it's
>critical that these changes be synchronized). This helps in at least
>3 situations:
>
>- you need to undo changes in a single file at some point in the
>future
>
>- somebody else needs changes from only one of these files
>
>- quickly making sense of what has been changed in any revision

And now commit the changes and inspect the log.

~~~
git commit -m "Add items as per discussion"
git log
~~~

You will see the revisions in reverse chronological order.

