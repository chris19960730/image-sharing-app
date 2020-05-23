class TagsController < ApplicationController
  def show
    tag_name = params[:id]

    @tag = tag_name
    @filtered_images = Image.tagged_with([tag_name], :any => true)

    if !@filtered_images.empty?
      flash[:notice] = "Images was filtered successfully"
    else
      flash[:alert] = "There is no such tag in our system"

      redirect_to root_path
    end
  end
end
