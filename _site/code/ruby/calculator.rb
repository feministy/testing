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


# ============================

# driver code

# calc = Calculator.new
# calc.push(3)
# calc.push(3)
# calc.push(2)

# puts calc.multiply == 18
# puts calc.add == 8
# puts calc.subtract == -2
# puts calc.remove_last == [3, 3]
# puts calc.clear == []

# ============================