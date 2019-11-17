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

  def test_defmodule_with_defP
    defmodule MyModule do
      defP message(hacker_name) do
        "Wake up, #{hacker_name}..."
      end
    end

    assert MyModule.message("Neo") == "Wake up, Neo..."
  end

  def test_defmodule_with_defP_multiple
    defmodule MyModule do
      defP message(hacker_name) do
        "Wake up, #{hacker_name}..."
      end

      defP message(instruction, hacker_name) do
        "#{instruction}, #{hacker_name}..."
      end
    end

    assert MyModule.message("Neo") == "Wake up, Neo..."
    assert MyModule.message("Follow the white rabbit", "Neo") == "Follow the white rabbit, Neo..."
  end

  def test_defmodule_with_dẹf_alias
    defmodule MyModule do
      dẹf message(hacker_name) do
        "Wake up, #{hacker_name}..."
      end

      dẹf message(instruction, hacker_name) do
        "#{instruction}, #{hacker_name}..."
      end
    end

    assert MyModule.message("Neo") == "Wake up, Neo..."
    assert MyModule.message("Follow the white rabbit", "Neo") == "Follow the white rabbit, Neo..."
  end

  def test_defmodule_with_dẹf_alias
    defmodule MyModule do
      dẹf message(hacker_name) do
        "Wake up, #{hacker_name}..."
      end
    end

    assert_raises UndefinedFunctionError do
      MyModule.non_existing_function()
    end
  end

end
