;; Chapter 3 How to write function definitions
;; An introduction to Programming in Emacs Lisp
;; 2024-02-23

(defun multiply-by-seven (number)
  "Multiply the NUMBER by 7."
  (interactive "p") ;; interactive version
  (message "The result is %d" (* 7 number)))

* Update 2024-01-31: Somehow, I forgot to mention that each link is also a
bi-directional one. Fixed that.

As my wife is not happy to start using GNU Emacs with Org-mode as I
recommended to her, I was looking for an alternative. The general requirements
are those of a typical student, collecting all kinds of university- and
domain-related knowledge and - I presume it will take the usual direction -
contact management, information on things, household stuff, appointments, and
so forth. 

This article is a brief report on my personal experience from that journey.
It's not a tutorial. It's not describing the full set of features of mentioned
tools. This is just my remarks from an Org-mode point of view, mentioning
things that caught my eye. 

Many Tools to Consider

There are many knowledge management and note taking tools to choose from:
personal wikis, general purpose wiki tools, note-taking software, and so
forth. 

I can't test all of them. I can't even take a look on a substantial part of
the listed solutions. They are too many. 

Obsidian is a current hype, just like Evernote and others were for a certain
period. I could never use solutions like that since they are proprietary
solutions which come with a large vendor lock-in I'll avoid at all cost. 

A knowledge-management tool is not a hype tool I'll use for a few years until
I switch to the next hyped solution. Such a tool should be a trusty companion
for decades, if not until the end of my (digital) life. 

So scratch Obsidian as one of the many proprietary solutions. 

Joplin

The first tool I took a closer look was Joplin. As with most solutions
nowadays, it also uses the Markdown lightweight markup language (LML) which is
the most well-known LML but by far not the best IMHO. 

Whatever, let's try it. 

My first impression was that it's actually not that bad. Joplin has a manually
curated hierarchy of "notebooks". Each notebook has one to many "notes" and
"tasks". Within a notebook, they are listed either in a custom order or they
are ordered by updated timestamp. Notes can contain Markdown list items with
checkboxes. 

This tool is note/todo-oriented as they seem to be the usual entity to work
with. 

You either see the Markdown source, or a side-by-side view of Markdown and its
rendered result or only the rendered result, which is read-only. 

Tags can be added via menu or shortcut. They are not visible n the note/todo
views. However, they are listed within the dynamic list of tags. When visited,
this dynamic view lists all notes and todos that were associated with that tag
in a temporary notebook view. 

You define a directory to store your data. In this directory, you see files
like 834bd20fb2d8432e8b80d87865c1b75d.md. If you re-use the Markdown files
with other tools, you first need to find out which file contains what note or
task. Tool configuration files are stored within directories in ~
/.config/joplin* on non-Windows systems. 

OK, so far so good. Let's take a look at another tool. 

Logseq and Its Markup

I got a recommendation to try Logseq via Mastodon. 

The name "Logseq" is an abbreviation of "logbook sequence" and it's pronounced
"log-seek" (and not "log-segg"). 

Visiting the project's website with activated NoScript, you don't see anything
at all. If you allow their website to execute arbitrary JavaScript code,
you'll notice that they point to their community on Discord and a forum.
Instantly, my article kicks in why such forums are a bad idea. But hey, that's
the current normal, I guess. 

Right after playing around with the locally installed Logseq for a few
minutes, it was very clear to me that Joplin is also off the list of
candidates. Logseq is so much better. 

First of all, Logseq is also using Markdown as the default LML. However, you
can switch to Org-mode syntax, for which I coined the term Orgdown for very
good reasons. The Orgdown web page also features a page where you can see a
number of software tools that support Orgdown to some extend. The list is
already longer than you'd probably expect! 

You can clearly see on many occasions (e.g., the documentation) that Markdown
is the main LML for Logseq. So far, I did not stumble on many things that were
not possible with Orgdown except one Markdown table plugin. Switching to the
much better Org-mode syntax is a good idea from my perspective. It's much
easier to learn, type and except from a few Logseq-specific extensions, it's
also very consistent in comparison to Markdown. 

Simple text formatting follows the same principle as Orgdown: 

/italic/ *bold* _underline_ +strikethrough+ ^^highlighted^^	  

You have noticed: the "highlighted" syntax was added by Logseq. It's where the
Markdown inconsistency is visible: here, it takes two characters for starting
the markup and another two for ending. Sigh. 

General Principles of Logseq

You need to learn a few concepts in order to understand Logseq basics. 

By selecting a local directory which will then hold your data files, you start
your first "graph". You can have multiple graphs in parallel but they are not
connected at all: you can't link one note of one graph to another node in a
different graph. I created a Syncthing share with my wife's computer and
started her graph in Logseq. 

Each graph comes with certain settings. For example, you can have one or many
graphs using Markdown and others with Orgdown default syntax. Unfortunately,
when you switch your default LML, the existing pages are not converted.
However, you can have Markdown and Orgdown mixed in a graph. Those pages can
also link to each other. 

Within a graph, you create "pages" which are not part of a hierarchy by
default. Each page does contain a hierarchy of "blocks". 

In contrast to Joplin, which is a note/todo-oriented tool, and Org-mode which
is a file/heading-oriented tool, Logseq is a block-oriented tool. That means
that you can add meta-data to each block and you can link to particular blocks
within a page. The smallest possible entity for links and such are blocks. 

A screenshot from Logseq that shows some features.
Logseq showing an example page. (click for a larger version)

On the file system, the same file looks like that: 

* This is an *example* /block/.
* This is another block. It features the tag #mytag which also links to [[mytag]].
* If you like to have spaces in page titles, you need to link them like #[[page title]] or [[page title]].
** Blocks can have sub-blocks.
*** You can indent them as you wish.
*** TODO this is a scheduled task
SCHEDULED: <2024-01-28 Sun>
*** Strange thing: headings can occur on each level.
*** This is a h1 heading
:PROPERTIES:
:heading: 1
:END:
*** This is no the same indentation level as the h1 heading.
**** Here is a particular famous block. 🤩
:PROPERTIES:
:id: 65b67977-9737-42d8-9bbe-045f5e0a6d68
:END:
* This is a h2 heading
:PROPERTIES:
:heading: 2
:END:
* Here is a link to the famous block: ((65b67977-9737-42d8-9bbe-045f5e0a6d68))
** DONE link the famous block
:PROPERTIES:
:id: 65b67ef7-aee6-40c4-936e-aa78ada5d748
:END:
SCHEDULED: <2024-01-28 Sun>
* You can also embed blocks or whole pages! Here, I embed the famous block:
** {{embed ((65b67977-9737-42d8-9bbe-045f5e0a6d68))}}
*	  

As you can see, the Orgdown headings are used for each block. This way, you
can add properties and other meta-data to each block. In this example, it's
easy to spot that the heading level information is a special property as well
as defined IDs for references. This is somewhat unusual for users of Org-mode.

By default, you always see the rendered version of the markup in Logseq. If
you put your cursor within a block, you then see its "source" markup you can
modify. 

If you don't need indentation and you just want to write just like within a
word processor or similar, you can toggle the "document mode" by clicking
outside of any block (removing the current block edit mode) and type t d. This
might be very interesting for many use-cases that don't need the full visual
clutter of Logseq. 

Todo keywords, SCHEDULED or DEADLINE works just like with Org-mode but on a
block-level, not heading-level. 

If you desperately need a hierarchy of pages, Logseq offers the concept of
"Namespaces". If you create a page like "foo" and then a page like "foo/bar",
the "bar" page is now a sub-page of "foo". 

As with many Zettelkasten solutions, you also have a "Graph view" which
visualizes your pages and their links. I'm not sure if I would use that often.
Be warned: this view is very CPU intense. I've left this view open in
background and my notebook battery was drained very fast. Therefore, use it
for jumping around but don't stay within that view. 

In Org-mode, you can have file-level meta-data such as file tags placed before
the first heading. In Logseq, you need to add such stuff like properties in
the so called "Frontmatter" which is the first block of a page. This way, you
can define file tags like #+tags: foo, bar or #+ALIAS: page1, page2 which
looks interesting. 

One of the best things of Logseq is the effort-less linking of pages or
blocks. You just type [[ followed by some search keywords. Within the search
                         results, you choose your desired target, confirm with Return and now you've
                         got a bi-directional link from the current position to the other page and vice
                         versa. Linking particular blocks can be done with ((. 

                                                                             There is much functionality available when using the / commands. This way, you
                                                                             can add datestamps, timestamps, scheduled or deadlines, and much more. Most
                                                                             plugin functionality are accessible from here. Similarly, the < advanced
                                                                             commands offers access to various blocks such as quotes, center, source code.
                                                                             The shortcut C-k is one of the most important ones for Logseq: you can jump to
                                                                             any page, create new pages and much more. You can easily notice that the
                                                                             programmers have a very big heart for people who prefer to use the keyboard in
                                                                             order to be efficient and quick. 

                                                                             Related to links, you need to know that 

                                                                             [[foo]]	  

                                                                             is a link to the page whose name is "foo". Alternatively, each page name is
                                                                             also a tag. So you can also reference the "foo" page by typing #foo. There is
                                                                             no difference between a tag and a link to a page except the visual
                                                                             representation of the link. If you would like to link to a page name that
                                                                             contains at least a space character, you'd need to type: 

                                                                             [[foo bar]] or #[[foo bar]]	  

                                                                             It is very important to know that each link in Logseq is automatically a
                                                                             bi-directional link. So if you link from "John Doe" to the block of an event,
                                                                             this event also has a back-link to "John Doe". With Org-mode, you need
                                                                             additional packages such as org-super-links in order to get that feature. To
                                                                             me, this is one of the most important properties of a knowledge-management
                                                                             system. I think that most people who want to try a Zettelkasten system
                                                                             actually need bi-directional links only. 

                                                                             Something that even Org-mode does not offer by default are so-called embeds.
                                                                             If you write: 

                                                                             {{{embed [[page name]]}}}	  

                                                                             ... you are not only referencing to "page name" but also embed its content to
                                                                             the current position. If you just want to embed a block, you can use the 

                                                                             {{{embed ((block name))}}}	  

                                                                             syntax instead. 

                                                                             And yes, three curly brackets this time, not two. (Consistency!) 

                                                                             Blocks can be collapsed and expanded just like with Org-mode. I did not find
                                                                             out a way to collapse and expand all blocks at a certain hierarchy level just
                                                                             like the TAB folding is working in Org-mode. 

                                                                             Logseq has a very capable query feature (and a builder) which offers many
                                                                             possibilities. You can use boolean operators to query for non-trivial stuff
                                                                             like: 

                                                                             {{query (and [[page1]] [[page2]] (not [[page3]] ) ) }}	  

                                                                             Two curly brackets? → consistency! 

                                                                             You can base queries on properties, todo keywords, date ranges, and much more.
                                                                             This seems to be very powerful and allows for great re-use of content or
                                                                             generating summaries of some sort. 

                                                                             Furthermore, Logseq has a flexible template concept. You can turn any
                                                                             sub-hierarchy of blocks into a template. I didn't find out how to query values
                                                                             from the user when she's applying a template. If you do have any idea on that,
                                                                             drop me a line. 

                                                                             Logseq Plugins

                                                                             Logseq comes with an easy to reach market place for plugins. You can choose
                                                                             from a large list of plugins. They offer great functionality. So far, I've
                                                                             installed following plugins: 

                                                                             * Logseq Dictionary
                                                                             * Todo list
                                                                             * Logseq Pen 

                                                                             * I'm not sure if this introduces any value to me.

                                                                             * Quick Capture
                                                                             * Date-Between
                                                                             * Preview Image
                                                                             * RSS Reader
                                                                             * PDF Extract
                                                                             * Emoji Picker
                                                                             * Agenda 

                                                                             * Somehow, I don't know if the agenda concept can be transferred from
                                                                             Org-mode to Logseq. I got the impression that Logseq users prefer/use the
                                                                             daily journal pages instead.

                                                                             * Link Preview 

                                                                             * Its popups can also be very annoying. I'm torn.

                                                                             * File Manager 

                                                                             * Just lists unlinked but "imported" attachment files. Can't delete them for
                                                                             some reasons. Tedious process.

                                                                             * Task Management Shortcuts
                                                                             * Logseq OCR 

                                                                             * Very cool plugin that applies OCR on any image that is in the clipboard
                                                                             and inserts the text into Logseq.

                                                                             * PDF Print 

                                                                             * Need to test it further. Certainly works for some use-cases but is far
                                                                             from as great as Org-mode exports.

                                                                             * PDF Navigation
                                                                             * URL HyperLink
                                                                             * Tabs
                                                                             * Bullet Threading 

                                                                             * IMHO a must-have.

                                                                             * TOC Generator
                                                                             * TODO Master 

                                                                             * This introduces progress bars just like the progress indicators in
                                                                             Org-mode: [3/10] or [33%]

                                                                             * Markdown Table Editor 

                                                                             * works only with Markdown, I guess

                                                                             * PDF Export Plugin did not produce good results
                                                                             * Typewriter Mode
                                                                             * Archive Webpage
                                                                             * Browser

                                                                             There are also themes that can be installed just like plugins. I tested the
                                                                             "Quattro Theme". 

                                                                             Calculator

                                                                             Logseq doesn't come with babel or tables using calc. 

                                                                             However, there is at least a Calculator which offers basic mathematics
                                                                             operations including assigning variables and such. 

                                                                             Links to Local Files

                                                                             One things I was not happy with is the use-case of linking to local files. 

                                                                             It seems to be the case that with actions like drag and drop of, e.g., a PDF
                                                                             file, this file always gets copied to the data directory of the current graph.
                                                                             Therefore, you double the disk space and if you modify that file, you only
                                                                             modify the "copy" that Logseq is using and not the original file. 

                                                                             Of course, you are able to link to local files without copying them.
                                                                             Unfortunately, you always need to know the full absolute path because there is
                                                                             no file-picker or similar. This is nothing I'd use that way. Especially when I
                                                                             do have the ultimate way of linking local files in Org-mode. 

                                                                             Missing Things of Logseq in Comparison to Emacs Org-Mode

                                                                             Just the most painful missing things from my perspective: 

                                                                             * Elisp, of course, and the universe of customizations Elisp makes possible

                                                                             * custom links

                                                                             * Appointments: somehow, everything the Agenda add-on shows needs to be a todo
                                                                             task (or I did not get it until now)

                                                                             * rectangle functions for editing: cut/insert/paste

                                                                             * search & replace with RegEx

                                                                             * keyboard macros

                                                                             * in Logseq, everything - by default - is something that is a heading in
                                                                             Org-mode syntax. Classic itemize lists, normal paragraphs, tables, … are a
                                                                             bit of a pain if possible at all.

                                                                             * Export formats other than MD, PDF, XML

                                                                             * most table-related features including calc formulas (spreadsheet)

                                                                             * sometimes, Org-mode syntax is not supported like Markdown is: e.g., Markdown
                                                                             table add-on

                                                                             * Although some Logseq items are clearly taken over from Org-mode to
                                                                             Logseq/Markdown: #+BEGIN_… blocks, …

                                                                             * Babel and its universe of possibilities

                                                                             * Sparse trees

                                                                             * Todo dependencies (using add-ons like org-edna)

                                                                             * dired for file management

                                                                             * Included binaries are copied to Logseq and can't be just linked

                                                                             * Logseq is more like encapsulated org-attachments only

                                                                             * most agenda features

                                                                             * org-crypt

                                                                             * auto-filled :LOOGBOOK: drawers: created time-stamps, todo status changes, …

                                                                             * consistency in heading levels and block level: a node on level 4 can be a
                                                                             heading of any level. Example:

                                                                             **** A node on level 4
                                                                             :PROPERTIES:
                                                                             :heading: 2
                                                                             :END:

                                                                             * Maybe, the Logseq approach allows for additional use-cases I can't think
                                                                             of right now. However, this comes with the downside that people might get
                                                                             irritated.

                                                                             * easy to use date-picker via keyboard: -thu +2w …

                                                                             * capture/templates can't ask values from the user

                                                                             From my personal setup: 

                                                                             * easy file name linking independent of its path 

                                                                             * Logseq can only link files (without "importing" by copying them into its
                                                                                                                   data storage) when you manually create a link like
                                                                             [[/home/user/dir/subdir/file.pdf][a title]] without any file selection
                                                                             dialog. That's very annoying. And then, you can't open the file by
                                                                             clicking onto it. At least I failed when doing that with a PDF.

                                                                             Nice Logseq Features That Are Missing in Emacs Org-Mode

                                                                             * Embeds (headings or blocks)
                                                                             * ^^highlighted^^
                                                                             * Built-in bi-directional links using #hashtagsyntax or
                                                                             [[double-bracket-syntax]] (both are the same!) 

                                                                             * org-super-links compensates that a bit. But it's not that easy to use.

                                                                             * Block references in terms of "each individual element" such as paragraphs
                                                                             and such. 

                                                                             * with some exceptions such as Names for Org-mode blocks.

                                                                             * Queries with dynamic results shown
                                                                             * Built-in presentation mode 

                                                                             * Logseq can generate beautiful reveal-like presentations for visible
                                                                             content right away!

                                                                             * Even non-tech-savvy people are able to install plugins and use them

                                                                             Related: https://logseqtemplates.com/ 

                                                                             Nice Logseq Features That Are Similar to Emacs Org-Mode

                                                                             * focus on a sub-hierarchy 

                                                                             * In Logseq you just need to click on the dot of its block in order to limit
                                                                             the view on the current sub-hierarchy of blocks.

                                                                             * fold/collapse of sub-hierarchies but not as versatile as the TAB behavior of
                                                                             Org-mode.
                                                                             * almost everything is (also) keyboard-driven
                                                                             * a bunch of flexible features that wait for the user to add them to his/her
                                                                             workflows to get a method 

                                                                             * tool is not imposing too much onto their users

                                                                             Orgdown Compatibility

                                                                             As with many tools, I took a closer look on how well Orgdown syntax is
                                                                             supported within Logseq. With Org-mode syntax being one of the two options for
                                                                             page content, its Orgdown support is fairly good. I got 86 percent of syntax
                                                                             support for OD1. 

                                                                             I found some issues with lists, code, horizontal bars, tables, and similar. 

                                                                             Re-using Orgdown Files

                                                                             Being curious, how Logseq reacts when I throw in a fairly large Orgdown files
                                                                             of mine which were created within my GNU Emacs Org-mode setup over the period
                                                                             of twelve years. I copied my current notes.org in the Logseq directory that
                                                                             holds the pages. 

                                                                             This is a file with 215523 lines holding 10640 Orgdown headings (1320 tasks
                                                                                                                                                   and 9320 non-task headings), many tags, internal and external links. 

                                                                             The good news is that Logseq did somehow process its content and it did not
                                                                             modify the file content while doing so. 

                                                                             The number of pages exploded: for each Orgdown tag used, Logseq created a page
                                                                             in its database but not in the file system. Those "tag pages" contain all the
                                                                             links to the headings that are tagged using those tags. 

                                                                             Well, that was somehow expected. 

                                                                             I could not find "notes" within the page search results. Unfortunately, this
                                                                             is a bad term to search for as it is contained many times within the file. 

                                                                             Many if not all notes.org headings are somehow associated with my "Emacs
  Survey 2022" heading. This is a rather small and "unimportant" heading in the
                                                                             fourth layer of headings within notes.org. For some reason, Logseq got
                                                                             confused and I can't get any view of my large files to narrow down. 

                                                                             Searching for a node like "Windows 11", shows me the corresponding target
                                                                             below "Emacs Survey 2022". When selected, I always see the same node: "Emacs
  Survey 2022". Furthermore, many task headings are listed in a table that are
                                                                             not part of that sub-hierarchy. Other content from totally different
                                                                             sub-hierarchies is shown here as well. 

                                                                             This way, I could not test internal ID-links, jumping around, navigating
                                                                             within a large page file and so forth. 

                                                                             This import test did not work to my satisfaction at all. 

                                                                             Tons of More Stuff to Explore

                                                                             You can dig in much deeper into Logseq with topics like advanced queries,
                                                                             Journal pages (I don't use), Flashcards, large number and freely changeable
                                                                             keyboard shortcuts, the whole universe of plugins, Zotero-integration
                                                                             (unfortunately cloud only!), iOS/Android app (Android app is not in Play Store
                                                                                                                                   yet), ... and so forth. 

                                                                             You can find many tutorial videos on YouTube and less on the WWW,
                                                                             unfortunately. 

                                                                             However, Logseq can't and will never be as flexible as the original: Org-mode.
                                                                             So there is zero chance that I would actually move my Orgdown data to Logseq.
                                                                             Not only because of the failed naïve import test using the large notes.org of
                                                                             mine. 

                                                                             Some great Logseq features, I wish I could use with Org-mode as well. 

                                                                             So if you do have a situation where GNU Emacs is no option for you (you should
                                                                                                                                                     have really good arguments for that!), Logseq is a very good approximation as
                                                                             long as you don't plan to import large Orgdown files that were generated with
                                                                             the original Org-mode. 

                                                                             My wife will start with Logseq. Let's hope that digital note-taking will be a
                                                                             valuable companion also for her. 

                                                                             If I did get something wrong, please do drop me a line so that I can fix this
                                                                             here. 

                                                                             Links

                                                                             * 2024-02-14: Daily Notes for 2024-02-13 | Mike Hall

