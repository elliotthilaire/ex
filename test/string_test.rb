require 'test_helper'

class Ex::StringTest < Minitest::Test

  def test_pad_leading
    assert String.pad_leading("abc", 6) == "   abc"
  end

end
