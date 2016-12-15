module Civil
  class Array < ::Array
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
      self.inject(Civil::Array.new) { |arr, item|
        item.is_a?(Civil::Hash) and item =~ attrs and arr << item

        arr
      }
    end

    def pluck(key)
      raise ArgumentError, "key must be a symbol" unless key.is_a? Symbol

      self.inject(Civil::Array.new) { |arr, item|
        item.is_a?(Civil::Hash) and arr << item[key]

        arr
      }
    end
  end
end
