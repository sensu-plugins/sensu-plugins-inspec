## Sensu-Plugins-inspec

[ ![Build Status](https://travis-ci.org/sensu-plugins/sensu-plugins-inspec.svg?branch=master)](https://travis-ci.org/sensu-plugins/sensu-plugins-inspec)
[ ![Gem Version](https://badge.fury.io/rb/sensu-plugins-inspec.svg)](http://badge.fury.io/rb/sensu-plugins-inspec)

## Functionality

This check executes [InSpec][1] profiles and generates a Sensu event for each non-passing control.

## Files
 * bin/check-inspec.rb

## Usage
```
check-inspec.rb (options)
    -l, --handler HANDLER
    -t, --spec-tests spec/test
    -d, --tests-dir /tmp/dir

```


## Examples
Run a local profile and set Sensu event handler to example_handler:

`check-inspec -d /tmp/my_inspec_profile -l example_handler`

Run a remote profile and set Sensu event handler to example_handker:

`check-inspec -d https://my-inspec-profile.s3.amazonaws.com/example-profile.tar.gz -l example_handler`


## Installation

[Installation and Setup](http://sensu-plugins.io/docs/installation_instructions.html)

## Notes


[1]: https://inspec.io
