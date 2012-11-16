require File.expand_path('spec/spec_helper')
include EZS
describe GlobalRms do
  it "should priorize tasks" do
    s = GlobalRms.new
    t = "7,1 10,2 20,9 22,11 25,2".to_global_rms_tasks
    s.tasks = t
    s.sort_by_priority.must_be_kind_of  Array
  end
  it "should check if task has max prio" do
    t = GlobalRmsTask.new(3,2)
    t.load.must_equal 2/3.to_f
    t.has_max_prio?(2).must_equal true
    t.has_max_prio?(1).must_equal false
  end
  it "should prio correctly" do
    s = GlobalRms.new
    t = "10,2 3,2".to_global_rms_tasks
    t1 = t[0]
    t2 = t[1]
    s.tasks = t
    s.cpu_count = 2
    s.sort_by_priority.must_equal [t2,t1]
  end
  it  "complex example" do
    s = GlobalRms.new
    t = "7,1 10,2 20,9 22,11 25,2".to_global_rms_tasks
    s.tasks = t
    s.cpu_count = 3
    t1 = t[0]
    t2 = t[1]
    t3 = t[2]
    t4 = t[3]
    t5 = t[4]
    s.sort_by_priority.must_equal [t3,t4,t1,t2,t5]
  end
  it "calculate schedulability" do
    s = GlobalRms.new
    t = "10,2 3,2".to_global_rms_tasks
    s.tasks = t
    s.cpu_count = 2
    s.schedulable?.must_equal true
  end
  it "calculate complex example" do
    s = GlobalRms.new
    t = "7,1 10,2 20,9 22,11 25,2".to_global_rms_tasks
    s.tasks = t
    s.cpu_count = 3
    s.schedulable?.must_equal false
  end
  it "should calculate the tardiness" do
    s = GlobalRms.new
    t = "7,1 10,2 20,9 22,11 25,2".to_global_rms_tasks
    s.tasks = t
    s.cpu_count = 3
    t1 = t[0]
    t2 = t[1]
    t3 = t[2]
    t4 = t[3]
    t5 = t[4]
    sorted = s.sort_by_priority
    s.max_response.must_equal [9,11,1,17,19]
  end
end
