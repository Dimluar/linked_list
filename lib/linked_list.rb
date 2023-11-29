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

  private

  def set_tail
    tmp_head = head
    tmp_head = tmp_head.next_node until tmp_head.next_node.nil?
    @tail = tmp_head
  end
end
