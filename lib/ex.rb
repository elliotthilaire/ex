require "ex/version"
require "ex/defmodule"

module Ex
  # Your code goes here...
end

require "ex/string"
class String
  def self.pad_leading(*args)
    Ex::String.pad_leading(*args)
  end
end
