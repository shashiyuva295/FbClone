class ChargesController < ApplicationController
  def new
  end

  def create
  	@amount = 500

  	  customer = Stripe::Customer.create(
  	    email: params[:stripeEmail],
  	    #card: card_token,
  	    #source: params[:stripeToken]
  	    source: params[:tok_visa]
  	  )

  	  charge = Stripe::Charge.create(
  	    customer: customer.id,
  	    amount: @amount,
  	    description: 'Rails Stripe customer',
  	    #card: card_token,
  	    currency: 'usd'
  	  )
  end
end
