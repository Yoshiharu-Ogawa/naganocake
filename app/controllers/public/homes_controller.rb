class Public::HomesController < ApplicationController

  def top
    @items = Item.all
    @item = Item.last(4)
  end

end
