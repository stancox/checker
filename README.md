# Checker

A collection of modules for which every is designed to check syntax in files to be commited via git.

## Usage

### Git hook

To check your source code every time you commit, add to your .git/hooks/pre-commit line:

```
checker
```

Don\'t forget to make the hook file executable:

``` bash
chmod +x .git/hooks/pre-commit
```

Now checker will halt the commit if it finds problem with source code:

```
Checking app/models/user.rb...
FAIL app/models/user.rb found occurence of 'binding.pry'
46:binding.pry
```

### Advanced usage

To check only specific filetypes on commit, use `git config` :

``` bash
git config checker.check 'all'

git config checker.check 'ruby, haml, coffeescript'
```

Available options are: all, ruby, haml, pry, coffeescript, sass
