class ChargesController < ApplicationController
  def new
  end

  def create
  	@amount = 500;

  	Stripe::Token.create({
  	  card: {
  	    number: '4242424242424242',
  	    exp_month: 12,
  	    exp_year: 2021,
  	    cvc: '314',
  	  },
  	})

  	customer = Stripe::Customer.create(
  	email: params[:stripeEmail],
  	#card: card_token,
  	#card: params["card_token"],
   
  	source: params[:tok_visa] 
  	#source: params[:stripeToken]
  	)
	
  	charge = Stripe::Charge.create(
  	customer: customer.id,
  	amount: @amount,
  	description: 'Rails Stripe customer',
  	#card: card_token, 
  	#card: params["card_token"], 
  	currency: 'usd'
  	)

  	# customer = Stripe::Customer.create email: email,
  	#                                    source: card_token

  	# Stripe::Charge.create customer: customer.id,
  	#                       amount: @amount,
  	#                       description: 'Rails Stripe customer',
  	#                       currency: 'usd'



  end
end
