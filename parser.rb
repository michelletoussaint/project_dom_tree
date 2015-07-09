
Node = Struct.new(:name, :text, :classes, :id, :children, :parent)

class Parse

  attr_reader :n

  def initialize


  end

  def read_doc(string)
    stack = []
    regex = /<\w.*?>/

    first_tag = string.match(regex)
    stack << first_tag

    string = string [first_tag.length...-1]



  end


  def parse_tag(string)
    @n = Node.new
    @n.name = string.match(/<(\w*?)[\s|>]/).captures.first

    @n.text = string.match(/>(.*?)<\//).captures.first
    @n.classes = string.match(/class="(.*?)"/).captures.first.split(" ")
    @n.id = string.match(/id="(.*?)"/).captures.first

  end

end

p = Parse.new
string = '<p class="foo bar class_2" id="baz" >Hello</p>'
string2 = "<html> <head> </head> </html>"

p.read_doc(string2)
p.read_doc(string)




