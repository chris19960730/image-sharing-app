# frozen_string_literal: true

class ImagesController < ApplicationController
  def new
    @image = Image.new
  end

  def show
    @image = Image.find(params[:id])
  end

  def create
    @image = Image.new(name: params[:image][:name], url: params[:image][:url])
    @image.tag_list = params[:image][:tag_list]

    if @image.save
      flash[:notice] = "Image was posted successfully"
      redirect_to @image
    else
      render "new"
    end
  end

  def destroy
    @image = Image.find(params[:id])
    @image.destroy
    render js { partial :home / images_index }
    flash[:notice] = "Image #{@image.name} was deleted successfully"
    redirect_to root_path
  end

  def edit
    @image = Image.find(params[:id])
  end

  def update
    @image = Image.find(params[:id])
    if @image.update(params.require(:image).permit(:name, :url, :tag_list))
      flash[:notice] = "Image was updated successfully"
      redirect_to image_path(@image)
    else
      flash[:alert] = "Image can't be updated!"
      render "edit"
    end
  end
end
