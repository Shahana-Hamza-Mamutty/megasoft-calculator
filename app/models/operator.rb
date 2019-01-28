class Operator < ApplicationRecord

  has_many :operator_usages

	validates :type, :display_sign, :action, presence: true, uniqueness: true
  validates :position, numericality: true, uniqueness: true

  def calculate(input)
    input = parse_input(input)
    validate_input(input)
    result = evaluate(input)
    track_usage(input)
    result
  end

  def parse_input(input)
    input.map{ |val|  (to_integer(val) || to_float(val))}
  end

  def validate_input
    raise NotImplementedError, "validate should be implemented in a sub-class of Operator"
  end

  def track_usage(input)
    count = input.length == 1 ? 1 : (input.length - 1)
    operational_usage = self.operator_usages.find_or_create_by(day: Date.today)
    operational_usage.with_lock do
      operational_usage.usage += count
      operational_usage.save!
    end
  end

  def to_integer(val)
    Integer(val) rescue false
  end

  def to_float(val)
    Float(val) rescue false
  end

end
