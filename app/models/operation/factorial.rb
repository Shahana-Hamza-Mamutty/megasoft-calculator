class Operation::Factorial < Operator

  def validate_input(input)    
    if input.include?(false) || input.length > 1 || input[0] < 0
      raise 'Invalid input'
    end
  end

  def evaluate(input)
    input[0] == 0 ? 1 : Math.gamma(input[0]+1)
  end

end