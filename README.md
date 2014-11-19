# Puppet-checkmk

[![Build Status](https://travis-ci.org/sbadia/puppet-checkmk.png?branch=master)](https://travis-ci.org/sbadia/puppet-checkmk)
[![Puppet Forge](http://img.shields.io/puppetforge/v/sbadia/checkmk.svg)](https://forge.puppetlabs.com/sbadia/checkmk)
[![License](http://img.shields.io/:license-gpl3-blue.svg)](http://www.gnu.org/licenses/gpl-3.0.html)

## Overview

Puppet [checkmk](http://mathias-kettner.com/check_mk.html) module.

This module is completely inspired by the work of [Mehdi Abaakouk (sileht)](https://github.com/sileht) for [Tetaneutral.net](http://tetaneutral.net/), please see [the original work](https://chiliproject.tetaneutral.net/projects/git-tetaneutral-net/repository/puppet-checkmk).

## Usage

### Using default values

```puppet
include 'checkmk'
```

### Overide values

```puppet
class { 'checkmk': }
```

## Other class parameters

# Contributors

* https://github.com/sbadia/puppet-checkmk/graphs/contributors

# Beaker-Rspec

This module has beaker-rspec tests

To run:

```shell
bundle install
bundle exec rspec spec/acceptance
# or use BEAKER_destroy=no to keep the resulting vm
BEAKER_destroy=no bundle exec rspec spec/acceptance
```

# Release Notes

See [CHANGELOG](https://github.com/sbadia/puppet-checkmk/blob/master/CHANGELOG.md) file.

## Development

[Feel free to contribute](https://github.com/sbadia/puppet-checkmk/). I'm not a big fan of centralized services like GitHub but I used it to permit easy pull-requests, so show me that's a good idea!
