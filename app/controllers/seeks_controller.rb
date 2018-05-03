class SeeksController < ApplicationController
  def create
    @seek = Seek.new(seek_params)
    @seek.user = current_user
    # Store timecontrol in seconds in the databae
    @seek.timecontrol = (seek_params[:timecontrol].to_i * 60).floor
    if @seek.save
      # Seek should up broadcast right after creation
      ActionCable.server.broadcast 'seeks',
                                   add_seek: render_seek(@seek)
      head :ok
    else
      redirect_to 'lobby'
    end
  end

  def destroy
    @seek = Seek.find params[:id]
    ActionCable.server.broadcast 'seeks',
                                 destroy_seek: @seek.id
    @seek.destroy
  end

  private

  def render_seek(seek)
    render partial: 'seek', locals: { seek: seek }
  end

  def seek_params
    params.require(:seek).permit(:timecontrol, :seeklist_id)
  end
end
