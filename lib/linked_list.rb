# frozen_string_literal: true

require_relative 'node'

# Linked list data structure
class LinkedList
  attr_reader :head, :tail

  def initialize
    @head = nil
    @tail = nil
  end

  def append(value)
    return prepend(value) if head.nil?

    tmp_tail = tail
    @tail = Node.new(value)
    tmp_tail.next_node = tail
    self
  end

  def prepend(value)
    @head = head.nil? ? @head = Node.new(value) : Node.new(value, head)
    set_tail
    self
  end

  def size
    return 0 if head.nil?

    count = 0
    traverse { count += 1 }
    count
  end

  def at(index)
    return nil if size.zero? || index >= size

    traverse { |node, idx| return node if idx == index }
    nil
  end

  def pop
    traverse do |node|
      if node.next_node == tail
        tmp_tail = tail
        node.next_node = nil
        @tail = node
        return tmp_tail
      end
    end
  end

  def contains?(value)
    traverse do |node|
      return true if node.value == value
    end
    false
  end

  def find(value)
    traverse do |node, index|
      return index if node.value == value
    end
    nil
  end

  def to_s
    string = ''
    traverse { |node| string += "( #{node.value} ) -> " }
    string << 'nil'
  end

  def insert_at(value, index)
    return exceeded_index if index > size
    return append(value) if index == size || size.zero?

    traverse do |node, idx|
      if index == idx + 1
        node.next_node = Node.new(value, node.next_node)
        return self
      end
    end
  end

  def remove_at(index)
    return empty_list if size.zero?
    return exceeded_index(1) if index >= size
    return pop if index == size - 1

    traverse do |node, idx|
      if index == idx + 1
        tmp_node = node.next_node
        node.next_node = tmp_node.next_node
        return tmp_node.value
      end
    end
  end

  private

  def empty_list
    puts "\nList is already empty."
    nil
  end

  def exceeded_index(offset = 0)
    puts "\nIndex it's out of limits: #{size - offset} max."
    return nil if offset == 1

    self
  end

  def set_tail
    @tail = traverse {}
  end

  def traverse(&block)
    tmp_head = head
    index = 0
    until tmp_head.next_node.nil?
      block.call(tmp_head, index)
      index += 1
      tmp_head = tmp_head.next_node
    end
    block.call(tmp_head)
    tmp_head
  end
end
