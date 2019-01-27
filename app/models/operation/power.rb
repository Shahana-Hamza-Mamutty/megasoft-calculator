class Operation::Power < Operator

  def validate_input(input)
    if input.include?(false) || (input.length != 2)
      raise 'Invalid input'
    end
  end

  def evaluate(input)
    (input[0] ** input[1]).to_f
  end

end