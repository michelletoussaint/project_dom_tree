
Node = Struct.new(:name, :text, :classes, :id, :children, :parent)

class Parse

  attr_reader :n

  def initialize

    file = import_file
    convert_to_array(file)

  end

  def import_file

    file = File.open("test.html", "r")
    content = file.read
    file.close
    puts content.inspect
    content

  end


  def convert_to_array(string)
    string_array = []
    regex = /<.*?>/

    until !string.match(regex)

      tag = string.match(regex).to_s
      # puts "Tag is #{tag}"
      previous_text = string.match(regex).pre_match
      # puts "Text before is #{previous_text}"
      string = string.match(regex).post_match
      # puts "Text after is #{string}"

      unless previous_text.empty? || previous_text == " "
        string_array << previous_text
      end
      string_array << tag

    end

    puts string_array.inspect

  end

  def parse_tag(string)
    @n = Node.new
    @n.name = string.match(/<(\w*?)[\s|>]/).captures.first

    @n.text = string.match(/>(.*?)<\//).captures.first
    @n.classes = string.match(/class="(.*?)"/).captures.first.split(" ")
    @n.id = string.match(/id="(.*?)"/).captures.first

  end

end

# p = Parse.new
# string = '<p class="foo bar class_2" id="baz" >Hello</p>'
# string2 = "<html> <head> <title> This is a test page </title> </head> </html>"

# # p.read_doc(string2)
# p.read_doc(string)




