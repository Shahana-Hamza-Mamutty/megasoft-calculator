class Operation::SquareRoot < Operator

  def validate_input(input)    
    if input.include?(false) || input.length > 1 || input[0] < 0
      raise 'Invalid input'
    end
  end

  def evaluate(input)
    Math.sqrt(input[0])
  end

end