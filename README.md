# Intro to Testing

The purpose of this repository is to mimic a simple real-world object that many people are familiar with (a calculator) so you can learn how to write unit tests.

Currently this repo covers Ruby and testing with RSpec; more to follow.

## Intro to RSpec

This is a simple Ruby calculator that has addition, subtraction, and multiplication calculating functionalities. It also allows you to clear or remove the last number inserted. The purpose of this calculator is to mimic a simple real-world object that many people are familiar with so you can learn RSpec by testing something you already know how to use.

**These instructions assume you know how to read, write, and run Ruby.**

### Using the Calculator

First you create a Calculator object:

```ruby
calc = Calculator.new
```

Then, you add numbers to your calculator with `push`:

```ruby
calc.push(46)
calc.push(2)
```

You can add as many or as few numbers as you want to your calculator.

After you've added the numbers you want into your calculator, you can do math:

```ruby
calc.add # => 48
calc.multiply # => 92
calc.subtract # => 44
```

If you want to remove the last number you added:

```ruby
calc.remove_last # => [46]
```

Or, when you're ready to start over, you can:

```ruby
calc.clear # => []
```

At any point, you can check the contents of your calculator with:

```ruby
calc.nums # => [46]
```

**This calculator is not destructive**. So if you do:

```ruby
calc = Calculator.new
calc.push(3)
calc.push(5)
calc.nums # => [3, 5]
calc.add # => 8
calc.nums # => [3, 5]
```

You can see that `calc.nums` does not change. The contents are protected.

### Running the Calculator

There is some code commented out at the bottom of the file. This is a quick and dirty example of how to use the calculator without needing to open the README file.

If you want to play with the calculator interactively: load up irb (` $ irb `). Inside of irb:

```ruby
load 'calculator.rb'

calc = Calculator.new
calc.push(1)
calc.push(2)
calc.push(3)

calc.nums
# => [1, 2, 3]

calc.add
# => 6

calc.nums
# => [1, 2, 3]

calc.multiply
# => 6

calc.subtract
# => -4

calc.remove_last
# => [1, 2]

calc.nums
# => [1, 2]

calc.clear
# => []

calc.nums
# => []
```

### Running the Calculator Tests

First, you will need to install RSpec. This requires RubyGems.

```
gem install rspec
```

Second, you will need to have Ruby 1.9.3 or greater. The tests currently pass with Ruby 2.0.0 and 1.9.3; I cannot guarantee functionality for any other version of Ruby.

To run the tests, type:

```
rspec calculator_spec.rb
```

This will return:

```
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
```

The test run order is randomized to help you spot any potential problems with your code or your test suite.

### Writing More Calculator Tests

The `calculator_spec.rb` file has a few contexts with no tests in them. You should write some! Here are some helpful resources:

* [Better Specs](http://betterspecs.org/) - comparison of good specs and bad specs
* [RSpec Expectations](http://rubydoc.info/gems/rspec-expectations/frames) - guides for using RSpec

Some things to keep in mind:

* Each test block (starts with `it 'should do this thing' do`) should contain only one assertion. Assertions are the lines that include `expect` (`expect(@calc.nums).to be_nil`).
* Anything in a `before` block is run before each test.
* Variables with an `@` symbol in front of them are instance variables and can be used throughout your file.
* This test file is intentionally not perfect. What tests are missing for `#push` and `#initialize`? Is there functionality missing from the Calculator itself? Can the tests be refactored?

#### Anatomy of a test

Here is a simple test for addition (not in `calculator_spec.rb`):

```ruby
it 'returns the sum of all numbers' do
  calc = Calculator.new
  calc.push(2)
  calc.push(5)
  calc.push(3)
  total = calc.add
  expect(total).to be(10)
end
```

Now lets break this down:

```ruby
# This is the description of what our test is actually testing for.
it 'returns the sum of all numbers' do

  # We have to make a new Calculator object
  calc = Calculator.new
  
  # And put some numbers into our Calculator
  calc.push(2)
  calc.push(5)
  calc.push(3)
  
  # Now that our calculator has numbers,
  # we can add them together to get a total
  # using the add method.
  total = calc.add
  
  # This is our assertion.
  # Read in plain English: We expect the total to be 10.
  # Our test will pass if the total is 10.
  # Our test will fail is the total is not 10 (the Integer).
  expect(total).to be(10)
end
```

It's not necessary to do:

```ruby
total = calc.add
expect(total).to be(10)
```

You could instead do:

```ruby
expect(calc.add).to be(10)
```

The former is a little easier to read as a beginner, and the latter is a bit shorter. Both are fine!

### Adding New Functionality to the Calculator

Try adding a divide function, returning an error if someone tries to add a string to the calculator, rounding, or other advanced functionality. Write your tests before you write your code!
