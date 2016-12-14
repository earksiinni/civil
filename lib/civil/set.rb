module Civil
  class Set < ::Set
    def initialize(enum = nil)
      enum = enum.map { |e| e.is_a?(::Hash) ? Civil::Hash.new.merge(e) : e } if enum

      super
    end

    def add(o)
      o and o.is_a?(::Hash) and o = Civil::Hash.new.merge(o)

      super
    end

    def <<(o)
      add(o)
    end

    def where(attrs)
      self.inject(Civil::Set.new) { |set, item|
        item.is_a?(Civil::Hash) and item =~ attrs and set.add(item)

        set
      }
    end
  end
end
