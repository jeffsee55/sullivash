class Stylesheet < ActiveRecord::Base
  serialize :variables, JSON

  def to_sass
    variables.each_pair.map do |name, value|
      "$#{name}: #{value}"
    end.join("\n")
  end
end
