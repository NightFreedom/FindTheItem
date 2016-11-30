class TransactionsController < ApplicationController
    before_action :authenticate_user!, only: [:destroy, :index]
    def show
        @transaction=Transaction.find(params[:id])
        @items=Item.all
    end
    def index
        @transactions=Transaction.all
        @items=Item.all
    end
    def new
        @item=Item.find(params[:item_id])
    end
    def create
        @item=Item.find(params[:item_id])
        transactions=@item.transactions

        @transaction=Transaction.new(transaction_params)
        @transaction.item_id=@item.id
        @transaction.save

        if transactions.empty?
            #@transaction.duration=0
        else
            previous_transaction=transactions.first.created_at
            new_transaction=@transaction.created_at
            seconds=(new_transaction - previous_transaction)
            @transaction.duration=seconds
        end

        @transaction.save

        @item.elapsed += @transaction.duration.to_f

        @item.save

        redirect_to transaction_path(@transaction)
    end
    def destroy
        @transaction=Transaction.find(params[:id])
        @transaction.destroy
        redirect_to transactions_path
    end
    def edit
    end
    def update
    end
    def transaction_params
        params.require(:transaction).permit(:place_name, :process, :company)
    end
end
