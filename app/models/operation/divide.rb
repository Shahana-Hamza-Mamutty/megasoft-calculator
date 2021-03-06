class Operation::Divide < Operator

  def validate_input(input)
    if input.include?(false) || (input.length != 2) || (input[1] == 0)
      raise 'Invalid input'
    end
  end

  def evaluate(input)
    input[0].to_f/input[1]
  end

end