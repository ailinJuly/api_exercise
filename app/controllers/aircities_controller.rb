class AircitiesController < ApplicationController

  def index
    @aircities = Aircity.all
  end

  def update_aqi
    aircity = Aircity.find(params[:id])

    response = RestClient.get "http://web.juhe.cn:8080/environment/air/pm",
                              :params => { :city => aircity.pinyin, :key => "ee3141e71f01bcc70448909b19492cc4" }
    data = JSON.parse(response.body)

    aircity.update( :aqi => data["result"]["AQI"])

    redirect_to aircities_path
end


end
