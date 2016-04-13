The `lovelace` overlay is the personal overlay of [Jonathan
Lovelace](http://www.google.com/profiles/kingjon3377).

Many, if not most, of the packages here are ones I had installed in a Debian or
Ubuntu chroot (when I still had the disk space to spare to maintain one)
because they looked interesting; when I removed those chroots, I found ebuilds
for what packages I could (in [Gentoo Bugzilla](https://bugs.gentoo.org), in
others' overlays, and in a couple of cases distributed by the upstream
developers), and created ebuilds for those that I couldn't find elsewhere yet
weren't too tricky.

A few of the ebuilds are taken from [the Gentoo
Attic](http://sources.gentoo.org/cgi-bin/viewvc.cgi/gentoo-x86/), having been
removed from the main tree; the Qt 3 and KDE 3 packages I copied from [the
kde-sunset
overlay](http://git.overlays.gentoo.org/gitweb/?p=proj/kde-sunset.git) because
some packages in my overlays needed them, but I didn't want *all* its packages
cluttering up the dependency graph. (And at the time either Repoman---the
Portage repository QA checker, whose warnings I try to keep to a minimum---had
no way of telling it about dependencies found anywhere other than the main tree
and the current overlay, or I was unaware of that mechanism.)
