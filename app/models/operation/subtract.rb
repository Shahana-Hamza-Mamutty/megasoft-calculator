class Operation::Subtract < Operator

  def validate_input(input)
    input  = input.map{ |val|  (to_integer(val) || to_float(val))}
    
    if input.include?(false) || input.length > 2
      raise 'Invalid input'
    end
  end

  def evaluate(input)
    input[0] - input[1]
  end

end