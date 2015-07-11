
Node = Struct.new(:name, :text, :classes, :id, :children, :parent)

class Parse

  attr_reader :root

  def initialize

    file = import_file
    @file_array = convert_to_array(file)
    @root = Node.new("html", nil, nil, nil, [], nil)
    build_tree(@root)

  end


  def import_file

    file = File.open("test.html", "r")
    content = file.read
    file.close
    #delets multiple spaces and new lines
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

    #deletes de <!doctype html>
    string_array[1..-1]

  end


  def build_tree(node)
    node_count = 0

    @file_array[1..-1].each do |tag|

      if tag.include?("</")
        node = node.parent
      elsif tag.include?("<")
        new_node = create_node(tag)
        node_count += 1
        new_node.parent = node
        node.children << new_node
        node = node.children[-1]
      else
        node.text = tag
      end

    end

    puts "Tree fully created with #{node_count} nodes"

  end
    

  def create_node(string)
    node = Node.new
    
    unless string.match(/<(\w*?)[\s|>]/).nil?
      node.name = string.match(/<(\w*?)[\s|>]/).captures.first
    end
    
    unless string.match(/class="(.*?)"/).nil?
      node.classes = string.match(/class="(.*?)"/).captures.first.split(" ")
    end
    
    unless string.match(/id="(.*?)"/).nil?
      node.id = string.match(/id="(.*?)"/).captures.first
    end
    node.children = []
    
    node

  end

end


# Tests
# tree = Parse.new
# puts "The root of the tree is"
# puts " #{tree.root.name}"
# puts "The children of the root is"
# tree.root.children.each {|child| print "#{child.name} ! "}
# puts


