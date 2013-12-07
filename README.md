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

The best way to use Paragon is to `git clone git@github.com:tyom/paragon.git ~/.middleman`. This will add itself to available Middleman’s templates. Then initialise a project with `middleman init <project-name> -T paragon`. This create all files, run bundle and leave the git repo out so a fresh repo can be created. Run `bower install` to get client libraries: AngularJS and Foundation, or add your own.