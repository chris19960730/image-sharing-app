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
end
