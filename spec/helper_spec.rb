require File.expand_path('spec/spec_helper')
include EZS
describe "Helpers" do
  it "should translate a single String to an array of Tasks" do
    "5,2".to_tasks.must_be_kind_of Array
    "5,2".to_task.must_be_kind_of Array
    "5,2 5,2".to_task.length.must_equal 2
  end
  it "should translate to global task if needed" do
    "5,2".to_global_rms_tasks.must_be_kind_of Array
  end
end
