# Contributing

So you want to contribute to `leaf-grid`? Great! There are many things you can do to improve the project.

## Opening issues

Issues are the most simple and easy way to contribute, fell free to ask questions, report bugs or suggest new features.

 - **When reporting bugs** please specify the conditions of your system such as OS and browser version.
 - **When proposing features** please explain the feature purpose and how you it would be useful for users. Be prepared to discuss the feature implementation.

## Making code contributions

Pull requests are great if you want to contribute with code or documentation. To keeps things organized we have a few rules for PRs.

### Building the project

This project is mainly written in SASS with version managed by [bundler](http://bundler.io/) and we use `scss-lint` so make sure you have Ruby installed and `bundler` as well.

If you don't have bundler just run:

`gem install bundler`

Make sure you have both [node](https://nodejs.org/) and [npm](https://www.npmjs.com/) (it comes with node) installed.

We rely heavily on [grunt](http://gruntjs.com/) and [bower](http://bower.io/), please install them before proceeding if you don't already have it by running the following commands:

`npm install -g grunt-cli`

`npm install -g bower`

To build the project follow the steps on your terminal of choice:

 1. Clone the project and `cd` to the root folder.
 2. Run `npm install`
 3. Run `grunt build`

And there you go, you have a working version of `leaf-grid` in the `dist` folder and the full documentation in the `docs` folder.

### Writing code

We write CSS through [SCSS](http://sass-lang.com/guide) so please edit only the code inside the `src` folder.

We have two simple rules when writing SCSS:

  1. Follow CSS part of [MDO's Code Guide](http://codeguide.co/).
  2. Follow [hyphenated BEM syntax](http://csswizardry.com/2013/01/mindbemding-getting-your-head-round-bem-syntax/).

That's it for code style.

You may see tests written in CoffeeScript inside the `test` folder.

 We use the style stated on the strict version of [Idiomatic CoffeeScript](https://github.com/mkautzmann/Idiomatic-CoffeeScript/tree/strict).

Also make sure your editor supports [editorconfig](http://editorconfig.org/) and respects the rules in the `.editorconfig` file.

#### Testing the code

We try to test common scenarios through code so that in the future we won't break something already working, that's not always the case but automated tests certainly help.

The `grunt test` command will generate the test bundle code and you can use your browser on the `index.html` file to check if everything is OK.

#### Why not PhantomJS?

Currently we use PhantomJS prior to 2.0 internally which doesn't support flexbox so no point in adding it for now.

We are working in a way to support 2.0+ in the future.

### Submitting the PR

After checking if the code is according to the style used in the project and passes the local tests you may submit your PR.

Submit PRs **only** to the master branch.

## Documentation

There are some simple docs that can be generated with `grunt docs` and are located in the `docs` folder.

## Tips when developing

We have a bunch of tips and shortcuts you can use when developing and debugging `leaf-grid`. The first thing you need to know is that we use [grunt](http://gruntjs.com/) tasks a lot.

Here are one list of useful tasks you can use while playing with the project:

  - `grunt build` will build the whole project and output to `dist`.
  - `grunt test` will lint and generate the test code inside `test` folder.
  - `grunt demo` will spin up a demo server and open your default browser that automatically reloads on changes to the HTML and SCSS.
  - `grunt clean` will take the project back to the state it was on cloning.
  - `grunt watch`, will keep building the project while you change the code.
  - `grunt --help` will display all the tasks available.

**Use the demo folder for manual testing**. The demo folder is great for manual testing, use it along side your browser inspector and debug SCSS code directly. That's the magic of [source maps](http://www.html5rocks.com/en/tutorials/developertools/sourcemaps/).

## Finally

Have fun, don't take it all too seriously. When in doubt, please use the [issues](https://github.com/leafui/leaf-grid/issues) feature.
