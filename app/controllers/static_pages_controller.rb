class StaticPagesController < ApplicationController
  def index
    @card = Card.random
  end
end
