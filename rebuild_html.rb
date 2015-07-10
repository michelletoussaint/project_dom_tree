class Rebuild 

  def initialize(tree)
    @tree = tree
  end

  def rebuild
    node = @tree.root
    html = ""
    stack = []
    stack << node
    close_tag_array = []


    until stack.empty? 
      
      node = stack.shift

      html << create_opening_tag(node)
      close_tag_array << node
      
      if !node.children.empty? #has children
        
        (children.length-1).downto(0) do |index|        
          stack.unshift(node.children[index])
        end

      else

        html << create_closing_tag(node)
        close_tag_array.pop

      end
    end

  end

  def create_opening_tag(node)

    string = ""

    string << "<" + node.name

    unless node.classes == nil
        string <<' class="'
      node.classes.each do |c|
        string << c +" "
      end
      string << '"'
    end

    unless node.id == nil
      string << ' id="' + node.id +'"'
    end

    string << ">"

  end

  def create_closing_tag(node)

    string = "</" + node.name + ">"
  
  end


end