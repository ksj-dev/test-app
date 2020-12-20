class Animedb < ApplicationRecord

  def self.search(search) #self.でクラスメソッドとしている
    if search # Controllerから渡されたパラメータが!= nilの場合は、titleカラムを部分一致検索
      Animedb.where(['title LIKE ?', "%#{search}%"])
    else
      Animedb.all #全て表示。
    end
  end

end
