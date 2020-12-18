# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'net/http'
require 'uri'
require 'json'
years = [2014,2015,2016,2017,2018,2019,2020,2021] 
courses = [1,2,3,4]
years.each_with_index do |year, i|
    courses.each_with_index do | cours, j|
        # hash形式でパラメタ文字列を指定し、URL形式にエンコード
        # URIを解析し、hostやportをバラバラに取得できるようにする
        uri = URI.parse("http://api.moemoe.tokyo/anime/v1/master/#{year}/#{cours}")
        # リクエストパラメタを、インスタンス変数に格納
        @query = uri.query
        
        # 新しくHTTPセッションを開始し、結果をresponseへ格納
        response = Net::HTTP.start(uri.host, uri.port) do |http|
          # 接続時に待つ最大秒数を設定
          http.open_timeout = 5
          # 読み込み一回でブロックして良い最大秒数を設定
          http.read_timeout = 10
          # ここでWebAPIを叩いている
          # Net::HTTPResponseのインスタンスが返ってくる
          http.get(uri.request_uri)
        end
        # 例外処理の開始
        begin
          # responseの値に応じて処理を分ける
          case response
          # 成功した場合
          when Net::HTTPSuccess
            # responseのbody要素をJSON形式で解釈し、hashに変換
            @result = JSON.parse(response.body)
            # 表示用の変数に結果を格納
            @result.each_with_index do |res, k|
                Animedb.create(
                    :sora_id => res["id"], 
                    :title => res["title"],
                    :title_short1 => res["title_short1"], 
                    :title_short2 => res["title_short2"],
                    :title_short3 => res["title_short3"],
                    :public_url => res["public_url"],
                    :twitter_account => res["twitter_account"], 
                    :twitter_hash_tag => res["twitter_hash_tag"], 
                    :cours_id => res["cours_id"],
                    :sex => res["sex"],
                    :sequel => res["sequel"], 
                    :city_code => res["city_code"], 
                    :city_name => res["city_name"],
                    :year => year,
                    :cours => cours,
                    )
            end
            #@zipcode = @result["results"][0]["zipcode"]
            #@address1 = @result["results"][0]["address1"]
            #@address2 = @result["results"][0]["address2"]
            #@address3 = @result["results"][0]["address3"]
          # 別のURLに飛ばされた場合
          when Net::HTTPRedirection
            @message = "Redirection: code=#{response.code} message=#{response.message}"
          # その他エラー
          else
            @message = "HTTP ERROR: code=#{response.code} message=#{response.message}"
          end
        end
    end
# エラー時処理
rescue IOError => e
  @message = "e.message"
rescue TimeoutError => e
  @message = "e.message"
rescue JSON::ParserError => e
  @message = "e.message"
rescue => e
  @message = "e.message"
end