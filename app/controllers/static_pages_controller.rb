class StaticPagesController < ApplicationController
  def index
  	@card = Card.random
  end

  def flash_card
  	confirm_original_text = params[:flash_card][:confirm_original_text]
    card = Card.find(params[:flash_card][:confirm_id])
    if card[:original_text] == confirm_original_text
      card.update(review_date: Date.today.next_day(3))
      flash[:notice] = "Верно"
      redirect_to root_path
    else
      flash[:error] = "Ошибка"
  	  redirect_to root_path
    end
  end
end
