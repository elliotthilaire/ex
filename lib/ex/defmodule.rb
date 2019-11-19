class UndefinedFunctionError < StandardError
end

class Object
  # Open object and create method for creating modules.
  def defmodule(name, &block)

    # Create a module from the name of the constant passed in
    eval("#{name.to_s} = Module.new()")
    m = Kernel.const_get(name.to_s)

    # Override method_missing to recursively construct a syntax tree
    m.class_eval do
      def method_missing(m_missing_name, *m_missing_args, &m_missing_block)
        [m_missing_name, m_missing_args, m_missing_block]
      end

      module_function :method_missing
    end

    # Set up a class variables to keep track of defined functions.
    m.class_variable_set(:@@public_functions, {})

    # And some class variables for keeping track of variable names and values when a function is run.
    m.class_variable_set(:@@current_arg_values, [])
    m.class_variable_set(:@@current_arg_names, [])

    # define a defP function that uses the syntax tree from method missing to populate a store of functions.
    m.class_eval do
      def defP(ast, &block)
        function_name = ast[0]
        arg_names = ast[1].map {|list| list[0]}
        arity = arg_names.size

        p = self.class_variable_get(:@@public_functions)
        p[{name: function_name, arity: arity}] = {args: arg_names, proc: block}
        p = self.class_variable_set(:@@public_functions, p)
      end

      # Redefine method missing after the functions are created and stored on the module
      # This version of method missing catches function names and variable names during execution
      # and finds the right answers from the module.
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

      # alias :dẹf to defP. Notice the dot.
      alias_method :dẹf, :defP

      module_function :defP, :dẹf
    end

    # Evaluate the block passed into defmodule
    m.class_eval(&block)

    # I can't remember why I am doing this. But tests fail if it's removed.
    eval("
      module #{m}
        module_function #{m.instance_methods.map(&:to_s).map {|t| ':' + t }.join(', ')}
      end
    ")
  end

  # Override const_missing
  def self.const_missing(name)
    name
  end
end
