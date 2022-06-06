class RidesController < ApplicationController
  def index
    matching_rides = Ride.all

    @list_of_rides = matching_rides.order({ :created_at => :desc })

    render({ :template => "rides/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_rides = Ride.where({ :id => the_id })

    @the_ride = matching_rides.at(0)

    render({ :template => "rides/show.html.erb" })
  end

  def create
    the_ride = Ride.new
    the_ride.distance_km = params.fetch("query_distance_km")
    the_ride.minutes = params.fetch("query_minutes")
    the_ride.user_id = @current_user.id
    the_ride.description = params.fetch("query_description")
    the_ride.date = params.fetch("query_date")

    if the_ride.valid?
      the_ride.save
      redirect_to("/rides", { :notice => "Ride created successfully." })
    else
      redirect_to("/rides", { :notice => "Ride failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_ride = Ride.where({ :id => the_id }).at(0)

    the_ride.distance_km = params.fetch("query_distance_km")
    the_ride.minutes = params.fetch("query_minutes")
    the_ride.user_id = params.fetch("query_user_id")
    the_ride.description = params.fetch("query_description")
    the_ride.date = params.fetch("query_date")

    if the_ride.valid?
      the_ride.save
      redirect_to("/rides/#{the_ride.id}", { :notice => "Ride updated successfully."} )
    else
      redirect_to("/rides/#{the_ride.id}", { :alert => "Ride failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_ride = Ride.where({ :id => the_id }).at(0)

    the_ride.destroy

    redirect_to("/rides", { :notice => "Ride deleted successfully."} )
  end
end
