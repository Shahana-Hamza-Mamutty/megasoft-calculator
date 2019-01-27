class Operation::Add < Operator

  def validate_input(input)
    input  = input.map{ |val|  (to_integer(val) || to_float(val))}
    if input.include?(false)
      raise 'Invalid input'
    end
  end

  def evaluate(input)
    input.inject(:+)
  end

end