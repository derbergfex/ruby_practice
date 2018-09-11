class LinkedList

    def initialize
        @list =[]
    end

    def append(value = nil)
        @list << Node.new(value)
        @list[-2].next_node = @list[-1] if @list.length != 1
    end

    def prepend(value = nil)
        @list.unshift(Node.new(value))
        @list[0].next_node = @list[1] if @list.length != 1
    end

    def size
        @list.length
    end

    def head
        @list[0]
    end

    def tail
        @list[1]
    end

    def at(ind)
        @list[ind]
    end

    def pop
        @list.pop
    end
    
    def contains?(value = nil)
        @list.each do |node|
            return true if node.value == value
        end
        false
    end

    def find(value = nil)
        @list.each_with_index do |node, index|
            return index if node.value == value
        end
        nil
    end

    def to_s
        @list.each_with_index do |node, index|
            puts "( #{node.value} )" if @list[-1] == node
            print "( #{node.value} ) -> " if @list[-1] != node
        end
    end

    def insert_at(index, value = nil)
        @list.insert(index, Node.new(value))
        @list[index - 1].next_node = @list[index]
    end

    def remove_at(index)
        @list[index - 1].next_node = @list[index + 1]
        @list.delete_at(index)
    end
end

class Node
    attr_accessor :value, :next_node

    def initialize(value = nil)
        @value = value
        @next_node = nil
    end
end


my_list = LinkedList.new

my_list.append("A")
my_list.append("B")
puts "#find: "
puts my_list.find("B")
puts ""
puts "#head.next_node.value: "
puts my_list.head.next_node.value
puts ""
puts "#to_s: "
my_list.to_s
puts ""
puts "prepending 'C': "
my_list.prepend("C")
puts ""
puts "#to_s post prepend: "
my_list.to_s
puts ""
puts "#contains?('C'): "
puts my_list.contains?("C")
puts ""
puts "#inset_at(1, 'D'): "
my_list.insert_at(1, "D")
puts "to_s: "
my_list.to_s
puts ""
puts "#remove_at(1): "
my_list.remove_at(1)
puts "to_s: "
my_list.to_s
puts ""