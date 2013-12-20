Paragon
=======

Easy UI prototyping &amp; testing powered by Middleman static generator

Development server and static site generator with isolated styles, mock data and JavaScript.

It's great for quick interaction prototyping, generating styleguides and UI regression testing.

Check `source/prototypes` for example of a prototype and `source/exemplar` for an example which can be set up for UI testing.


Frameworks
==========

Paragon is built on top of [Middleman](https://github.com/middleman/middleman). Bundled with [Slim Templates](https://github.com/slim-template/slim), [Bourbon](https://github.com/thoughtbot/bourbon), [Neat](https://github.com/thoughtbot/neat) by default. Those can be extended or replaced with little effort.


Optionally included: Foundation 5 and AngularJS via ([Bower](https://github.com/bower/bower)).


Usage
=====

The best way to use Paragon is to install it as a Middleman template:
```
git clone --depth=1 git@github.com:tyom/paragon.git ~/.middleman/paragon && rm -rf ~/.middleman/paragon/.git
```

Then initialise a project with `middleman init <project-name> -T paragon`. This create all files, run bundle and leave the git repo out so a fresh repo can be created.

### Inside new project

```
bower install
````

Install client-side libraries: AngularJS and Foundation (add your own).

```
middleman
```

Run local server.

```
middleman build
```

Build static website.
