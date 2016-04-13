class CardsController < ApplicationController
  def index
    @card = current_user.cards
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
    misprint = DamerauLevenshtein.distance(card.original_text, input_text)
    if misprint == 0
      card.inc_review_date(true)
      flash[:success] = "Верно"
    elsif misprint == 1      
      flash[:info] = "Опечатка. Ваш ответ #{input_text}, а правильный #{card.original_text}. Перевод #{card.translated_text}"
    else
      card.inc_review_date(false)
      flash[:danger] = "Ошибка"
    end
    redirect_to root_path
  end

  private

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :review_date, :user_id, :card_image, :deck_id, :level, :error_count)
  end
end
