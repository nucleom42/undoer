class Array
  def deep_copy!(from)
    raise ArgumentError unless from.is_a? Array
    self.each_with_index do |item, index|
      item.deep_copy!(from[index]) if item.is_a? Array
      self[index] = from[index]
    end
  end
end

