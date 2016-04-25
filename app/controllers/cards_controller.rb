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
    result = card.check(input_text, answer_timer)
    case result
    when true then flash[:success] = I18n.t('cards.flash_correctly')
    when "misprint" then flash[:success] = I18n.t('cards.flash_misprint', input_text: input_text, original_text: card.original_text, translated_text: card.translated_text)
    else flash[:danger] = I18n.t('cards.flash_mistake')
    end
    redirect_to root_path
  end

  private

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :review_date, :user_id, :card_image, :deck_id, :repetition, :e_factor, :interval)
  end
end
