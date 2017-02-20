# PermCheck

Our shared software directories are required to adhere to a specific pattern
of permissions and group ownership.  They should, under normal conditions,
have group ownership of "sec-bioinf-softwareadmins", and have permissions
set group-writeable but read-only to user and world.  The intent is that
the directories will be protected from accidental change, requiring a deliberate
change to group sec-bioinf-softwareadmins before adding/changing these paths.

This package is slightly more general, allowing the user to specify a umask
and group on the command line, as well as a list of email addresses to send
notifications to if there are incorrect permissions, and a list of paths
to check.

The package will then traverse those directories, checking file permissions
and group ownership.  If incorrect permissions are found, the package will
send a notification to the supplied addresses.  If no email addresses are
supplied, the notification(s) will be written to standard output.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'permCheck'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install permCheck

## Usage

Run the package as

```
permCheck [options] path ...
```

where the options are:

* `-u/--umask` -- permission bits which must *not* be set, as 9 characters: `rwxrwxrwx`, where the bits which must not be set are those letters, and others are dashes, e.g. `----w--w-` indicates that the relevant files must not be group- or world-writeable.
* `-s/--smask` -- permission bits which *must* be set, with syntax as above.
* `-g/--group` -- group that files must be owned by.
* `-m/--mailto` -- comma-separated list of email addresses to send results to; if omitted, results are written to stdout.
* `-v/--version` -- displays version of the program and exits.
* `-h/--help` -- displays program usage.

and the path(s) is(are) the paths to check for violations.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake test` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports are welcome on GitHub at
https://github.com/crukci-bioinformatics/permCheck.


## License

The gem is available as open source under the terms of the
[MIT License](http://opensource.org/licenses/MIT).
