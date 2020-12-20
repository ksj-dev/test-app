class ApplicationController < ActionController::Base
  def hello
    render html: "¡hola, mundo!"
  end

  def goodbey
    render html: "goodbey, World!"
  end
end
