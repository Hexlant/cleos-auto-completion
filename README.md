# cleos-auto-completion

Because of the limit of CLI11(commandline parser for c++) used by cleos, currently cleos do not provide command auto-complete functionality.
With this project, you can use command auto-completion feature to your cleos. Also, you can use this for your custom cleos shell files with simple changes(which is described below).

For now, We only support BASH, but others will be supported soon.

## installation
Just clone this repo and copy script file to bash completion directory.
```
$ cd cleos-auto-completion
$ sudo cp cleos.bash /etc/bash_completions.d/
