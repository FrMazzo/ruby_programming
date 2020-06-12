class Node
  attr_accessor :value, :next

  def initialize(value)
    @value = value
    @next = nil
  end

end

class LinkedList
  attr_accessor :head, :tail

  def initialize
    @head = nil
    @tail = nil
  end

  def prepend(value)
    new_node = Node.new(value)

    if @head 
      new_node.next = @head
      @head = new_node
    else
      @head = new_node
      @tail = new_node
    end

  end

  def append(value)
    new_node = Node.new(value)

    if @head 
      @tail.next = new_node
      @tail = new_node
    else
      @head = new_node
      @tail = new_node
    end

  end

  def size
    length = 0
    current = @head

    while current
      length += 1
      current = current.next
    end

    length
  end

  def head
    @head.value
  end
  
  def tail
    @tail.value
  end

  def at(id)
    current = @head

    id.times do
      current = current.next
    end

    current.value
  end

  def pop
    current = @head
    popped = nil

    while current
      unless current.next.next
        popped = current.next.value
        current.next = nil
        @tail = current
      end
      current = current.next
    end

    popped
  end

  def contains?(value)
    current = @head
    while current
      return true if current.value == value
      current = current.next
    end

    return false
  end
  
  def find(value)
    current = @head
    id = 0

    while current
      return id if current.value == value
      current = current.next
      id += 1
    end

    return nil
  end

  def insert_at(value, id)
    current = @head
    current_id = 0

    new_node = Node.new(value)

    return self.prepend(value) if id == 0

    while current

      if current_id == id - 1
        new_node.next = current.next
        current.next = new_node
        return
      end

      current = current.next
      current_id += 1
    end
  end

  def remove_at(id)
    current = @head
    current_id = 0

    while current

      if current_id == id - 1
        current.next = current.next.next
        return
      end

      current = current.next
      current_id += 1
    end
  end

  def to_s
    string = ""
    current = @head

    while current
      string += "(#{current.value}) -> "
      current = current.next
    end

    string += "nil"
  end
end

list = LinkedList.new
list.prepend(101)
list.prepend(102)
list.prepend(103)
list.prepend(104)
list.append(901)
list.append(902)
list.append(903)


puts list.to_s

list.remove_at(3)

puts list.to_s

p list.find(5)
p list.find(901)