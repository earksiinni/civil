module Civil
  class Hash < ::Hash
    def =~(attrs)
      attrs.each do |k, v|
        keys.include?(k) && self[k] == v or return false
      end

      return true
    end
  end
end
