class String
  def to_tasks
    self.split(" ").map do |t|
      p,e = t.split(",")
      Task.new(p.to_i,e.to_i)
    end
  end
  alias :to_task :to_tasks
  def to_global_rms_tasks
    self.split(" ").map do |t|
      p,e = t.split(",")
      GlobalRmsTask.new(p.to_i,e.to_i)
    end
  end
  alias :to_global_rms_task :to_global_rms_tasks
end
