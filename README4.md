# basex.vim
Syntastica file checker for XQuery, utilizing [BaseX][1].

### About Syntastica
[Syntastica][0] is a generic syntax file validation tool for use with vim. For more details check our their page.

### About BaseX.vim
The BaseX.vim syntax checker leverages [BaseX][1] for valildatng XQuery modules and scripts in ``vim``. 

#### Screenshot
<img src="https://raw.githubusercontent.com/james-jw/basex.vim/master/syntastica-xquery.png" />

#### Installation
This checker is already bunded with [Syntastica][0] so all that is necessary:

* Install [syntastica][0]
* Install [BaseX][1]
* Add BaseX to your path. For example:
```bash
 export PATH=$PATH:~/basex/bin/
```

Done!

By default Syntastica will validate your modules on ``open`` and ``write``. See the help pages regarding [syntastica][0] for configuring this behavior!

#### Shout Out!
If you like what you see here please star the repo and or follow me on github or linkedIn

Happy querying!

[0]: https://github.com/scrooloose/syntastic
[1]: http://www.basex.org
