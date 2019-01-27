class Operation::CubeRoot < Operator

  def validate_input(input)
    input  = input.map{ |val|  (to_integer(val) || to_float(val))}
    
    if input.include?(false) || input.length > 1 || (input.length == 0)
      raise 'Invalid input'
    end
  end

  def evaluate(input)
    Math.cbrt(input[0])
  end

end