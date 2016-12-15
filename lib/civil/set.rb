module Civil
  class Set < ::Array
    def initialize(*args, &block)
      if args[0].is_a? ::Array
        args[0] = args[0].map { |e| e.is_a?(::Hash) ? Civil::Hash.new.merge(e) : e }
      end

      super
    end

    def <<(o)
      o and o.is_a?(::Hash) and o = Civil::Hash.new.merge(o)

      super
    end

    def where(attrs)
      self.inject(Civil::Set.new) { |set, item|
        item.is_a?(Civil::Hash) and item =~ attrs and set << item

        set
      }
    end

    def pluck(key)
      raise ArgumentError, "key must be a symbol" unless key.is_a? Symbol

      self.inject(Civil::Set.new) { |set, item|
        item.is_a?(Civil::Hash) and set << item[key]

        set
      }
    end
  end
end
