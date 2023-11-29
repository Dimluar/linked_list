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
  end

  def prepend(value)
    @head = head.nil? ? @head = Node.new(value) : Node.new(value, head)
    set_tail
    head
  end

  def size
    count = 0
    traverse { count += 1 }
    count
  end

  def at(index)
    traverse { |node, idx| return node if idx == index }
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

  private

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
