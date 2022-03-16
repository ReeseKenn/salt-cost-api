class Api::V1::ItemsController < ApplicationController
  def index 
    items = Item.page(params[:page]).per(params[:page_size])
    render json: { resources: items, pager: {
      page: params[:page],
      per_page: params[:page_size],
      count: Item.count
    }}
  end
  def create
    item = Item.new amount:1
    if item.save
      render json: {resource: item}
    else
      render json: {errors: item.errors}
    end
  end

end
