require_relative "lib/edf.rb"
require_relative "lib/task.rb"
require_relative "lib/rmff.rb"
require_relative "lib/global.rb"
require_relative "lib/helper.rb"

include EZS
# Global rate monotonic scheduler check it out under lib/global.rb
s = GlobalRms.new
# String method patched for easy conversion of strings in Arrays of Tasks
t = "10,2 3,2".to_global_rms_tasks
s.tasks = t
# set the cpu count
s.cpu_count = 2
# s.schedulable calculates the schedulability
puts "Tasks are schedulable? #{s.schedulable?}"
# to see a list of the tasks just
p s.tasks

# more examples in the spec directory
