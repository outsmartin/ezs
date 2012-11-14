require 'spec_helper.rb'
require "minitest/spec"
require "minitest/autorun"
include EZS
describe Task do
  it "have period and execution time" do
    t = Task.new(3,1)
    t.e.must_equal 1
    t.p.must_equal 3
  end
  it "should give next deadline according to time" do
    t = Task.new(3,1)
    t.deadline(1).must_equal 3
    t.deadline(10).must_equal 12
  end
  it "deadline return nil if no more work in period" do
    t = Task.new(3,1)
    t.deadline(0).must_equal 3
    t.do_work
    t.deadline(1).must_equal nil
  end

end
