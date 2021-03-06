Git - Pull Requests
================

## What is a pull request?

*Pull requests are a feature that makes it easier for developers to
collaborate. They provide a user-friendly web interface for discussing
proposed changes before integrating them into the official
project<sup>1</sup>*.

## Structure of a pull request

Pull requests are a way that allow for easy collaboration across users
for projects. The general workflow for pull requests is outline
below<sup>2</sup>:

> 1.  Fork the target repo to your own account.
> 2.  Clone the repo to your local machine.
> 3.  Check out a new “topic branch” and make changes.
> 4.  Push your topic branch to your fork.
> 5.  Use the diff viewer on GitHub to create a pull request via a
>     discussion.
> 6.  Make any requested changes.
> 7.  The pull request is then merged (usually into the master branch)
>     and the topic branch is deleted from the upstream (target) repo.

There are a few resources that are very good at outlining the process of
forking and creating branches, that I will just provide links to them in
the references rather than fully recreate their works<sup>3,4</sup>.

These cover the adding another remote for the ‘upstream’ master
repository and then using `git pull upstream master` to pull from the
original repo before submitting your changes to the forked version.

If you have then submitted the pull request and it has been accepted,
then you would expect to delete that particular branch when it has been
incorporated into the ‘master’.

If you have removed the branch from the forked version through the
website as Github often suggests, then you can `git fetch --prune` to
remove the references to the remote branch from your local setup. They
then won’t be there when you check via `git branch -va`<sup>5</sup>.

There are mentions of rebasing the branches when you are pulling from
the upstream versions. An explanation of that can be found in this
YouTube video by The Modern Coder<sup>6</sup>.

## References

1.  [Making a Pull Request -
    Atlassian](https://www.atlassian.com/git/tutorials/making-a-pull-request)
2.  [How to Collaborate On GitHub - Jonathan
    Cutrell](https://code.tutsplus.com/tutorials/how-to-collaborate-on-github--net-34267)
3.  [Using the Fork-and-Branch Git Workflow - Scott
    Lowe](https://blog.scottlowe.org/2015/01/27/using-fork-branch-git-workflow/)
4.  [Pull Request Workflow - Github User
    Chaser324](https://gist.github.com/Chaser324/ce0505fbed06b947d962)
5.  [StackOverflow
    Question](https://stackoverflow.com/questions/35941566/git-says-remote-ref-does-not-exist-when-i-delete-remote-branch)
6.  [A Better Git Workflow with Rebase - The Modern
    Coder](https://www.youtube.com/watch?v=f1wnYdLEpgI&list=WL&index=28&t=0s)
