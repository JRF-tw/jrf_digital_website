class RecordsController < ApplicationController
  before_action :set_record, except: [:index, :new]

  def show
    respond_to do |format|
      format.html
      format.json {render :json => {
        status: "success",
        legislator: JSON.parse(@legislator.to_json(
        except: [:description, :now_party_id, :created_at, :updated_at],
        include: {
          party: {except: [:created_at, :updated_at]},
          elections: {
            except: [:created_at, :updated_at],
            include: {ad: {except: [:created_at, :updated_at]}
            }
          },
          interpellations: {}, entries:{}, videos:{}
        }))},
        callback: params[:callback]
      }
    end


    # id = params[:id]
    # if id.to_i.to_s == id
    #   begin
    #     @record = Record.find(id)
    #   rescue
    #     @record = nil
    #   end
    # else
    #   begin
    #     @record = Record.where({identifier: id}).first
    #   rescue
    #     @record = nil
    #   end
    # end
    # if @record
    #   render json: {status: "success", record: filter_record(@record)}
    # else
    #   render json: {status: "failed", error: "not found"}
    # end
  end

  def index
    if params[:format] == "json"
      if params[:query]
        query = "%#{params[:query]}%"
        @records = Record.where("title LIKE ? OR catalog LIKE ? OR content LIKE ?", query, query, query)
          .limit(params[:limit]).offset(params[:offset])
        count = Record.where("title LIKE ? OR catalog LIKE ? OR content LIKE ?", query, query, query).count
      else
        @records = Record.all.limit(params[:limit]).offset(params[:offset])
        count = Record.all.count
      end
    else
      @records = @q.result(:distinct => true).page params[:page]
    end

    set_meta_tags({
      title: '',
      description: '',
      keywords: '',
      og: {
        type: 'website',
        title: '',
        description: ''
      }
    })

    respond_to do |format|
      format.html
      format.json {
        render :json => {
          status: "success", 
          records: filter_records(@records), 
          count: count
        },
        callback: params[:callback]
      }
    end
  end

  private

  def set_record
    @record = params[:id] ? Record.find(params[:id]) : Record.new(record_params)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def record_params
    params.require(:record).permit()
  end

end
