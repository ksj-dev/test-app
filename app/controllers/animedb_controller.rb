require 'net/http'
require 'uri'
require 'json'

class AnimedbController < ApplicationController
  def index
    @animedbs = Animedb.all
  end
  
  def show
    @animedb = Animedb.find_by(sora_id: params[:sora_id])
  end

end
