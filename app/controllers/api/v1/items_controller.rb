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
    item = Item.new amount:params[:amount], user_id: params[:user_id], notes: params[:notes]
    if item.save
      render json: {resource: item}
    else
      render json: {errors: item.errors}
    end
  end
  def search
    items = Item.find_by_sql("SELECT * FROM items WHERE notes LIKE '%"+params[:keyword]+"%'")
    render json: {resources: items}
  end

end
