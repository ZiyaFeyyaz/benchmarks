require 'benchmark'
require 'faker'

class Obj
  def first_method
    { name: Faker::Internet.email }
  end

  def second_method
    { name: Faker::Lorem.word }
  end

  def third_method
    { name: 'qwerty@qwerty' }
  end
end

obj = Obj.new
N = 10_000

puts RUBY_DESCRIPTION

Benchmark.bm(15, "rescue/condition") do |x|
  first = x.report('Faker::Internet.email:') { N.times { obj.first_method } }
  second = x.report('Faker::Lorem.word   :') { N.times { obj.second_method } }
  third = x.report('use static           :') { N.times { obj.third_method } }
  
  [first / second]
end
