class CardsController < ApplicationController
  def index
    @card = Card.all
  end

  def new
  	@card = Card.new
  end

  def edit
    @card = Card.find(params[:id])
  end
  
  def create
    @card = Card.new(card_params)
    if @card.save
      redirect_to cards_path
    else
      render 'new'
    end
  end

  def update
    @card = Card.find(params[:id])
 
    if @card.update(card_params)
      redirect_to cards_path
    else
      render 'edit'
    end
  end

  def destroy
    @card = Card.find(params[:id])
    @card.destroy
 
    redirect_to cards_path
  end

  def check_card
    input_text = params[:flash_card][:input_text]
    card = Card.find(params[:flash_card][:confirm_id])
    if card[:original_text] == input_text
      card.update_time(Time.now+3.days)
      flash[:notice] = "Верно"
      redirect_to root_path
    else
      flash[:error] = "Ошибка"
      redirect_to root_path
    end
  end

  private
    def card_params
      params.require(:card).permit(:original_text, :translated_text, :review_date)
    end
end
