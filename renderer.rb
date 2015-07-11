require_relative 'parser.rb'

class NodeRender

  def initialize(tree)
    @root = tree.root
    analyzer(@root)
  end

  def analyzer (node)
    stack = []
    stack << node
    node_array = [] #all nodes

    node_attributes(node)

    #Find all internal nodes
    until stack.empty?
      node = stack.pop

      unless node.children.empty?
        node.children.each do |child|
          stack << child
          node_array << child.name
        end
      end
    end

    print_statistics(node_array)

  end


  def print_statistics(array)

    array_uniques = array.uniq

    array_uniques.each do |node|
      puts " - #{node} was found #{array.count(node)} times"
    end

    puts "In total there are #{array.length} nodes inside."

  end


  def node_attributes(node)
    puts "The node you are analyzing is #{node.name}, class = '#{node.classes}' and id = '#{node.id}'."
  end
end

#Tests
# tree = Parse.new
# r = NodeRender.new(tree)


