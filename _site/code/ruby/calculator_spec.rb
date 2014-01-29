require 'rspec'
require_relative 'calculator.rb'

describe 'Calculator' do
  before do
    @calc = Calculator.new
  end

  context '#nums' do
    it 'should be nil on init' do
      expect(@calc.nums).to be_nil
    end
  end

  context '#push' do
    it 'adds new numbers' do
      @calc.push(9)
      expect(@calc.nums.include?(9)).to be_true
    end

    it 'requires an argument' do
      expect { @calc.push }.to raise_error(ArgumentError)
    end

    it 'does not accept more than 1 argument' do
      expect { @calc.push(1, 2, 3) }.to raise_error(ArgumentError)
    end

    it 'accumulates numbers' do
      @calc.clear
      nums = [1, 2, 3, 4]
      nums.each { |n| @calc.push(n) }
      expect(@calc.nums).to eql(nums)
    end
  end

  context '#multiply' do
    it 'works' do
      nums = [1, 2, 3, 4]
      nums.each { |n| @calc.push(n) }
      expect(@calc.multiply). to eql(24)
    end
  end

  context '#add' do
    # todo
  end

  context '#subtract' do
    # todo
  end

  context '#clear' do
    # todo
  end

  context '#remove_last' do
    # todo
  end
end