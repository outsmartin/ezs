module EZS
  # Algorithm RM-US[m/(3m-2]
  class GlobalRms
    attr_accessor :tasks,:cpu_count
    def sort_by_priority
      sorted = []
      leftover = []
      tasks.each do |t|
        sorted << t if t.has_max_prio?(cpu_count)
        leftover << t if ! t.has_max_prio?(cpu_count)
      end
      sorted + leftover
    end
    def cpu_count
      @cpu_count.to_i
    end
    def schedulable?
      left = @tasks.map(&:load).inject(0){|x,y| x+y}
      right =  global_rms_max(cpu_count)
      puts "#{left} <= #{right}"
      left <= right
    end

  end
  def global_rms_calc(cpu_count)
    (cpu_count / (3 * cpu_count - 2).to_f)
  end
  def global_rms_max(cpu_count)
    (cpu_count**2 / (3 * cpu_count - 2).to_f)
  end
  class GlobalRmsTask < Task
    def has_max_prio?(cpu_count)
      self.load > global_rms_calc(cpu_count)
    end
  end

end
