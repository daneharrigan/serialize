# Changelog

### 1.0.0

* XML support is disabled by default, but it can be enabled
* You have to require active_support and builder yourself for XML support
* yajl-ruby is used instead of the json gem
* [Bug Fix] `Serialize::Generator` no longer assumes an `id` method exists on an object

### 0.0.3

* added support for `id` methods getting serialized

### 0.0.2

* removed all instance methods from `Serialize::Generator`
