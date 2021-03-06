# My dotfiles for OSX #
by Sungjin Han <meinside@gmail.com>

----

## DESCRIPTION ##

My personal dotfiles for OSX, mostly for development.

----

## Other things ##

### Prep script ###

Run **bin/prep.sh** and it will clone files and install several things automatically.

```
$ cd ~
$ wget -O - "https://raw.github.com/meinside/osx-configs/master/bin/prep.sh" | bash
```

=> will install **Homebrew**, **RVM** and **Ruby**

### Paths ###

Reorder paths in **/etc/paths** for convenience:

``$ sudo vi /etc/paths``

=> put **/usr/local/bin** on the top for Homebrew

```
/usr/local/bin
/usr/bin
/bin
/usr/sbin
/sbin
```

----
