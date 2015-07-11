require_relative 'parser.rb'

class Rebuild 

  def initialize(tree)
    @tree = tree
    html = rebuild(@tree.root)
    output(html)
  end

  def rebuild(node)
    html = "<!doctype html>\n"
    stack = []
    stack << node

    until stack.empty? 
      node = stack.pop

      html << create_opening_tag(node) + "\n"
      html << add_text(node) + "\n"
      
      if !node.children.empty? #has children
        #add children to stack 
        (node.children.length-1).downto(0) do |index|   
          stack << node.children[index]
        end

      else #close tags
        #calculate de difference in depth between the current node and the next item in the stack
        difference_in_depth = d_i_d(node, stack)

        #if it's a sibling just close current tag
        if difference_in_depth == 0
          html << create_closing_tag(node) + "\n"
        else #close all tags until you reach the same depth
          (difference_in_depth + 1).times do 
            unless node == nil
              html << create_closing_tag(node) + "\n"
              node = node.parent
            end
          end
        end

      end 

    end

    puts "Final HTML: #{html}"
    html
    
  end

  def output(string)
    File.open("output.html", 'w') { |file| file.write(string) }
  end


  def add_text(node)
    if node.text == nil
      return ""
    else
       return node.text + " "
    end
  end


  def create_opening_tag(node)

    string = "<" + node.name
    #add classes
    unless node.classes == nil
        string << ' class="'
      node.classes.each do |c|
        string << c + " "
      end
      string << '"'
    end
    #add id
    unless node.id == nil
      string << ' id="' + node.id + '"'
    end
    string << "> "

  end


  def create_closing_tag(node)
    "</" + node.name + "> "
  end

  def d_i_d(node, stack)

    current_node_depth = depth(node)

    if stack.empty?
      future_node_depth = 1
    else
      future_node_depth = depth(stack[-1])
    end

    return (current_node_depth - future_node_depth)

  end


  def depth(node)
    depth = 0
    until node == nil
      depth +=1
      node = node.parent
    end
    depth
  end

end

tree = Parse.new
Rebuild.new(tree)


#ADD the doctype!!!
