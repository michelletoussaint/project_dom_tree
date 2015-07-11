require_relative 'parser.rb'

class Rebuild 

  def initialize(tree)
    @tree = tree
    rebuild(@tree.root)
  end

  def depth(node)
    depth = 0
    # puts "node: #{node.name} "
    until node == nil
      depth +=1
      node = node.parent
    end
    puts " depth is : #{depth} "
    depth
  end

  def rebuild(node)
    # node = node
    html = ""
    stack = []
    tags_to_close =[]
    stack << node

    until stack.empty? 
      puts "stack lenght #{stack.length}"

      node = stack.pop
      #check depth and close all needed
      #check tags_to_close and close them all

      puts "node: #{node.name}\n\n"


      html << create_opening_tag(node)
      if node.text != nil
        html << " " + node.text + " "
      end
      tags_to_close << node
      
      print "html before close_tag: #{html} and stack length = #{stack.length}\n\n\n\n"

      if !node.children.empty? #has children
        
        (node.children.length-1).downto(0) do |index|        
          stack << node.children[index]
          # puts "Adding child #{node.children[index].name}"

        end
      else
        current_node_depth = depth(node)
        print " cuurent node: #{node.name} "
        if stack.empty?
          future_node_depth = 1
        else
          future_node_depth = depth(stack[-1])
        end
        # print " future node = #{stack[-1].name} "
        depth_levels = current_node_depth - future_node_depth
        print " depth levels: #{depth_levels} "
        if depth_levels == 0
          html << create_closing_tag(node)
        else
          # print "hihihihih"
          (depth_levels+1).times do 
            if node == nil
              # html<<"stuff happened!"
            else
            # html << create_closing_tag(tags_to_close.pop)
              print "node name: #{node.name}"
              html << create_closing_tag(node)
              node = node.parent
            end
          end
        end
      end 
      # else
        
      #   html << create_closing_tag(node)
      
      #   print "html after close_tag: #{html} and stack length = #{stack.length}\n\n\n\n"

      #   if stack.length == 1 
      #     # print " Printing closing tag "
      #     html << create_closing_tag(node.parent)
      #   elsif stack.length == 0
      #     print " stack: #{stack.inspect}  "
      #     print " node: #{node.name}   "
      #     node = node.parent
      #     until node.parent == nil
      #       # print " Backing out of node "
      #       node = node.parent
      #       html << create_closing_tag(node)
      #     end
      #   end
        # end
    end
    print "final html: #{html}\n\n\n"
    html
    output(html)
  end

  def output(string)
    File.open("output.html", 'w') { |file| file.write(string) }
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

tree = Parse.new
r = Rebuild.new(tree)





  # def rebuild(node)
  #   # node = node
  #   html = ""
  #   stack = []
  #   stack << node

  #   sibling_counter = 1
  #   until stack.empty? 
  #     puts "stack: #{stack.inspect} and #{stack.length}"

  #     node = stack.shift
  #     # puts node.inspect
  #     puts "node: #{node.name}\n\n"
  #     sibling_counter -= 1

  #     puts sibling_counter

  #     html << create_opening_tag(node)
      
  #     if !node.children.empty? #has children
        
  #       (node.children.length-1).downto(0) do |index|        
  #         stack.unshift(node.children[index])
  #         sibling_counter += 1
  #       end

  #     else
  #       print "html: #{html} and sibCount = #{sibling_counter}\n\n\n\n"

  #       html << create_closing_tag(node)
  #       # sibling_counter -= 1
  #       print "html: #{html} and sibCount = #{sibling_counter}\n\n\n\n"

  #       if sibling_counter == 1
  #         # add create_closing_tag to node.parent
  #         print " Printing closing tag "
  #         html << create_closing_tag(node.parent)
  #       elsif sibling_counter == 0
  #         print " stack: #{stack.inspect}  "
  #         print " node: #{node.name}   "
  #         node = node.parent
  #         until node.parent == nil
  #           print " Backing out of node "
  #           node = node.parent
  #           html << create_closing_tag(node)
  #         end
  #       end
  #       # end
  #     end
  #   end
  #   print "final html: #{html}\n\n\n"
  # end
