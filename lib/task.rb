module EZS
  class Task
    attr_reader :p,:e,:todo
    def initialize p,e
      @p = p
      @e = e
      @todo = e
    end
    def do_work
      @todo = @todo - 1
    end
    def no_work?
      @todo < 1
    end
    def reset
      @todo = e
    end
    def deadline(time)
      return nil if @todo < 1
      return p if time < p
      perioden_in_time = (time / p.to_f).to_i
      p * (perioden_in_time + 1) # neue deadline
    end
    def to_s
      "T(#@p,#@e)"
    end
    def load
      e / p.to_f
    end
  end
end
