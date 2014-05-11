class GadgetsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_gadget, only: [:destroy]

  def index
    @gadgets = current_user.gadgets
    if params[:search].present?
      @gadgets = @gadgets.where("gadgets.name ILIKE ?", "%#{params[:search]}%")
    end
  end

  def new
    @gadget = current_user.gadgets.build
  end

  def create
    @gadget = current_user.gadgets.build(params[:gadget])
    if @gadget.save
      redirect_to gadgets_url, notice: 'Gadget successfully created.'
    else
      render :new
    end
  end

  def destroy
    @gadget.destroy
    redirect_to gadgets_url, notice: 'Gadget successfully deleted.'
  end

  private

  def load_gadget
    @gadget = current_user.gadgets.find(params[:id])
  end
end
