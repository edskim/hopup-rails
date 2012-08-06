class HitsController < ApplicationController
  before_filter :signed_in_user

  def new
    @hits = [] #Hit.new( user_id: current_user.id, lat: params[:lat], lng: params[:lng] )
    @lat = params[:lat]
    @lng = params[:lng]
    current_user.subscribed_topics.each do |topic|
      topic.tags.each do |tag|
        if GeoDistance::Haversine.geo_distance( @lat.to_f, @lng.to_f, tag.lat, tag.lng ).to_meters < 30
          hit = Hit.new( requester_id: current_user.id, lat: @lat, lng: @lng, tag_id: tag.id )
          hit.save
          @hits << hit
        end
      end
    end
  end

  def create
    @hits = [] #Hit.new( user_id: current_user.id, lat: params[:lat], lng: params[:lng] )
    @lat = params[:lat]
    @lng = params[:lng]
    current_user.subscribed_topics.each do |topic|
      topic.tags.each do |tag|
        if GeoDistance::Haversine.geo_distance( @lat.to_f, @lng.to_f, tag.lat, tag.lng ).to_meters < 300
          hit = Hit.new( requester_id: current_user.id, lat: @lat, lng: @lng, tag_id: tag.id )
          hit.save
          @hits << hit
        end
      end
    end
    respond_to do |format|
      format.html { render 'new' }
      format.json { render json: @hits }
    end
  end

  def destroy
    @hit = Hit.find(params[:id])
    @hit.destroy
    respond_with(@hit)
  end

end
