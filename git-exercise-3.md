---
title: Git Exercise 3
---

# Git Exercise 3 - Collaboration

Now we're going to look at using git to contribute to projects.  Make
sure you're not still in the `apartment` directory. Run `pwd` to see
where you are, then `cd ..` to move one level up if you need to.


## Grab a clone of the project

We must first obtain a full copy of the project and its history.
This is done with `git clone` command, followed by the repo address.

~~~
git clone https://github.com/MPBIO-BBT015/apartment-project.git
~~~

> **Note**: Github is a hosting platform for git projects and is
> independent of git itself. There are other hosting platforms
> (GitLab, Atlassian, etc).

This will create a directory (clone) called `apartment-project`.
Move into it to allow git to perform operations on it:

~~~
cd apartment-project
~~~

This a more developed version of the project we've worked on so far.
Another difference is that the git repo has an "origin" set, namely
the address from which we cloned. You can inspect this by running:

~~~
git remote -v
~~~

Since your friends are also working on this (hopefully), changes will
occur to this repo. To get an update at any time, run `git pull` like:

~~~
git pull origin master
~~~

Notice we are pulling from the origin we set while cloning. `master`
means we are pulling changes on the main (master) branch of the repo.
We should keep at least this one updated since we will be branching
off from it.


## Contribute something

Git encourages you to work with branches. Every new feature or fix you
work on should be on its own branch. The "master" branch is considered
the authoritative version of the project. It should always be usable.
The people responsible for the repo will merge in changes from other
branches into the master branch once e.g. testing is done.

Let's start work on our own branch. Replace `<team name>` with your
team's name. Different words may be separated by a "-" (minus)
character:

~~~
git branch <team-name>
~~~

Now let's see what we got. Run the following to see all branches:

~~~
git branch
~~~

You should see 3 branches: "master", "meta", and your new one.  The
current one is maked with an asterisk (and maybe color).  ("Meta" is a
branch through which somebody added a README file to the project).

Note that your new branch was created by duplicating the last revision
in the current branch. To move to the new branch, run:

~~~
git checkout <team-name>
~~~

Now we can make all the changes we want without disturbing anyone's
work. Do whatever you like with these files. Change a few, add, or
delete some. Go wild! When you're done, go through the daily routine:

~~~
git status
git add <file names you changed, added or deleted>
git commit -m "Ideas from <team-name>"
git log --branches --graph
~~~

> **Note**: The `--graph` parameter will connect revisions in the log by lines so
> you can visually trace the branches. A GUI applications is definitely
> better for this though.

Time to share your work! The command is `git push` and you need to
tell it where and what to push.  Assuming you named you new branch
`<team-name>`, for you the command should look like:

~~~
git push origin <team-name>
~~~

You will be prompted to enter your username (MPBIO-BBT015-team1, ..2,
etc) and password.

> **Notes**:
>
> Keep in mind we've simplified some things for you in this tutorial.
> You cannot push to Github without an account. Here, one is
> provided for you.
>
> It is possible to use SSH instead of HTTPS when transferring changes
> to and from Github. SSH keys take more work to set up but afterwards
> you no longer need to enter credentials on each push.

> You will decide with your collaborators how to manage
> different branches.  The simplest set-up is something like a branch
> called "bugfixes", one called "development" or "work-in-progress". A
> far more flexible approach is to create a new branch for each
> contribution (e.g. branches "bug #213", "feature #12").


## Merging in from different branches

If you are the person responsible for merging in other people's work
or you simply need things from a different branch, you can merge in
these changes. To do so:

* move to the branch you want to move **into**: 
  `git checkout <receiving-branch>`

* run the merge command stating the branch you're merging from:
  `git merge <branch-with-stuff-we-want>`
  
* check what happened: `git status`, `git log --graph`


## Take-aways

* Work on branches
* Follow the practices decided by the project team
* Keep your clone updated



# Further Reading

* https://www.atlassian.com/git/tutorials/using-branches
* https://www.atlassian.com/git/tutorials/using-branches/git-merge
* [Github Tutorial](https://guides.github.com/activities/hello-world/)
* https://help.github.com/articles/connecting-to-github-with-ssh/
* Rather influential blog post on a branching model http://nvie.com/posts/a-successful-git-branching-model/



<hr />

Chalmers University of Technology 2018

<footer style="font-size:0.6em">

<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">
<img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/80x15.png" />
</a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a>.

</footer>

