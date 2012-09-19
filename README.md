# Checker [![Build Status](https://secure.travis-ci.org/netguru/checker.png?branch=master)](http://travis-ci.org/netguru/checker)

A collection of modules for which every is designed to check syntax in files to be commited via git.

## Usage

### Install
Checker is available in rubygems, so you just need to do:
```
gem install checker
```
If you are using bundler, you can add it to your project via `Gemfile` file (best to put it under `:development` group).
Since checker is a command-line utility, there is no need to load it up in the application:
```ruby
group :development do
  gem 'checker', :required => false
end
```

After installing the gem please follow [Git hook](#git-hook) section for further details.

### Git hook

#### prepare-commit-msg hook
If you want every commit be appended with checker approved icon (:checkered_flag:) add to your `.git/hooks/prepare-commit-msg` following:

``` bash
#!/bin/bash
checker

if [ $? == 1 ]; then
  exit 1
fi

echo ":checkered_flag:" >> $1
```

you can also prepend the flag to the first line of commit message, by changing last line with:

``` bash
text=`echo -n ':checkered_flag: '; cat $1`
echo $text > $1
```

#### pre-commit hook
To just check your source code every time you commit, add to your `.git/hooks/pre-commit` line:

``` bash
#!/bin/bash
checker
```

Use only either one hook.


Don't forget to make the hooks files executable:

``` bash
chmod +x .git/hooks/pre-commit
chmod +x .git/hooks/prepare-commit-msg
```

Now checker will halt the commit if it finds problem with source code. Couple examples:

#### pry
```
[ PRY - 1 files ]
  Checking app/models/user.rb... [FAIL]
46:binding.pry
```

#### conflict
```
[ CONFLICT - 1 files ]
  Checking a.bad.scss... [FAIL]
4:<<<<<<< Updated upstream
30:>>>>>>> Stashed changes
```

#### sass
```
[ SASS - 1 files ]
  Checking a.bad.scss... [FAIL]
Syntax error: Invalid CSS after "qwe:": expected pseudoclass or pseudoelement, was "asd:"
        on line 1 of .checker-cache/3cc74408b797b92e79207a64d97ae429
  Use --trace for backtrace.
```

### Advanced usage

To check only specific filetypes on commit, use `git config` :

``` bash
git config checker.check 'ruby, haml, coffeescript'
```

### Available options

#### ruby
Checks for correct syntax in ruby (.rb) files

#### haml
Checks for correct syntax in haml files

#### pry
Checks for any occurence of `binding.pry` or `binding.remote_pry`

#### coffeescript
Checks for correct syntax in coffeescript (.coffee) files

#### sass
Checks for correct syntax in sass and scss files

#### slim
Checks for correct syntax in slim files

#### conflict
Checks for any occurence of git conflicts when merging (looks for `<<<<<<< ` or `>>>>>>> `)

### Dependencies

For various modules to work you may need to install additional dependencies:

* coffeescript - `npm install -g coffee-script` - see https://github.com/jashkenas/coffee-script/
* javascript - install jsl binary - see http://www.javascriptlint.com/download.htm
* haml & sass & slim - `gem install haml sass slim`
