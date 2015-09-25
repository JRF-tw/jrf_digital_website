class Api::RecordsController < ApplicationController
  respond_to :json

  def index
    limit = params[:limit].blank? ? 10 : params[:limit]
    ransack_params = {}
    ransack_params[:title_or_content_cont] = params[:query] if params[:query]
    ransack_params[:date_gt] = params[:date_start] if params[:date_start]
    ransack_params[:date_lt] = params[:date_end] if params[:date_end]
    if ransack_params.blank?
      @records = Record.includes(:category, :carrier, :pattern, :issue, :language, :collector).offset(params[:offset]).limit(limit)
      @records_count = Record.count
    else
      @records = Record.includes(:category, :carrier, :pattern, :issue, :language, :collector).ransack(ransack_params).result(distinct: true)
        .offset(params[:offset]).limit(limit)
      @records_count = Record.ransack(ransack_params).result(distinct: true).count
    end
    respond_with(@records, @records_count)
  end

  def show
    @record = Record.includes(:category, :carrier, :pattern, :issue, :language, :collector).find(params[:id])
    respond_with(@record)
  end
end