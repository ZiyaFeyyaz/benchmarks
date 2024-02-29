require 'benchmark'

class Obj
  attr_accessor :params
  
  def initialize
    @float = 12.345
  end

  def to_int_if_whole_with_modulo(float)
    (float % 1 == 0) ? float.to_i : float
  end

  def to_int_if_whole_with_to_i(float)
    float == float.to_i ? float.to_i : float
  end

  def first_method
    to_int_if_whole_with_modulo(@float)
  end

  def second_method
    to_int_if_whole_with_to_i(@float)
  end
end

obj = Obj.new
N = 100_000_000

puts RUBY_DESCRIPTION

Benchmark.bm(15, "rescue/condition") do |x|
  first = x.report("with modulo :") { N.times { obj.first_method } }
  second = x.report("with to_i   :") { N.times { obj.second_method } }
  [first / second]
end
