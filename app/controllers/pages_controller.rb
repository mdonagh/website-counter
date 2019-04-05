class PagesController < ApplicationController
  impressionist
  config.cache_store = :null_store
  
  def home
    UpdateCounterJob.perform_later
  end
end
