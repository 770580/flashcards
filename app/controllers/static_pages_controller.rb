class StaticPagesController < ApplicationController
  def index
    @card = current_user.cards.random
  end
end
