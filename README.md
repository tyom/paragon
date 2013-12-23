Paragon
=======

Easy UI prototyping &amp; testing powered by Middleman static generator

Development server and static site generator with isolated styles, mock data and JavaScript.

It's great for quick interaction prototyping, generating styleguides and UI regression testing.

Check `source/prototypes` for example of a prototype and `source/exemplar` for an example which can be set up for UI testing.


Tech
----

Paragon is built on top of [Middleman](https://github.com/middleman/middleman). Bundled with [Slim Templates](https://github.com/slim-template/slim), [Bourbon](https://github.com/thoughtbot/bourbon), [Neat](https://github.com/thoughtbot/neat) by default. Those can be extended or replaced with little effort. Deploy with [Middleman Deploy](https://github.com/tvaughan/middleman-deploy).


Optionally included: Foundation 5 and AngularJS via ([Bower](https://github.com/bower/bower)).


Usage
-----

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


Exemplars
---------

Add new exemplars (UI components) in /exemplars directory. [See examples](https://github.com/tyom/paragon/tree/master/source/exemplars).

Exemplar pages have their meta data defined in Frontmatter. It also has several ways to inject custom JavaScript or CSS along:

```
---
javascripts:
  - exemplars/example/custom-js
stylesheets:
  - exemplars/example/custom-css
---
```

This will include those additionally files. CoffeeScript & Sass are compiled on the fly. Sass files can include any other Sass/CSS files that are in the `load_paths`.

It's also possible to use Slim filters, for example, to inline Sass, JS or any other [supported templates](http://rdoc.info/gems/slim/file/README.md#Embedded_engines__Markdown______).

Exemplars are included on page by using a special helper, see example (Slim):

**Include external file**
```slim
= exemplar_for 'form/input', title: 'Text input'
```

**Include inline in a block***
```slim
= exemplar \
  title: 'Radio buttons' do
  erb:
    <p>
      <input type="radio" name="vote" id="agree">
      <label for="agree">Agree</label>
    </p>
    <p>
      <input type="radio" name="vote" id="disagree">
      <label for="disagree">Disagree</label>
    </p>
```

Exemplars also come with a way to configure modifier classes on components.

```slim
= exemplar title: 'Default button' do
  button(class="btn" modifiers="[larger:__larger, large:__large, medium:__medium, small:__small]") Submit
```

In ERB it looks like this:

```erb
<%= exemplar title: 'Default button' do %>
  <button class="btn" modifiers="[larger:__larger, large:__large, medium:__medium, small:__small]">Submit</button>
<% end %>
```
In this example the `<button>` element has modifiers classes: `__larger`, `__large`, `__medium` and `__small`. By specifying them in the attribute `modifiers` they will be automaticall parsed and the menu will be attached to the component's exemplar, allowing to toggle those classes.

The `modifiers` attributes has a simple syntax which allows to group some of the items together, untoggling other items in group as new items are selected. Normal (ungrouped) behaviour allows toggling multiple buttons.

```erb
<button class="btn" modifiers="dark:__dark, [larger:__larger, large:__large, medium:__medium, small:__small]">Submit</button>
```

This will create one group of buttons which controls the size and another button that controls its colour.

There is a `name:value` syntax. For example, `special version of a component:special` will have the text label on the button and toggle `special` class name.

See [more examples](http://tyom.github.io/paragon/exemplars/).
