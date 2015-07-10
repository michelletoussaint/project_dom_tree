
Node = Struct.new(:name, :text, :classes, :id, :children, :parent)

class Parse

  attr_accessor :root

  def initialize

    file = import_file
    @array = convert_to_array(file)
    @root = Node.new("html", nil, nil, nil, [], nil)
    build_tree(@root)

  end

  def build_tree(root)
    count = 0
    node = root
    parent = root

    @array[1..-1].each do |tag|
      # puts tag
      if tag.include?("</")
        # print "was in node #{node}"
        node = node.parent
        # print " and now and node #{node}\n"
      elsif tag.include?("<")
        new_node = create_node(tag)
        count += 1
        new_node.parent = node
        node.children << new_node
        node = node.children[-1]
      else
        node.text = tag
      end

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
    
    unless string.match(/<(\w*?)[\s|>]/).nil?
      n.name = string.match(/<(\w*?)[\s|>]/).captures.first
    end
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

class NodeRender

  def initialize(tree)
    @tree = tree
  end

  def render(node = @tree.root)
    stack = []
    stack << node
    count_array = []
    name_arr = []

    print "Node Attributes: name = #{node.name}, classes = #{node.classes}, id = #{node.id}, parent = #{node.parent.name}\n"

    until stack.empty?
      node = stack.pop

      unless node.children.empty?
        node.children.each do |child|
          stack<<child
          count_array<<child
          name_arr << child.name
        end
      end
    end

    uniq_arr = name_arr.uniq
    uniq_arr.each do |thing|
      print "#{thing} was found #{name_arr.count(thing)} times\n"
      # print "#{thing.name}\n"
    end
    print "#{count_array.length}\n"

  end
end

class TreeSearcher

  attr_accessor :attribute

  def initialize(tree)
    @tree = tree
  end

  def search_children(some_node, attribute, value)
    search_by(attribute, value, some_node)
  end

  def search_ancestors(node, attribute, value)
    mem_value = false
    match_array = []

    until node == nil
      node.each_pair do |member, val|
        if member == attribute
          mem_value = val
        end
      end
      
      if mem_value.is_a?(Array)
        if mem_value.include?(value)
            match_array << node
        end
      else
        if mem_value == value 
          match_array << node
        end
      end
      node = node.parent
    end

    puts "We found #{match_array.length} match(es)"

    match_array.each do |node|
      puts "node: name - #{node.name}, classes - #{node.classes}, id - #{node.id}"
    end
  end


  def search_by(attribute, value, node = @tree.root)
    stack = []
    stack << node
    match_array = []
    mem_value = false

    until stack.empty?
      node = stack.pop

      unless node.children.empty?
        node.children.each do |child|
          stack<<child

          child.each_pair do |member,val|
            if member == attribute
              mem_value = val
            end
          end

          if mem_value.is_a?(Array)
              if mem_value.include?(value)
                  match_array << child
              end
          else
            if mem_value == value 
              match_array << child
            end
          end

        end
      end
    end

    puts "We found #{match_array.length} match(es)"

    match_array.each do |node|
      puts "node: name - #{node.name}, classes - #{node.classes}, id - #{node.id}"
    end

  end

end

# tree = Parse.new
# r = NodeRender.new(tree)
# r.render(tree.root.children[0])

# search = TreeSearcher.new(tree)
# search.search_by(:id, "main-area")
# search.search_by(:name, "div")
# search.search_by(:classes, "foo")
# search.search_ancestors(tree.root.children[-1].children[-1].children[-1],:name, "html" )



