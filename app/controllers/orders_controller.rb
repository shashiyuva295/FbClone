class OrdersController < ApplicationController
	skip_before_action :verify_authenticity_token
	before_action :paypal_init, :except => [:index]

	def index 
	
	end

	def create_order
	  # PAYPAL CREATE ORDER

	  require 'paypal-sdk-rest'
	  include PayPal::SDK::REST

	  PayPal::SDK::REST.set_config(
	    :mode => "sandbox", # "sandbox" or "live"
	    :client_id => "EBWKjlELKMYqRNQ6sYvFo64FtaRLRR5BdHEESmha49TM",
	    :client_secret => "EO422dn3gQLgDbuwqTjzrFgFtaRLRR5BdHEESmha49TM")

	  # Build Payment object
	  @order = Order.new({
	    :intent =>  "sale",
	    :payer =>  {
	      :payment_method =>  "paypal" },
	    :redirect_urls => {
	      :return_url => "http://localhost:3000/order/create_order",
	      :cancel_url => "http://localhost:3000" },
	    :transactions =>  [{
	      :item_list => {
	        :items => [{
	          :name => "item",
	          :sku => "item",
	          :price => "5",
	          :currency => "USD",
	          :quantity => 1 }]},
	      :amount =>  {
	        :total =>  "5",
	        :currency =>  "USD" },
	      :description =>  "This is the payment transaction description." }]})

	  if @order.create
	    @order.id     # Payment Id
	  else
	    @order.error  # Error Hash
	  end

	  # price = '100.00'
	  #   request = PayPalCheckoutSdk::Orders::OrdersCreateRequest::new
	  #   request.request_body({
	  #     :intent => 'CAPTURE',
	  #     :purchase_units => [
	  #       {
	  #         :amount => {
	  #           :currency_code => 'USD',
	  #           :value => price
	  #         }
	  #       }
	  #     ]
	  #   })
	  #   begin
	  #     response = @client.execute request
	  #     order = Order.new
	  #     order.price = price.to_i
	  #     order.token = response.result.id
	  #     if order.save
	  #       return render :json => {:token => response.result.id}, :status => :ok
	  #     end
	  #   rescue PayPalHttp::HttpError => ioe
	  #     # HANDLE THE ERROR
	  #   end


	end
	
	def capture_order
	  # PAYPAL CAPTURE ORDER

	  request = PayPalCheckoutSdk::Orders::OrdersCaptureRequest::new params[:order_id]
	  begin
	    response = @client.execute request
	    order = Order.find_by :token => params[:order_id]
	    order.paid = response.result.status == 'COMPLETED'
	    if order.save
	      return render :json => {:status => response.result.status}, :status => :ok
	    end
	  rescue PayPalHttp::HttpError => ioe
	    # HANDLE THE ERROR
	  end


	end

	private
	  
	  def paypal_init
	    client_id = 'EBWKjlELKMYqRNQ6sYvFo64FtaRLRR5BdHEESmha49TM'
	    client_secret = 'EO422dn3gQLgDbuwqTjzrFgFtaRLRR5BdHEESmha49TM'
	    environment = PayPal::SandboxEnvironment.new client_id, client_secret
	    @client = PayPal::PayPalHttpClient.new environment
	  end
end
