---
layout: post
title:  "Unit testing: Ruby with RSpec"
date:   2014-01-24 20:17:39
categories: ruby calculator unit tutorial
---

This tutorial assumes that you:

* know how to read, write, and run Ruby
* have familiarity with Ruby Gems
* know what unit testing is
* have downloaded the calculator (see below)

If any of that is beyond the scope of your abilities, you can likely still follow along.

## Download calculator

A basic tutorial on how to use the repos to navigate alongside the code is available here.

* [View repo](https://github.com/feministy/rspec_calculator)
* `git clone https://github.com/feministy/rspec_calculator.git`

## Our test object: a calculator

Here we have a simple Ruby calculator that has addition, subtraction, and multiplication calculating functionalities. It also allows you to clear or remove the last number inserted. The purpose of this calculator is to mimic a simple real-world object that many people are familiar with so you can learn RSpec by testing something you already know how to use:

{% highlight ruby linenos %}
class Calculator
  attr_reader :nums

  def push(n)
    @nums ||= []
    @nums << n
  end

  def multiply
    @nums.inject(&:*)
  end

  def add
    @nums.inject(&:+)
  end

  def subtract
    @nums.inject(&:-)
  end

  def clear
    @nums = []
  end

  def remove_last
    @nums.pop(1)
    @nums
  end
end
{% endhighlight %}

### Using the calculator

If you want to play with the calculator interactively: load up irb (` $ irb `). Inside of `irb`:

{% highlight ruby linenos %}
load 'calculator.rb'
{% endhighlight %}

And now you have access to your calculator file in `irb` where you can play.

First you create a Calculator object:

{% highlight ruby linenos %}
calc = Calculator.new
{% endhighlight %}

Then, you add numbers to your calculator with `push`:

{% highlight ruby linenos %}
calc.push(46)
calc.push(2)
{% endhighlight %}

You can add as many or as few numbers as you want to your calculator.

After you've added the numbers you want into your calculator, you can do math:

{% highlight ruby linenos %}
calc.add # => 48
calc.multiply # => 92
calc.subtract # => 44
{% endhighlight %}

If you want to remove the last number you added:

{% highlight ruby linenos %}
calc.remove_last # => [46]
{% endhighlight %}

Or, when you're ready to start over, you can:

{% highlight ruby linenos %}
calc.clear # => []
{% endhighlight %}

At any point, you can check the contents of your calculator with:

{% highlight ruby linenos %}
calc.nums # => [46]
{% endhighlight %}

**This calculator is not destructive**. So if you do:

{% highlight ruby linenos %}
calc = Calculator.new
calc.push(3)
calc.push(5)
calc.nums # => [3, 5]
calc.add # => 8
calc.nums # => [3, 5]
{% endhighlight %}

You can see that `calc.nums` does not change. The contents are protected.

## Running existing tests

###### branch: part-01

Before you start modifying the code or writing your own tests, you should become familiar with the existing tests.

First, you will need to install RSpec. This requires RubyGems. Install with the command `gem install rspec`.

Second, you will need to have Ruby 1.9.3 or greater. The tests currently pass with Ruby 2.0.0 and 1.9.3; I cannot guarantee functionality for any other version of Ruby.

To run the tests, type: `rspec calculator_spec.rb`

This will return some pretty formatted information for you.

{% highlight ruby %}
Calculator
  #multiply
    works
  #push
    adds new numbers
    accumulates numbers
    requires an argument
    does not accept more than 1 argument
  #nums
    should be nil on init

Finished in 0.00516 seconds
6 examples, 0 failures

Randomized with seed 21811
{% endhighlight %}

The test run order is randomized to help you spot any potential problems with your code or your test suite.

## Writing more calculator tests

The `calculator_spec.rb` file has a few contexts with no tests in them. You should write some! Here are some helpful resources:

* [Better Specs](http://betterspecs.org/) - comparison of good specs and bad specs
* [RSpec Expectations](http://rubydoc.info/gems/rspec-expectations/frames) - guides for using RSpec

Some things to keep in mind:

* Each test block (starts with `it 'should do this thing' do`) should contain only one assertion. Assertions are the lines that include `expect` (`expect(@calc.nums).to be_nil`).
* Anything in a `before` block is run before each test.
* Variables with an `@` symbol in front of them are instance variables and can be used throughout your file.
* This test file is intentionally not perfect. What tests are missing for `#push` and `#initialize`? Is there functionality missing from the Calculator itself? Can the tests be refactored?

## Anatomy of a test

###### branch: part-02

Here is a simple test for addition:

{% highlight ruby linenos %}
it 'returns the sum of all numbers' do
  calc = Calculator.new
  calc.push(2)
  calc.push(5)
  calc.push(3)
  total = calc.add
  expect(total).to be(10)
end
{% endhighlight %}

Now lets break this down.

This is the description of what our test is actually testing for.

{% highlight ruby %}
it 'returns the sum of all numbers' do
{% endhighlight %}

We have to make a new Calculator object:

{% highlight ruby %}
  calc = Calculator.new
{% endhighlight %}

And put some numbers into our Calculator:

{% highlight ruby %}
  calc.push(2)
  calc.push(5)
  calc.push(3)
{% endhighlight %}

Now that our calculator has numbers, we can add them together to get a total using the add method.

{% highlight ruby %}
  total = calc.add
{% endhighlight %}

This is our assertion. Read in plain English: `we expect the total to be 10`. Our test will pass if the total is 10. Our test will fail is the total is not 10 (the Integer).

{% highlight ruby %}
  expect(total).to be(10)
end
{% endhighlight %}


