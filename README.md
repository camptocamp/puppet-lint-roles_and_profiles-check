# puppet-lint roles and profiles check

Adds a new puppet-lint plugin to verify that your code matches Roles & Profiles
paradigm.
This plugin assumes that your role classes starts with ̀`roles`and your
profiles classes starts with `profiles`.

## Installation

To use this plugin, add the following line to the Gemfile in your Puppet code
base and run `bundle install`.

```ruby
gem 'puppet-lint-roles_and_profiles-check'
```

## Usage

This plugin provides new checks to `puppet-lint`.

### node_definition

**--fix support: No**

This check will raise a warning if your node definition does not contain only a role declaration.

```
WARNING: expected only one role declaration
```

### roles_class_params

**--fix support: No**

This check will raise a warning for any parameter in your role definition.

```
WARNING: expected no class parameters
```

### roles_resource_declaration

**--fix-support: No**

This check will raise a warning for any resource declaration in you role defintion that is not a profile class.

```
WARNING: expected no resource declaration
```
