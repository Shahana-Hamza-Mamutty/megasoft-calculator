module Megasoft
  module Admin
	  class OperatorUsagesController < BaseController

      def index
        @operator_usages = OperatorUsage.includes(:operator)
        if params[:start_date].present?
          @start_date = params[:start_date]
          @operator_usages = @operator_usages.where('day >= ?', params[:start_date].to_date)
        end
        if params[:end_date].present?
          @end_date = params[:end_date]
          @operator_usages = @operator_usages.where('day <= ?', params[:end_date].to_date)
        end
        @operator_usages = @operator_usages
                            .order('operator_usages.day desc','operators.position asc')
                            .paginate(page: params[:page], per_page: 10)
      end

      def get_report
        @operator_usages = OperatorUsage.includes(:operator)
        case params[:type]
        when "monthly"
          @operator_usages = @operator_usages.monthly_report
        when "weekly"
          @operator_usages = @operator_usages.weekly_report
        when "daily"
          @operator_usages = @operator_usages.daily_report
        else
        end 
        send_csv(@operator_usages, params[:type])
      end

      private
      # csv
      def send_csv(operator_usages, type)
        csv = OperatorUsage.to_csv(operator_usages)

        file_name = "operator_usages-#{type}-#{Date.today}.csv"

        headers['Content-Type'] = 'text/csv'
        headers['Content-disposition'] = "attachment; filename='#{file_name}'"

        # set streaming headers
        headers['X-Accel-Buffering'] = 'no'
        headers['Cache-Control'] ||= 'no-cache'

        headers.delete('Content-Length')

        # response
        response.status = 200
        self.response_body = csv
      end
	  	
	  end
	end
end