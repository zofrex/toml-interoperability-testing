# TOML Interoperability

This is a project to test all major TOML implementations to find (and ideally fix) differences in implementations, in order to better guarantee interoperability between different implementations.

## Motivation

If TOML is to be a major markup language (of the likes of JSON and YAML), then all implementations need to agree on what precisely the specification is, otherwise a TOML file used from one language may not work in another. An example:

Rust's package manager, Cargo, uses TOML for describing packages and their dependencies. The TOML library Cargo uses was overly permissive in the TOML it considered valid, for example it was happy with:

```toml
[[test]] name = "format"
```

Being too permissive rather than too restrictive may not seem like a big problem, but it was. The build tool used to build Cargo is Cargo itself, and one way of bootstrapping Cargo on a platform that has never had Cargo before is to use a Python script that mimicks enough of Cargo to make a first build. This Python script did not use the (written-in-rust) TOML library that the real Cargo did, but a different library written in Python, and that library adhered to the spec more strictly. The result: it rejected the invalid package description, and failed to build Cargo.

After finding this problem I went looking for more and started finding bugs in other TOML implementations too. Trying to keep on top of testing all the implementations with all the tests, while adding new tests, motivated this project: automating the testing!

## Getting started

You will need:

* OS X (sorry)
* homebrew
* Ruby
* Go
* XCode (or at least the "gcc" (Clang) part
* Note that a bunch of other dependencies will be installed for you (using homebrew) if you run the Makefiles:
	* mono
	* GCC 6 (highly recommend setting up XCode CLT to avoid compiling this)
	* cmake
	* cunit
	* ragel
	* icu4c

After checking out the project, run:

```
git submodule update --init --recursive
```

Now you're all set. In the root:

```
make
```

And everything should be downloaded and compiled for you.

To run the tests:

```
cd harness
ruby test.rb
```
