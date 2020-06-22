## Sensu-Plugins-inspec
[![Sensu Bonsai Asset](https://img.shields.io/badge/Bonsai-Download%20Me-brightgreen.svg?colorB=89C967&logo=sensu)](https://bonsai.sensu.io/assets/sensu-plugins/sensu-plugins-disk-checks)
[ ![Build Status](https://travis-ci.org/sensu-plugins/sensu-plugins-inspec.svg?branch=master)](https://travis-ci.org/sensu-plugins/sensu-plugins-inspec)
[ ![Gem Version](https://badge.fury.io/rb/sensu-plugins-inspec.svg)](http://badge.fury.io/rb/sensu-plugins-inspec)

## Sensu Inspec Check Plugin
- [Overview](#overview)
- [Usage examples](#usage-examples)
- [Configuration](#configuration)
  - [Sensu Go](#sensu-go)
    - [Asset definition](#asset-definition)
    - [Check definition](#check-definition)
  - [Sensu Core](#sensu-core)
    - [Check definition](#check-definition)
- [Functionality](#functionality)
- [Additional information](#additional-information)
- [Installation from source and contributing](#installation-from-source-and-contributing)



### Overview

This check executes [InSpec][1] profiles and generates a Sensu event for each non-passing control.

#### Files
 * bin/check-inspec.rb

### Usage

#### Help

**check-inspec.rb**

```
Usage: check-inspec.rb (options)
    -l, --handler HANDLER
    -d, --tests-dir /tmp/dir

```


#### Examples
Run a local profile and set Sensu event handler to example_handler:

`check-inspec.rb -d /tmp/my_inspec_profile -l example_handler`

Run a remote profile and set Sensu event handler to example_handler:

`check-inspec.rb -d https://my-inspec-profile.s3.amazonaws.com/example-profile.tar.gz -l example_handler`

### Configuration
#### Sensu Go
##### Asset Registration
Assets are the best way to make use of this plugin. If you're not using an asset, please consider doing so! If you're using sensuctl 5.13 or later, you can use the following command to add the asset:

`sensuctl asset add sensu-plugins/sensu-plugins-inspec`

If you're using an earlier version of sensuctl, you can download the asset definition from [this project's Bonsai Asset Index page](https://bonsai.sensu.io/assets/sensu-plugins/sensu-plugins-disk-checks).

##### Check definition example
```yaml
---
type: CheckConfig
spec:
  command: "check-inspec.rb -d /tmp/my_inspec_profile -l example_handler"
  handlers: []
  high_flap_threshold: 0
  interval: 10
  low_flap_threshold: 0
  publish: true
  runtime_assets:
  - sensu-plugins/sensu-plugins-disk-checks
  - sensu/sensu-ruby-runtime
  subscriptions:
  - linux
```

#### Sensu Core
##### Check definition
```json
{
  "checks": {
    "check-inspec": {
      "command": "check-inspec.rb -d /tmp/my_inspec_profile -l example_handler",
      "subscribers": ["linux"],
      "interval": 10,
      "refresh": 10
    }
  }
}

```

### Functionality
**check-inspec**

Run inspec controls and generate a new Sensu event for each failed inspect test.
This check will return critical if any inspec tests fail.

The `-l` option sets the handler to use in the generated Sensu events. Defaults to the `default` handler.
The `-d` option sets the directory containing tests to run.


[1]: https://inspec.io
