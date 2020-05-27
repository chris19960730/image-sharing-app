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

  def new_share
    @image = Image.find(params[:id])
  end

  def create_share
    @image = Image.find(params[:id])
    @email = params[:email]
    @messsage = params[:message]

    respond_to do |format|
      if helpers.isEmail(@email[0])
        ImageShareMailer.welcome_email(@image, @email).deliver
        format.html { redirect_to @image, notice: "invitation email has been sent successfully" }
        #flash.now[:notice] = "invitation email has been sent successfully"

      else
        #format.html { redirect_to @image }
        format.js { render "" }
      end
    end

    # if ImageShareMailer.welcome_email(@image, @email).deliver
    #   # ImageShareMailer.with(image: @image, email: @email).welcome_email.deliver_now
    #   flash[:notice] = "invitation email has been sent successfully"
    #   redirect_to root_path
    # else
    #   render "new_share"
    # end
  end
end
