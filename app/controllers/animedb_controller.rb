require 'net/http'
require 'uri'
require 'json'

class AnimedbController < ApplicationController
  def index
    @animedbs = Animedb.all
  end
end
