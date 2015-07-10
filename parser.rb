
Node = Struct.new(:name, :text, :classes, :id, :children, :parent)

class Parse

  attr_accessor :n, :root, :children

  def initialize

    
    file = import_file
    @array = convert_to_array(file)
    puts @array.inspect
    puts @array[0]
    # @root = create_node(@array[0])
    @root = Node.new("html", nil, nil, nil, [], nil)
    # @root = Node.new()
    puts @root.inspect
    build_tree(@root)

  end

  def build_tree(root)
    count = 0
    #parents weird
    node = root
    parent = node
    @array[1..-1].each do |tag|
      puts tag
      if tag.include?("</")
        node = node.parent
      elsif tag.include?("<")
        node = parent
        new_node = create_node(tag)
        count += 1
        # new_node.parent = node
        node.children << new_node
        node = node.children[-1]
        node.parent = parent
      else
        node.text = tag
      end
      print "new_node"
        puts new_node.inspect
        print "node"
        puts node.inspect
    end
    print "node amount = #{count}\n"
  end
          

  def import_file

    file = File.open("test.html", "r")
    content = file.read
    file.close
    puts content.inspect
    content = content.gsub(/\s+/, " ")


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
    string_array[1..-1]

  end

  def create_node(string)
    n = Node.new
    n.name = string.match(/<(\w*?)[\s|>]/).captures.first

    # @n.text = string.match(/>(.*?)<\//).captures.first
    unless string.match(/class="(.*?)"/).nil?
      n.classes = string.match(/class="(.*?)"/).captures.first.split(" ")
    end
    unless string.match(/id="(.*?)"/).nil?
      n.id = string.match(/id="(.*?)"/).captures.first
    end
    n.children = []
    n

  end

end

# p = Parse.new
# string = '<p class="foo bar class_2" id="baz" >Hello</p>'
# string2 = "<html> <head> <title> This is a test page </title> </head> </html>"

# # p.read_doc(string2)
# p.read_doc(string)




