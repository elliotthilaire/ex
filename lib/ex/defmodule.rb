class UndefinedFunctionError < StandardError
end

class Object
  def defmodule(name, &block)
    eval("#{name.to_s} = Module.new()")

    m = Kernel.const_get(name.to_s)

    m.class_eval do
      def method_missing(m_missing_name, *m_missing_args, &m_missing_block)
        [m_missing_name, m_missing_args, m_missing_block]
      end

      module_function :method_missing
    end

    m.class_variable_set(:@@public_functions, {})
    m.class_variable_set(:@@current_arg_values, [])
    m.class_variable_set(:@@current_arg_names, [])

    m.class_eval do
      def defP(ast, &block)
        function_name = ast[0]
        arg_names = ast[1].map {|list| list[0]}
        arity = arg_names.size

        p = self.class_variable_get(:@@public_functions)
        p[{name: function_name, arity: arity}] = {args: arg_names, proc: block}
        p = self.class_variable_set(:@@public_functions, p)
      end

      m.class_eval do
        def method_missing(m_missing_name, *m_missing_args, &m_missing_block)

          if f = self.class_variable_get(:@@public_functions)[{name: m_missing_name, arity: m_missing_args.size}]
            self.class_variable_set(:@@current_arg_values, m_missing_args)
            self.class_variable_set(:@@current_arg_names, f[:args])

            f[:proc].call
          elsif index = self.class_variable_get(:@@current_arg_names).find_index(m_missing_name)
            self.class_variable_get(:@@current_arg_values)[index]
          else
            raise UndefinedFunctionError
          end
        end
      end

      alias_method :dẹf, :defP

      module_function :defP, :dẹf
    end

    m.class_eval(&block)

    eval("
      module #{m}
        module_function #{m.instance_methods.map(&:to_s).map {|t| ':' + t }.join(', ')}
      end
    ")

  end

  def self.const_missing(name)
    name
  end
end
