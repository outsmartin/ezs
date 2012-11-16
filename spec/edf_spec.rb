require 'spec_helper.rb'
include EZS
describe Edf do
  it "should print tasks" do
    s = Edf.new
    s.tasks.must_equal ""
    s= Edf.new([Task.new(3,1)])
    s.tasks.must_equal "T1 p=3 e=1"
  end
  it "should give nil for active job at start" do
    s= Edf.new([Task.new(3,1),Task.new(2,1)])
    s.active.must_be_nil
  end
  it "should advance and active should change" do
    t1 = Task.new(3,1)
    t2 = Task.new(2,1)
    s= Edf.new([t1,t2])
    #Task 2 begins because he has earlier deadline
    s.advance
    s.active.must_be_same_as t2
    t2.todo.must_equal 0
    s.time.must_equal 1
    #Task 1 now because its the only one left
    s.advance
    s.active.must_be_same_as t1
    s.time.must_equal 2
    t1.todo.must_equal 0
    #Task 2 should now be active again, as he has got some
    #more work to do
    s.advance
    s.active.must_be_same_as t2

    # after executing it should save the order in an array
    s.schedule.must_equal [t2,t1,t2]
  end
  specify "complex example" do
    skip "deadline handling not complete"
    t1 = Task.new(3,1)
    t2 = Task.new(5,2)
    t3 = Task.new(8,3)
    s = Edf.new([t1,t2,t3])
    17.times do
      s.advance
    end
    s.schedule.must_equal [t1,t2,t2,t1,t3,
                           t3,t3,t1,t2,t2,
                           t1,t2,t2,t1,t3,
                           t3,t3]
  end
end
