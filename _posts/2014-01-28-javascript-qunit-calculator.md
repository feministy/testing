---
layout: post
title:  "Unit testing: JavaScript and Qunit"
date:   2014-01-28 20:17:39
categories: javascript unit tutorial
---

This tutorial assumes that you:

* know how to read, write, and run JavaScript
* have familiarity with the Chrome DevTools Console
* know what unit testing is
* have downloaded the calculator (see below)

## Download calculator

A basic tutorial on how to use the repos to navigate alongside the code is available here.

* [View repo](https://github.com/feministy/qunit_javascript_calculator)
* `git clone https://github.com/feministy/qunit_javascript_calculator.git`

## Our test object: a calculator

Here we have a simple JavaScript calculator that has addition, subtraction, and multiplication calculating functionalities. It also allows you to clear or remove the last number inserted. The purpose of this calculator is to mimic a simple real-world object that many people are familiar with so you can learn QUnit by testing something you already know how to use:

{% highlight js linenos %}
var Calculator = function Calculator() {
  this.constructor;
}

Calculator.prototype = {
  nums: [],

  push: function(num) {
    this.nums.push(num);
    return this.nums;
  },

  add: function() {
    var total = this.nums.reduce(function(a, b) {
      return a + b;
    });
    return total;
  },

  subtract: function() {
    var total = this.nums.reduce(function(a, b) {
      return a - b;
    });
    return total;
  },

  multiply: function() {
    var total = this.nums.reduce(function(a, b) {
      return a * b;
    });
    return total;
  },

  clear: function() {
    this.nums = [];
    return this.nums;
  },

  removeLast: function() {
    this.nums.pop();
    return this.nums;
  }
}
{% endhighlight %}

### Using the calculator

If you want to play with the calculator interactively, I'd recommend using [repl.it](http://repl.it/languages/JavaScript). Paste the calculator into the left panel and hit the 'run' arrow. You can type the commands below on the right side of the  screen.

First, create your calculator object.

{% highlight js %}
var calc = new Calculator();
{% endhighlight %}

Then add some numbers:

{% highlight js %}
calc.push(1);
calc.push(2);
calc.push(3);
{% endhighlight %}

Then do some math:

{% highlight js %}
calc.multiply();
// => 6
{% endhighlight %}

If you make a mistake, you can remove the last number you added:

{% highlight js %}
calc.removeLast();
// => [1, 2]
{% endhighlight %}

Or check the contents of your calculator:

{% highlight js %}
calc.nums();
// => [1, 2]
{% endhighlight %}

Or clear the contents:

{% highlight js %}
calc.clear();
// => []
{% endhighlight %}

**The calulcator is not destructive**. `calc.nums();` does not change between add, subtract, and multiply operations. The contents are protected unless you run `clear()` or `removeLast()`.

## Setting up QUnit

###### branch part-01

You have to grab the CSS and JavaScript files for QUnit. You can grab them [here](https://qunitjs.com/). There are CDN links at the bottom of the page, or you can download and store the files locally. I've stored the files locally.

Create two new files:

1. `runner.html`
2. `calculatorSpec.js`

`calculatorSpec.js` is blank. For now.

Inside of `runner.html`, set up the page. Everything listed is a requirement for QUnit to run:

{% highlight html linenos %}
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>QUnit Example</title>
  <link rel="stylesheet" href="qunit-1.13.0.css">
</head>
<body>
  <div id="qunit"></div>
  <div id="qunit-fixture"></div>
  <script src="calculator.js"></script>
  <script src="qunit-1.13.0.js"></script>
  <script src="calculatorSpec.js"></script>
</body>
</html>
{% endhighlight %}

Lines 9 and 10 set up the divs for QUnit to run. `#qunit` is for the actual tests, and `#qunit-fixture` is for running tests that require DOM manipulatio (not covered here).

Lines 11, 12, and 13 require the files we need: our calculator, QUnit, and the calculator tests themselves.

If you open `runner.html` in your browser, it should say '0 assertions of 0 passed, 0 failed.'

So now we need to write some tests!

# A note on Coffeescript

###### branch: coffeescript

Just so you can see a comparison, I've included the calculator written in CoffeeScript along with a few simple tests. While the syntax of JavaScript can be a little frustrating, it is very helpful to understand how to read and write using the proper syntax before switching to CoffeeScript.