require_relative 'parser.rb'

class TreeSearcher

  def initialize(tree)
    @root = tree.root
  end

  def search_ancestors(attribute, value, node)
    attr_value = false
    match_array = []

    until node == nil
      node.each_pair do |member, val|
        if member == attribute
          attr_value = val
        end
      end
      
      if attr_value.is_a?(Array)
        if attr_value.include?(value)
            match_array << node
        end
      else
        if attr_value == value 
          match_array << node
        end
      end
      node = node.parent
    end

    puts "We found #{match_array.length} match(es)"

    match_array.each do |node|
      puts "node: name = '#{node.name}', classes = '#{node.classes}', id = '#{node.id}'"
    end
  end


  def search_children(attribute, value, node = @root)
    stack = []
    stack << node
    match_array = []
    attr_value = false

    until stack.empty?
      node = stack.pop

      unless node.children.empty?
        node.children.each do |child|
          stack<<child

          child.each_pair do |member,val|
            if member == attribute
              attr_value = val
            end
          end

          if attr_value.is_a?(Array)
              if attr_value.include?(value)
                  match_array << child
              end
          else
            if attr_value == value 
              match_array << child
            end
          end
        end
      end
    end

    puts "We found #{match_array.length} match(es)"

    match_array.each do |node|
      puts "node: name = '#{node.name}', classes = '#{node.classes}', id = '#{node.id}'"

    end
  end

end

#Tests
# tree = Parse.new
# search = TreeSearcher.new(tree)
# puts "Search id='main-area'"
# search.search_children(:id, "main-area")
# puts
# puts "Search divs"
# search.search_children(:name, "div")
# puts
# puts "Search class='foo'"
# search.search_children(:classes, "foo")
# puts
# puts "Search html in ancestors"
# puts "Node is #{tree.root.children[-1].children[-1].children[-1].name}"
# search.search_ancestors(:name, "html", tree.root.children[-1].children[-1].children[-1])