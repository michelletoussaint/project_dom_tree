
Node = Struct.new(:name, :text, :classes, :id, :children, :parent)

class Parse

  def initialize()
  end


  def parse_tag(string)
  end

end

string = "<p class = 'foo bar' id='baz' >Hello</p>"
regex = /p/
our 