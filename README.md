Configuration files
===================

Copyright (c) 2021– S. Zeid.  
<https://code.s.zeid.me/etc>


This repository contains some of my configuration files, a makefile to install
symlinks to them, and first-time setup scripts.

Unless otherwise noted, all of these files are mine and are released under the
X11 License.  See `LICENSE.md` for details.


Makefile usage
--------------

To install these configuration files:

1.  Install GNU make if you haven't already.
2.  Change directories to the repository root.
3.  Run `make install`.
    
    To see what would be done without actually making the symlinks, run
    `make dry-run` or `make dry`.
    
    To see all symlinks that would be added to an empty home directory, run
    `make list` or `make ls`.

The destination filenames will be transformed as follows:

* `{root-dir}/{filename}` -> `$HOME/.{filename}`
* `{root-dir}/_config/{filename}` -> `$HOME/.config/{filename}`

If this repository is somewhere within the home directory, then relative paths
will be used for `{root-dir}` in the symlinks; otherwise, absolute paths will
be used.

If a destination file already exists, and it does not already point to a file
or directory in this repository, then it will be backed up to a name of the
form `{filename}.%Y-%m-%dT%H-%M-%S_%NZ.bak`.

The following files and directories will be excluded from installation:

* `GNUmakefile`
* `*.md`
* `*.txt`
* `.*` (hidden files or directories)
* `_*` (special files or directories; see above for `_config`)
* `+*` (role directories; see "Conditional configuration" below)

as well as these backup/cache files:

* `*.swp`
* `*~`


Conditional configuration
-------------------------

Conditional configuration is supported by creating _role_ directories with
names starting with `+`.  The file `_if` in each role directory will be
executed (if it is executable, or interpreted with `sh` otherwise), and if it
exits successfully, then the files in that role directory will be processed as
if they were in the repository root, after the files in the root directory.

If the `_if` file is missing or not a regular file (or a symlink to one), then
the role will unconditionally be installed.

The following environment variables are available to `_if`:

* `ETC_ROLE_DIR` - the path to the role directory, relative to the repository
                   root
* `ETC_ROLE_NAME` - the basename of the role directory without the leading `+`

Role directories may be nested, but not within non-role subdirectories.

If multiple roles contain the same file, then the last matching role will be
used.  Matching role directories, relative to the repository root, will be
sorted with `sort`, which will result in the deepest matching sub-role, if any,
being matched.

To get a list of all matching role directories, one per line and relative to
the repository root, run `make find-role-dirs` from the repository root.  This
target takes two optional variables:

* `absolute=1` - print absolute paths instead of relative paths
* `suffix=SUFFIX` - add `SUFFIX` to the end of each path
