## Sensu-Plugins-inspec

[ ![Build Status](https://travis-ci.org/sensu-plugins/sensu-plugins-inspec.svg?branch=master)](https://travis-ci.org/sensu-plugins/sensu-plugins-inspec)
[ ![Gem Version](https://badge.fury.io/rb/sensu-plugins-inspec.svg)](http://badge.fury.io/rb/sensu-plugins-inspec)

## Functionality

This check executes [InSpec][1] profiles and generates a Sensu event for each non-passing control.

## Files
 * bin/check-inspec.rb

## Usage

Run a local profile:

`check-inspec -d /tmp/my_inspec_profile`

Run a remote profile:

`check-inspec -d https://my-inspec-profile.s3.amazonaws.com/example-profile.tar.gz`


## Installation

[Installation and Setup](http://sensu-plugins.io/docs/installation_instructions.html)

## Notes


[1]: https://inspec.io