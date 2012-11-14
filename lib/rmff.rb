module EZS
  class Cpu
    attr_accessor :load,:tasks
    def initialize
      @load = 0
      @tasks = []
    end
    def load
      sum = 0
      @tasks.each{|x| sum = sum + x.load}
      sum
    end
    def to_s
      @tasks
    end
  end

  class Rmff
    attr_accessor :tasks,:cpus
    def initialize
      @cpus = [Cpu.new]
    end
    def einplanungstest(p,t)
     (p.load + t.load) >= liu_layland(p.tasks.count)
    end
    def schedule
      tasks.each do |t|
        cpus.each do |p|
          if einplanungstest(p,t)
            if p == cpus.last
              cpu_new = Cpu.new
              cpu_new.tasks << t
              cpus << cpu_new
              break
            end
          else
            p.tasks << t
            break
          end
        end
      end
    end
  end

  class Rmffdu < Rmff
    def schedule
      tasks.sort_by!{|t| -t.load}
      super
    end
    def einplanungstest(p,t)
      new_tasks = p.tasks + [t]
      hyperbolic_bound(new_tasks) > 2
    end
  end
  class Rmst < Rmff
    def schedule
      tasks.sort_by!{|t| xi(t.p)}
      p tasks
      super
    end
    def einplanungstest(p,t)
      new_load = p.load + t.load
      xi_min = p.tasks.map{|task| xi(task.p)}.min
      xi_min ||= 0
      zeta = 1 - ((xi(t.p) - xi_min) * Math.log(2))
      p ""
      p xi_min
      p new_load
      p zeta
      new_load > [Math.log(2), zeta].max
    end
  end

  def xi(t)
    Math.log2(t) - Math.log2(t).to_i
  end
  def liu_layland(i)
    i*(2**(1/i.to_f) - 1)
  end

  def hyperbolic_bound(tasks)
   sum = 1
   tasks.map{|t| t.load}.each{ |l| sum = sum  * (1+l)}
   sum
  end
end

