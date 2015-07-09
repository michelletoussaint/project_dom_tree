
Node = Struct.new(:name, :text, :classes, :id, :children, :parent)

class Parse

  attr_reader :n

  def initialize


  end

  # <html><head><title>



  def read_doc(string)
    stack = []
    regex = /<\w.*?>/
    previous_text =""

    first_tag = string.match(regex).to_s
    stack << first_tag
    puts stack.inspect
    # string = string [first_tag.length...-1]
    previous_text = string.match(regex).pre_match
    string = string.match(regex).post_match
    puts string
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




