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

  private

  def set_tail
    @tail = traverse {}
  end

  def traverse(&block)
    tmp_head = head
    until tmp_head.next_node.nil?
      block.call(tmp_head)
      tmp_head = tmp_head.next_node
    end
    block.call(tmp_head)
    tmp_head
  end
end
