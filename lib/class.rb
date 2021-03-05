class Class
  def deep_copy!(from)
    self.class_variables.each do |class_var|
      from_class_val = from.class_variable_get(class_var)
      self.class_variable_set(class_var, from_class_val)
    end
  end
end