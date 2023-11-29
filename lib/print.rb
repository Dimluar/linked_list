# frozen_string_literal: true

# Puts strings
module Print
  def empty_list
    puts "\nList is already empty."
    nil
  end

  def exceeded_index(offset = 0)
    puts "\nIndex it's out of limits: #{size - offset} max."
    return nil if offset == 1

    self
  end
end
