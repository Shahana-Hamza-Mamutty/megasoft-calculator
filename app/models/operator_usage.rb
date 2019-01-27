require 'csv'
class OperatorUsage < ApplicationRecord

	belongs_to :operator

  def self.monthly_report(mon = Date.today.month)
    self.where('extract(month from day) = ?', mon)
  end

  def self.weekly_report
    self.where('day >= ? and day <= ?', Date.today.beginning_of_week, Date.today.end_of_week)
  end

  def self.daily_report
    self.where('day = ?', Date.today)
  end

  def self.to_csv(operator_usages)
    Enumerator.new do |response_csv|
      response_csv << CSV.generate_line(%w[operator count date])
      operator_usages.each do |ou|
        response_csv << CSV.generate_line([ou.operator.display_sign, ou.usage, ou.day]) 
      end
    end
  end

end
