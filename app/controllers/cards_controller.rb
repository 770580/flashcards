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
    @card = Card.find(params[:flash_card][:confirm_id])
    if @card[:original_text] == input_text
      @card.box += 1 if @card.box < 5
      set_box(@card.box)
      flash[:success] = "Верно"
    else
      @card.update(error_count: @card.error_count + 1)
      set_box(1) if @card.error_count == 3
      flash[:danger] = "Ошибка"
    end
    redirect_to root_path
  end

  private

  def set_box(box)
    @card.update(box: box, error_count: 0)
    @card.inc_review_date(box)
  end

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :review_date, :user_id, :card_image, :deck_id, :box, :error_count)
  end
end
