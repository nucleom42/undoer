class Object
  def deep_copy!(from)
    return unless from.is_a? self.class
    
    self.instance_variables.each do |instance_var|
      from_instance_var = from.instance_variable_get(instance_var)
      self.instance_variable_set(instance_var, from_instance_var)
    end
    self.class_variables.each do |class_var|
      from_class_val = from.class_variable_get(class_var)
      self.class_variable_set(class_var, from_class_val)
    end
  end
end


