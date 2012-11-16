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
      #puts "#{left} <= #{right}"
      left <= right
    end
    def max_response
      sorted = sort_by_priority
      sorted.map.with_index do |t,i|
        if i < cpu_count
          t.e
        else
          tasks_with_higher_prio = sorted[0..i-1]
          res = t.e
          res_old = 0
          begin
          res_old = res
          sum_of_previous = tasks_with_higher_prio.map do |task|
            tardiness_for_task(task,res)
          end.inject(0){|sum,x| sum + x}
          res = t.e + 1/cpu_count.to_f * sum_of_previous
          end while res != res_old

          res.ceil #dont know if this is right Oo maybe ceil is not ok but would make sense here
        end
      end
    end
    def tardiness_for_task(task,previous)
      (previous/task.p).ceil * task.e + task.e
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
