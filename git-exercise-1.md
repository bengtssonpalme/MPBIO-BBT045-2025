---
title: Git Exercise 1
---

# Git Exercise 1 - Start tracking files


## Create a directory to house your work

You and your friends need to plan some apartment work.  Let's start
writing all those ideas down. Create a directory for this project:

At the termial, type:
~~~
mkdir apartment
cd apartment
~~~


## Start tracking changes

Now we can create a git repository inside this directory to track our
work. This step can be done at any time but let's see what happens:

~~~
git init
~~~

> *Note*: Git will give you a confirmation message that a repo has
> been created.  Note that a hidden directory called `.git` has been
> created in your project directory. This contains the actual

Now let's add some tasks for the living room. 

> *Note*: We'll be using a very basic text editor called `nano`.
>
> - To save, press `Ctrl-o`, then `[Enter]`.
>
> - To exit, press `Ctrl-x`

~~~
nano living_room.txt
~~~

Add some tasks to this file, e.g.
~~~
- paint
- bookcase
- couch
~~~
then save and close it.

How is this file handled by git? It isn't yet!
Take a look at the current status of the repo:

~~~
git status
~~~

Git tries to be helpful. It's worth reading these messages.
Sometimes they will tell you exactly what to do next.

Let's add our new file:

~~~
git add living_room.txt
~~~

Look at the status again. You will see that the file is now marked for
tracking at the next commit. Right now, it's only in the staging area
as a "new" file. To actually record all we've marked for

~~~
git commit -m "Start planning living room"
~~~

> *Notes*: 
>
> `-m` stands for "message". According to widespread practice, this should
> be short and in active form (i.e. "do thing" instead of "done thing") to reflect
> project to-do items
>
> Git really wants you to write a commit message. So if you only write
> `git commit`, git will open a text editor in which you are to write
> a description of the commit. Here you can also enter a longer
> description. Just add a blank line after the message and write what
> you think is informative.

That's it! Now the current state of the project is saved and you can always
compare future states to this one or come back to it.

To get the list of all revisions, along with relevant information, write:

~~~
git log
~~~

> *Note*: The long alphanumeric code after the word "commit" is the
> unique identifier of the revision. After merging branches, simply
> saying "revision 1" and "revision 2" stops making sense since the
> history is no longer linear.

