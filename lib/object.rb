class Object
  def deep_copy!(from)
    self.instance_variables.each do |instance_var|
      from_instance_var = from.instance_variable_get(instance_var)
      self.instance_variable_set(instance_var, from_instance_var)
    end
  end
end
