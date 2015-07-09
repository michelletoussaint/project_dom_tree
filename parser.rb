
Node = Struct.new(:name, :text, :classes, :id, :children, :parent)

class Parse

  attr_reader :n

  def initialize


  end


  def parse_tag(string)
    @n = Node.new
    @n.name = string.match(/<(.*?)\s/).captures.first
    @n.text = string.match(/>(.*?)<\//).captures.first
    @n.classes = string.match(/class="(.*?)"/).captures.first.split(" ")
    @n.id = string.match(/id="(.*?)"/).captures.first

  end

end

p = Parse.new
string = '<p class="foo bar class_2" id="baz" >Hello</p>'
p.parse_tag(string)
puts p.n