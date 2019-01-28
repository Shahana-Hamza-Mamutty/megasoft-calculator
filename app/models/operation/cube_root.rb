class Operation::CubeRoot < Operator

  def validate_input(input)    
    if input.include?(false) || input.length > 1 || (input.length == 0)
      raise 'Invalid input'
    end
  end

  def evaluate(input)
    Math.cbrt(input[0])
  end

end