class StaticPagesController < ApplicationController
  def index
    if !current_user.decks.first
      redirect_to decks_path, notice: "Необходимо создать колоду"
    elsif !current_user.cards.first
      redirect_to cards_path, notice: "Необходимо создать карточку"
    else
      if current_user.decks.choose_active
        @card = current_user.decks.choose_active.first.cards.random
      else
        @card = current_user.cards.random
      end
    end
  end
end
