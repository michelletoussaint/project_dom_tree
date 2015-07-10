require_relative 'parser.rb'

class Rebuild 

  def initialize(tree)
    @tree = tree
    rebuild(@tree.root)
  end

  def rebuild(node)
    # node = node
    html = ""
    stack = []
    stack << node

    sibling_counter = 1
    until stack.empty? 
      puts "stack: #{stack.inspect} and #{stack.length}"

      node = stack.shift
      # puts node.inspect
      puts "node: #{node.name}\n\n"
      sibling_counter -= 1

      puts sibling_counter

      html << create_opening_tag(node)
      
      if !node.children.empty? #has children
        
        (node.children.length-1).downto(0) do |index|        
          stack.unshift(node.children[index])
          sibling_counter += 1
        end

      else
        print "html: #{html} and sibCount = #{sibling_counter}\n\n\n\n"

        html << create_closing_tag(node)
        # sibling_counter -= 1
        print "html: #{html} and sibCount = #{sibling_counter}\n\n\n\n"

        if sibling_counter < 2  && sibling_counter>0
          # add create_closing_tag to node.parent
          print " Printing closing tag "
          html << create_closing_tag(node.parent)
        end
        if sibling_counter <1
          print " stack: #{stack.inspect}  "
          print " node: #{node.name}   "
          node = node.parent
          until node.parent == nil
            print " Backing out of node "
            node = node.parent
            html << create_closing_tag(node)
          end
        end
        # end
      end
    end
    print "final html: #{html}\n\n\n"
  end

  def create_opening_tag(node)

    string = ""

    string << "<" + node.name

    unless node.classes == nil
        string << ' class="'
      node.classes.each do |c|
        string << c + " "
      end
      string << '"'
    end

    unless node.id == nil
      string << ' id="' + node.id + '"'
    end

    string << "> "

  end

  def create_closing_tag(node)

    string = "</" + node.name + "> "
  
  end


end