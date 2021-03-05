class String
  def deep_copy!(from)
    self.gsub!(self, from)
  end
end