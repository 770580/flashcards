class StaticPagesController < ApplicationController
  def index
    if !current_user.decks.first
      flash[:info] = I18n.t('static_pages.flash_need_deck')
      redirect_to decks_path
    elsif !current_user.cards.first
      flash[:info] = I18n.t('static_pages.flash_need_card')
      redirect_to new_card_path
    elsif current_user.decks.choose_active.first
      @card = current_user.decks.choose_active.first.cards.random
      response_format
    else
      @card = current_user.cards.random
      response_format
    end
  end

  private

  def response_format
    respond_to do |format|
      format.html
      format.js
    end
  end
end
