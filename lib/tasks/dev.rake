namespace :dev do
  task :fetch_city => :environment do
    puts "Fetch city data..."
    response = RestClient.get "http://v.juhe.cn/weather/citys", :params => { :key => JUHE_CONFIG["api_key"] }
    data = JSON.parse(response.body)

    data["result"].each do |c|
      existing_city = City.find_by_juhe_id( c["id"] )

      if existing_city.nil?
        City.create!( :juhe_id => c["id"], :province => c["province"],
                      :city => c["city"], :district => c["district"] )
      end
    end

    puts "Total: #{City.count} cities"
  end

  task :fetch_aircity => :environment do
    puts "Fetch aircity data..."
    response = RestClient.get "http://web.juhe.cn:8080/environment/air/pmCities", :params => { :key => "ee3141e71f01bcc70448909b19492cc4"}
    data = JSON.parse(response.body)

    data["result"].each do |a|
      existing_aircity = Aircity.find_by_pinyin( a["pinyin"] )

      if existing_aircity.nil?
        Aircity.create!(:name=> a["name"], :pinyin => a["pinyin"],:aqi => a["aqi"] )
      end
    end

    puts "Total: #{Aircity.count} cities"
  end
end
