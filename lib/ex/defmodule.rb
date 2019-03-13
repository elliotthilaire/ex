class Object
  def defmodule(name, &block)
    eval("#{name.to_s} = Module.new()")

    m = Kernel.const_get(name.to_s)

    m.module_eval(&block)

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
