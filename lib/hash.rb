class Hash
  def deep_copy!(from)
    raise ArgumentError unless from.is_a? Hash
    self.each do |h|
      h[1].deep_copy!(from[h[0]]) if h[1].is_a? Hash
      self[h[0]] = from[h[0]]
    end
  end
end
