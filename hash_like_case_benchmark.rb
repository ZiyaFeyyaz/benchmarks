require 'benchmark'

class Obj
  attr_accessor :country

  SITES = {
    'europe'    => 'http://eu.example.com',
    'america'   => 'http://us.example.com',
    'australia' => 'http://au.example.com'
  }.freeze

  def initialize
    @country ||= %w[europe america australia].sample
  end

  def url_via_case
    case country
    when 'europe'
      'http://eu.example.com'
    when 'america'
      'http://us.example.com'
    when 'australia'
      'http://au.example.com'
    end
  end

  def url_via_hash
    SITES[country]
  end

  def first_method
    url_via_case
  end

  def second_method
    url_via_hash
  end
end

obj = Obj.new
N = 100_000_000

puts RUBY_DESCRIPTION

Benchmark.bm(15, "rescue/condition") do |x|
  first = x.report('case:') { N.times { obj.first_method } }
  second = x.report('hash:') { N.times { obj.second_method } }
  [first / second]
end
