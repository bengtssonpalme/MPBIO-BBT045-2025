# The philosophy of UNIX tools (and the main reason they are still popular after 40+ years)
 
One quick formulation of this philosophy is:

 1. **Programs should do one thing and do it well.**
 2. **Programs should work together.**
 3. **Programs should handle text, because that is a universal interface.**
 
*Note*: macOS and Linux are both different types of UNIX operating systems.
So they work quite similarly under the hood.
 
 
## Principles 1 and 2
 
The great strength of these standard tools is the ability to chain together
different operations in (potentially automated) sequences.
 
### Example

Say you need to process some files like:

- find entries of interest
- extract values
- summarize results
 
To achieve this, you can construct a chain of programs on the command line that looks like:

~~~ 
files ==> [finder program] ==results==> [extractor program] ==results==> [summary program]
~~~

Since programs are specialized and connectible you may construct these chains
as you wish.
 
There are of course graphical tools on any platform that allow you to do this
(whether they exist on some random server you find yourself working on is a
different issue). Even the built-in tools or file operations on Windows or
macOS can be used for some of these tasks. But since you are running such
commands by clicking around, only one operation is performed at a time.
 
For instance, the graphical alternative would be something like:

1) enter text in search box of your folder window: get results in same window
2) right click files > call extractor program: opens new window waiting for 
   your commands or dumps results somewhere and you need find them
3) etc..
 
Not to mention that you're constantly flipping between various programs and
folders.

This may be perfectly fine for small batches of work, but once you
run into repetitive procedures, the computer should do the work, not you.
 
Furthermore, graphical tools tend be tailored to exactly one purpose and
difficult or impossible to change. The best case then is to have software that
constructs pipelines, like KNIME. The drawback with that though is that the
structure of the pipeline is not immediately accessible for inspection /
modification from outside KNIME. And the software and its formats *will*
change over time. So there is the risk you get locked in a given program
whereas the command line works "outside" of any one program.
 
Obviously, for visualizing contents, graphical tools are usually better (if
available).
 
 
## Principle 3
 
This may not be immediately obvious, but it's extremely hard technically to
account for all possible ways in which data may be represented. Anything
except plain text (which includes Markdown, HTML, XML) has a lot of extra
information about how the data is structured. Often the data itself is not
even humanly readable - it can be compressed or encoded. Just try opening a
PDF in a text editor like Notepad. Not to mention standards change (e.g. Word
pre-2003 and after).
 
So the standard Unix tools can only assume text when passing output to each
other. One can place converters along the chain of programs to e.g. take in
an Excel file and output the text version of it. But the underlying
communication between programs ought to be text.
 
This is the reason one tends to work in a "text world" with these tools.
However, the command line is only an interface, just like windows on the
screen. It helps if you think about it like a dialog: you tell the OS what to
do and it responds.
 
 
## Downsides
 
This way of working is obviously not perfect
(see https://en.wikipedia.org/wiki/Unix_philosophy#Criticism
(and many angry forum discussions).
 
One problem (on a standard system) is the lack of immediate feedback to the user -
the feeling of working blind. Cognitive ergonomics ("UX" in some
circles) is a real thing. Human-computer interfaces ought to be designed in
such a way as to account for psychology (appropriate cognitive load = not too
much information at once, highlighting only important information, giving good
feedback, trying to minimize mistakes etc.)
 
Then you have the hundreds of commands and options one would need to master to be
productive. Sometimes one can figure out how to use a graphical program simply
by looking at the buttons and menus. On the command line, you're just staring
at a blinking cursor.
 
This environment is simply one solution to a huge variety of technical and
human demands. Like any tool, its useful for certain things.
