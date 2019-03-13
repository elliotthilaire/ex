require 'test_helper'

class Ex::DefmoduleTest < Minitest::Test

  def test_defmodule
    defmodule MyModule do
      def hello
        "world"
      end
    end

    assert MyModule.hello == "world"
  end

  def test_defmodule_with_a_function_with_an_arg
    defmodule MyModule do
      def message(name)
        "Wake up, #{name}..."
      end
    end

    assert MyModule.message("Neo") == "Wake up, Neo..."
  end

end
