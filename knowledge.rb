# module for metakoans.rb
def attribute(attr_values, &block)
  @attr_values = {}

  if attr_values.is_a?(Hash)
    @attr_values[attr_values.keys[0]] = attr_values.values[0]
  else
    @attr_values[attr_values] = nil
  end

  @attr_values.each do |attribute, value|
    define_method "#{attribute}=" do |attr|
      instance_variable_set("@#{attribute}", attr)
    end

    define_method attribute.to_s do
      unless instance_variable_defined?("@#{attribute}")
        if block_given?
          instance_variable_set("@#{attribute}", instance_eval(&block))
        end
        instance_variable_set("@#{attribute}", value) if value
      end
      instance_variable_get("@#{attribute}")
    end

    define_method "#{attribute}?" do
      instance_variable_get("@#{attribute}").nil? ? false : true
    end
  end
end
