module Api
  module V1
    class OrdersController < ApplicationController
      def index
        if params[:customer_id].present?
          @orders = Order.where(customer_id: params[:customer_id])
        else
          @orders = Order.all        
        end

        render json: @orders
      end

      def show
        @order = Order.find(params[:id])

        render json: @order
      end

      def ship 
        @order = Order.find(params[:id])

        if @order.update(status: "shipped")
          render json: @order
        else
          render json: @order.errors
        end
      end

    
      def create
        @order= Order.new(customer_id: order_params[:customer_id], status: "pending")

        if @order.save
          render json: @order
        else
          render json: @order.errors
        end
      end

      private

      def order_params
        params.require(:order).permit(:customer_id)
      end


    end
  end
end
