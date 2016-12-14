module Civil
  class Result
    attr_reader :data, :conditions, :meta

    def initialize(data, conditions = Civil::Hash.new, meta = Civil::Hash.new)
      @data = data
      @conditions = conditions
      @meta = meta
    end

    def ideal?
      conditions.empty?
    end

    def deviant?
      !ideal?
    end

    def to_s
      data.to_s
    end

    def to_json
      data.to_json
    end
  end
end
