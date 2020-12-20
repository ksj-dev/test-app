require 'net/http'
require 'uri'
require 'json'

class AnimedbController < ApplicationController
  def index
    
    if !params[:year] and !params[:search]
      @animedbs = Animedb.all
      
    else
      @animedbs = Animedb.where(:year => params[:year]).search(params[:search])
    end

#    if  params[:year] and params[:search]
#      @animedbs = Animedb.where(:year => params[:year]).search(params[:search])
#    else if params[:year]
#      @animedbs = Animedb.where(:year => params[:year])
#    else if params[:search]
#      @animedbs = Animedb.search(params[:search])
#    else
#      @animedbs = Animedb.all
#    end
      @p = params
  end
  
  def show
    @animedb = Animedb.find_by(:sora_id => params[:sora_id])
  end
  
end
