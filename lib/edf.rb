module EZS
  class Edf
    attr_reader :time, :schedule
    def initialize(tasks = [])
      @time = 0
      raise "give me an array of tasks" unless tasks.kind_of? Array
      @tasks = tasks
      @schedule = []
    end
    def to_s
      puts "Schedule zu T=#@time mit Tasks #@tasks"
    end
    def tasks
      @tasks.each_with_index.map{|t,i| "T#{i+1} p=#{t.p} e=#{t.e}"}.join("\n")
    end
    def advance
      puts "Aktuelle Zeit #@time"
      @active = @tasks.reject{|t|
        t.deadline(@time) == nil
      }.min_by{|t| t.deadline(@time)}
      @active.do_work if @active
      @schedule << @active
      @time += 1
      reset_tasks
    end
    def active
      @active || nil
    end
    def reset_tasks
      @tasks.each do |t|
        next if t.todo != 0
        next if @time == 0
        next if (( @time % t.p ) != 0)
        t.reset
      end
    end
  end
end
