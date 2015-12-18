module BasicControl
  extend ActiveSupport::Concern

  def batch_move
    model.any_in(id: params[:ids]).each do |album|
      album.move_to! params[:direction].to_sym
    end

    render json: { success: true }
  end

  def batch_destroy
    render json: {success: model.any_in(id: params[:ids]).destroy_all}
  end

  def move_to
    key = "#{model.to_s.underscore}_id".to_sym
    render json: {data: model.find(params[key]).move_to!(params[:to])}
  end

  def search
    render json: model.search(params[:q])
  end

end
