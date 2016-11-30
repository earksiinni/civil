module Civil
  module Service
    def self.included(klass)
      class << klass
        # Civil::Service.service
        # Wrapper method, used within service class
        #
        # service do
        #   execute_step_1
        #   execute_step_2
        #   ...
        # end
        def service(&block)
          define_method '_run', &block
        end

        # Civil::Service.call
        # Initiate service execution and return standardized result
        #
        # result = MyService.call(foo: 1, bar: 'a')
        # 
        # if result.ideal?
        #   ...
        # else
        #   ...
        # end
        def call(params = {})
          service = new(params)
          data = service._run

          Civil::Result.new(data, service._conditions, service._meta)
        end
      end
    end

    def initialize(params = {})
      params.to_h.each do |(name, value)|
        instance_variable_set("@#{name}", value)
      end
    end

    def add_condition(type, desc = "")
      _conditions[type.to_sym] = desc.to_s
    end

    def add_meta(type, desc = "")
      _meta[type.to_sym] = desc.to_s
    end

    def _conditions
      @_conditions ||= {}
    end

    def _meta
      @_meta ||= {}
    end
  end
end
