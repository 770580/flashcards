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
    answer_timer = params[:flash_card][:answer_timer]
    card = Card.find(params[:flash_card][:confirm_id])
    result = card.check_and_inc_review_date(input_text, answer_timer)
    check_message(card, input_text, result)
    return redirect_to root_path
  end

  private

  def check_message(card, input_text, result)
    if result[:correct]
      flash[:success] = result[:misprints_count] == 0 ? I18n.t('cards.flash_correctly') : I18n.t('cards.flash_misprint', input_text: input_text, original_text: card.original_text, translated_text: card.translated_text)
    else
      flash[:danger] = I18n.t('cards.flash_mistake')
    end
  end

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :review_date, :user_id, :card_image, :deck_id, :repetition, :e_factor, :interval)
  end
end
