Why does this directory exist?

Well, first off, let me say I don't really understand Go. So this might be totally wrong.

That said:

* I already have toml-test in my "system-wide" GOPATH and I want the one I use in this project to be independent from that
* But it only ran if its dependencies happened to be in GOPATH, which meant the system state outside this repo could affect whether or not this test suite works. That's not controlled or reproducible, which is bad.
* It also turns out that toml-test looks in GOPATH for the test files by default, which makes it easier to add and change tests if it's in GOPATH like it expects to be (the expecation seems reasonable)

This seemed to indicate that I need to be installing things into a GOPATH 'properly' to make them work reliably, and that GOPATH needed to be different to the system-wide one to contain independent versions.

So why check it in rather than script it? Because I'm using submodules to track revisions / branches of everything else and wanted to do the same here. So the items I care about in the gopath are checked out to particular revisions - for example toml-test itself actually points to my git repo and my custom version of the tool. (Additional complexity if this isn't checked in: the git remote is github.com/zofrex, but the script itself is hardcoded to look in src/github.com/BurntSushi for tests)

I hope that makes sense. If it doesn't please tell me how to do this because I honestly don't have a clue.
