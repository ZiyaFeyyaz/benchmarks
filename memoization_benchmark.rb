require 'benchmark'

# Source: activesupport-5.0.7.2/lib/active_support/core_ext/object/blank.rb
class Object
  def blank?
    respond_to?(:empty?) ? !!empty? : !self
  end

  def present?
    !blank?
  end

  def presence
    self if present?
  end
end

class Obj
  attr_accessor :params
  
  def initialize
    @params ||= { page: 123 }
  end

  def params_page_with_memoization
    @params_page ||= params[:page].presence.to_i
  end

  def params_page_without_memoization
    params[:page].presence.to_i
  end

  def first_method
    params_page_with_memoization
  end

  def second_method
    params_page_without_memoization
  end
end

obj = Obj.new
N = 100_000_000

puts RUBY_DESCRIPTION

Benchmark.bm(15, "rescue/condition") do |x|
  first = x.report("with memoization   :") { N.times { obj.first_method } }
  second = x.report("without memoization:") { N.times { obj.second_method } }
  [first / second]
end
