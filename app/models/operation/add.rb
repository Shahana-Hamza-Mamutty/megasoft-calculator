class Operation::Add < Operator

  def validate_input(input)
    if input.include?(false)
      raise 'Invalid input'
    end
  end

  def evaluate(input)
    input.inject(:+)
  end

end