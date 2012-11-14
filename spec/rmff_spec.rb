require File.expand_path('spec/spec_helper')
require "pry"
include EZS
describe Rmff do

end
describe Rmff do
  it "should schedule" do
    rmff = Rmff.new
    rmff.tasks = [Task.new(7,2), Task.new(21,3),Task.new(29,9),Task.new(49,15),Task.new(64,20),Task.new(66,16),Task.new(160,32),Task.new(235,72),Task.new(260,25),Task.new(450,120)]
    rmff.schedule

    p rmff.cpus

  end

end
describe Rmffdu do
  it "should schedule" do
    rmff = Rmffdu.new
    rmff.tasks = [Task.new(7,2), Task.new(21,3),Task.new(29,9),Task.new(49,15),Task.new(64,20),Task.new(66,16),Task.new(160,32),Task.new(235,72),Task.new(260,25),Task.new(450,120)]
    rmff.schedule

    p rmff.cpus

  end
end
describe Rmst do
  it "should schedule" do
    rmff = Rmst.new
    rmff.tasks = [Task.new(7,2), Task.new(21,3),Task.new(29,9),Task.new(49,15),Task.new(64,20),Task.new(66,16),Task.new(160,32),Task.new(235,72),Task.new(260,25),Task.new(450,120)]
    rmff.schedule
    p rmff.cpus
  end
end
