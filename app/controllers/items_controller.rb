class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to action: :index
    else
      render :new, status: :unprocessable_entity
    end
  end

  def soft_delete
    @item= Item.find(params[:id])
    @item.soft_delete
    redirect_to action: :index, notice: "Item deleted successfully."
  end
  
  def restore
    @item = Item.find(params[:id])
    @item.restore
    redirect_to action: :index, notice: "Item restored successfully."
  end

  private
    def item_params
      params.require(:item).permit(:name)
    end

end
