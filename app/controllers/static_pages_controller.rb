class StaticPagesController < ApplicationController
  def index
    if !current_user.decks.first
      redirect_to decks_path, notice: "Необходимо создать колоду"
    elsif !current_user.cards.first
      redirect_to new_card_path, notice: "Необходимо создать карточку"
    elsif current_user.decks.choose_active.first
      @card = current_user.decks.choose_active.first.cards.random
    else
      @card = current_user.cards.random
    end
  end
end
