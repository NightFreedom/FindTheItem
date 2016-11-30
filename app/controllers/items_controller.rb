require 'socket'

class ItemsController < ApplicationController
    before_action :authenticate_user!, only: [:qrcode]
    def show
        @item=Item.find(params[:id])
        respond_to do |format|
            format.html
            format.json {render :json => @item.to_json}
        end
    end
    def index
        @items=Item.all
    end
    def new
    end
    def create
        @item=Item.new(item_params)
        @item.date_time=@item.created_at
        @item.owner=current_user.email
        @item.elapsed=0
        @item.save

        uploaded_io=params[:item][:picture]
        File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
            file.write(uploaded_io.read)
            @item.image_path = "/uploads"
            @item.image_name = uploaded_io.original_filename
            @item.save
        end

        #redirect_to items_path
        redirect_to new_transaction_path(item_id: @item.id)
    end
    def destroy
        @item=Item.find(params[:id])
        @item.destroy
        redirect_to user_path(current_user.id)
    end
    def edit
    end
    def update
    end
    def item_params
        params.require(:item).permit(:name, :date_time, :description)
    end
    def qrcode
        @item=Item.find(params[:id])
        @ip=Socket.ip_address_list.detect(&:ipv4_private?).try(:ip_address)
        url="http://#{@ip}:3000/items/#{@item.id}.json"
        @qr=RQRCode::QRCode.new(url)
    end
end
