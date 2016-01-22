# <a href="#" id="top"></a>leaf-grid

[![Build]](https://circleci.com/gh/leafui/leaf-grid/tree/master) [![SemVer]](http://semver.org/)
[![License]](LICENSE)

[![Tests](https://saucelabs.com/browser-matrix/leafui.svg)](https://saucelabs.com/u/leafui)

Part of the core of the Leaf UI.

Pure CSS 12-column, responsive mobile-first grid.

It leverages the [flexbox](https://drafts.csswg.org/css-flexbox-1/#flex) spec to generate a lightweight and portable grid that can be used in any web project.

## <a href="#" id="install"></a>Install

We recommend using [Bower](http://bower.io/) to manage front-end dependencies:

`bower install leaf-grid`

If you don't use bower you can manually use it by just grabbing the file inside the `dist` folder.

Also available on [NPM](http://npmjs.com):

`npm install leaf-grid`

## <a href="#" id="impl"></a>Details on implementation

### Leaf philosophy

As with other Leaf core components this one is written in SCSS and uses [hyphenated BEM](http://csswizardry.com/2013/01/mindbemding-getting-your-head-round-bem-syntax/) syntax. Please check the [CONTRIBUTING](CONTRIBUTING.md) guide for info on code style.

**Disclaimer:** `leaf-grid` is a grid based on flexbox so the browser must support that. Check the [browser support section](#browsersupport) for details.

We kept the grid very simple with no fancy features you may find elsewhere. You have twelve columns to use and no gutters.

#### Gutters!

Since version `0.2.0` gutters are now part of `leaf-grid`! Beware that `lf-grid__box` is now deprecated.

## <a href="#" id="usage"></a>Usage

### The simple grid

First let's see how it's like to create a simple 50/50 grid:

```html
<div class="lf-grid">
  <div class="lf-grid__col--6-12">
    <p>First half</p>
  </div>
  <div class="lf-grid__col--6-12">
    <p>Second half</p>
  </div>
</div>
```

OK, so let's explain that:

Every grid must be declared with class `.lf-grid`. By doing so, you are turning your div into a `leaf-grid`!

Inside your grid you can put `columns`. They are responsible for organizing things inside the grid. Each column occupies an amount of space in the grid.

As you can see in the above example, column shards go by `.lf-grid__col`. The `--` represent a modifier in BEM so that is saying that you want **6** from the **12** columns available. In other words, 50% of the total grid space.

To ask for a space in the grid you use the pattern `.lf-grid__col` + `--` and your modifier.

### The unbalanced grid

The next example uses all the knowledge from before to create an unbalanced grid:

```html
<div class="lf-grid">
  <!-- Asking for 75% of grid space 8/12 -->
  <div class="lf-grid__col--8-12">
    <p>75%</p>
  </div>
   <!-- Asking for 25% of grid space 4/12 -->
  <div class="lf-grid__col--4-12">
    <p>25%</p>
  </div>
  <!-- Asking for 100% of grid space 12/12 -->
  <div class="lf-grid__col--12-12">
    <p>100%</p>
  </div>
</div>
```

OK, so now the grid will inline the first two columns, but then it has no more space left. So it will create a new line to render the rest of the grid.


### Automatic fitting

Sometimes you don't want to calculate the numbers manually when distributing your columns.

In these cases you can use the special modifier `.lf-grid__col--fit`.

Then you can tell `leaf-grid` to automatically fit your content in the remaining column space available. Be aware that the minimum space you have is still 1-12.

```html
<div class="lf-grid">
  <!-- Asking for 25% of grid space 4/12 -->
  <div class="lf-grid__col--4-12">
    <p>25%</p>
  </div>
   <!-- Give all the space you have left to fit -->
  <div class="lf-grid__col--fit">
    <p>75%</p>
  </div>
</div>
```

### Responsive Grid

`leaf-grid` is even more useful when you design your pages mobile-first, design pages to look good on the smaller viewport you plan to support and then just enhance from there.

The default column modifiers you saw so far work on mobile and beyond, but what about changing the UI behavior in a bigger screen?

There are special modifiers that can be used to target specific viewport ranges.

We have 5 pre-defined breakpoints:

  1. The default `.lf-grid__col--*`, where * is the column space modifier as you already know. This applies to any screen size.
  2. `.lf-grid__col--sm-*` is the small breakpoint for large smartphones and small tablets screens.
  2. `lf-grid__col--md-*` is the medium breakpoint for tablets.
  3. `lf-grid__col--lg-*` is the large breakpoint for landscape tablets and desktops.
  4. `lf-grid__col--xl-*` is the extra large breakpoint for wide desktops and TVs.

Knowing that you can mix and match those special modifiers to create a responsive experience.

```html
<div class="lf-grid">
  <div class="lf-grid__col--12-12 lf-grid__col--md-6-12 lf-grid__col--lg-3-12">
    <p>Home</p>
  </div>
   <!-- Give all the space you have left to fit -->
  <div class="lf-grid__col--12-12 lf-grid__col--md-6-12 lf-grid__col--lg-3-12">
    <p>Info</p>
  </div>
  <div class="lf-grid__col--12-12 lf-grid__col--md-6-12 lf-grid__col--lg-3-12">
    <p>Contact</p>
  </div>
  <div class="lf-grid__col--12-12 lf-grid__col--md-6-12 lf-grid__col--lg-3-12">
    <p>About</p>
  </div>
</div>
```

Notice that as the grid is mobile first the larger the breakpoint you set will apply for all the screen sizes above that breakpoint.

That's why when you don't set any special modifier the column space will be equal across any size.

### Vertical grid

One of the cool things about flexbox grids is that they don't care about flow direction.

You can just turn any grid into a vertical grid using the special grid modifier `.lf-grid--vertical`.

Look:

```html
<!-- Asking for vertical grid -->
<div class="lf-grid lf-grid--vertical">
  <!-- Asking for 25% of vertical grid space 4/12 -->
  <div class="lf-grid__col--4-12">
    <p>25%</p>
  </div>
   <!-- Give all the space you have left to fit -->
  <div class="lf-grid__col--fit">
    <p>75%</p>
  </div>
</div>
```

### Other special modifiers for the grid

Besides creating vertical grid there are more things you can do to make the grid just like you want.

#### Center

You can, for example, set the grid start at the center. So that any column is filled from the inside.

```html
<div class="lf-grid lf-grid--center">
  <div class="lf-grid__col--2-12">
    <p>I'm on the horizontal center of the grid!</p>
  </div>
</div>
```

#### Cross-center

But, what if you want to center things vertically? No problem, there's another special modifier for that. It's called `.lf-grid--cross-center`. In fact it's called **cross-center** because it will always center views in the opposite direction of the grid.

If the grid is horizontal it will center vertically and if the grid is vertical it will center horizontally.

```html
<div class="lf-grid lf-grid--cross-center">
  <div class="lf-grid__col--2-12">
    <p>I'm on the vertical center of the grid!</p>
  </div>
</div>
```

#### Reverse

If you want your grid to start from the right instead of starting from the left you can use `.lf-grid--reverse`.

```html
<div class="lf-grid lf-grid--reverse">
  <div class="lf-grid__col--6-12">
    <p>I'm on right</p>
  </div>
  <div class="lf-grid__col--6-12">
    <p>I'm on left</p>
  </div>
</div>
```

#### Stretch

Sometimes you'll want the grid columns to expand to fill the space remaining in the parent element.

Use the `.lf-grid--stretch` modifier and your grid will expand vertically if it is a horizontal grid and horizontally if it is a vertical grid.

```html
<div class="lf-grid lf-grid--stretch">
  <div class="lf-grid__col--6-12">
    <p>100% of parent height on this DIV</p>
  </div>
  <div class="lf-grid__col--6-12">s
    <p>100% of parent height on this DIV</p>
  </div>
</div>
```

### The special column modifiers

There are some column modifiers you can use to change behavior of one specific part of the grid.

#### Column centering

Say you want to center just one part of the grid, you can do that with the `.lf-grid__col--center` modifier. This way you can have the effect of `.lf-grid--cross-center` in just one column.

Let's take a look:

```html
<div class="lf-grid lf-grid--stretch">
  <div class="lf-grid__col--4-12">
    <p>I'm on TOP</p>
  </div>
  <div class="lf-grid__col--4-12 lf-grid__col--center">
    <p>I'm on CENTER!</p>
  </div>
  <div class="lf-grid__col--4-12">
    <p>I'm on TOP</p>
  </div>
</div>
```

#### Column at the end

Much like centering you can specify a column to start at the end them act like a stack. Piling up elements from bottom to top.

```html
<div class="lf-grid lf-grid--stretch">
  <div class="lf-grid__col--4-12">
    <p>I'm on TOP</p>
  </div>
  <div class="lf-grid__col--4-12 lf-grid__col--end">
    <p>I'm on BOTTOM!</p>
  </div>
  <div class="lf-grid__col--4-12">
    <p>I'm on TOP</p>
  </div>
</div>
```

### RTL compatibility

There are a bunch of [scripts](http://www.i18nguy.com/temp/rtl.html) that are meant to be read from right to left. So any universal grid should consider the compatibility with RTL.

Fortunately, in this grid you don't have to do anything to support RTL. The grid will automatically shift when viewed in RTL.

Try this:

```html
<!-- Forcing RTL with `direction: rtl;` for testing -->
<div class="lf-grid" style="direction: rtl;">
  <div class="lf-grid__col--6-12">
    <p>I'm on right</p>
  </div>
  <div class="lf-grid__col--6-12">
    <p>I'm on left</p>
  </div>
</div>
```

### Priority ordering

Actually this is a column modifier but it gets it's own section because it is really special and should be use with caution.

The `.lf-grid__col--important` modifier lets you specify that some column shards are more "important" that others and should appear first, regardless of the original HTML ordering.

Let's see:

```html
<div class="lf-grid">
  <div class="lf-grid__col--4-12">
    <p>I'm second</p>
  </div>
  <div class="lf-grid__col--4-12 lf-grid__col--important">
    <p>I'm first</p>
  </div>
  <div class="lf-grid__col--4-12">
    <p>I'm third</p>
  </div>
</div>
```

### <a href="#" id="gutters"></a>Gutters

Since version `0.2.0` the project support the usage of gutters. Previously we used box to simulated gutter behavior but turns out that's not that useful since you can have fairly complex usability in grids.

So now to use gutters you just have to declare your `lf-grid` with the `with-gutter` modifier. Your columns will follow automatically.

```html
<div class="lf-grid lf-grid--with-gutter">
  <div class="lf-grid__col--6-12">
    <p>1/2 with gutter</p>
  </div>
  <div class="lf-grid__col--6-12">
    <p>1/2 with gutter</p>
  </div>
</div>
```

Notice that this new implementation removes the space on the border of the grid, thus allowing you to have consistent spacing across the whole page.

## <a href="#" id="demo"></a>Demo

You can see `leaf-grid` in action by cloning and running the built-in demo located on the `demo` folder.

## <a href="#" id="browsersupport"></a>Browser support

Browser support is limited browsers that support flexbox. We use [autoprefixer](https://github.com/postcss/autoprefixer) to apply the vendor prefixes and to mix the [old and new flexbox syntaxes](https://css-tricks.com/old-flexbox-and-new-flexbox/).

We test support on most evergreen browsers with [Sauce Labs](https://saucelabs.com/).

| <img src="https://raw.githubusercontent.com/alrra/browser-logos/master/chrome/chrome_64x64.png" width="32px" height="32px"> | <img src="https://raw.githubusercontent.com/alrra/browser-logos/master/internet-explorer/internet-explorer_64x64.png" width="32px" height="32px"> | <img src="https://raw.githubusercontent.com/alrra/browser-logos/master/firefox/firefox_64x64.png" width="32px" height="32px"> | <img src="https://raw.githubusercontent.com/alrra/browser-logos/master/opera/opera_64x64.png" width="32px" height="32px"> | <img src="https://raw.githubusercontent.com/alrra/browser-logos/master/safari/safari_64x64.png" width="32px" height="32px"> | <img src="https://raw.githubusercontent.com/alrra/browser-logos/master/edge/edge_64x64.png" width="32px" height="32px">  | Android | iOS |
| :---:  |:---:|  :---:  | :---: | :---:  | :---:|  :---:  |:---:|
|   21+  | 10+ |   20+   |  12+  |   6+   |  12+ |   4.4+  |  7+ |

## <a href="#" id="license"></a>License

[MIT License](LICENSE)

[Build]: https://img.shields.io/circleci/project/leafui/leaf-grid/master.svg
[SemVer]: https://img.shields.io/:semver-%E2%9C%93-brightgreen.svg
[License]: https://img.shields.io/github/license/leafui/leaf-grid.svg
