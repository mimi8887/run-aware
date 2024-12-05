class RunsController < ApplicationController
  #def new
    #@run = Run.new
    #@route = Route.find(params[:route_id])
  #end

  def create
    @route = Route.find(params[:route_id])
    @run = Run.new
    @run.route = @route
    @run.user = current_user
    @run.starting_time = Time.now
    @run.save!
    redirect_to run_running_path(@run)
  end

  def running
    @run = Run.find(params[:run_id])
    @route = @run.route
  end

  def show
    @run = Run.find(params[:id])
    @bookmark = Bookmark.find_by(user: current_user, route: @run.route)
    if @run.route.steps_as_json.nil?
      @steps = @run.route.steps.select(:latitude, :longitude).order(:position).as_json
      # markers
      @steps.each_with_index do |step, index|
        if index == 0
          step[:marker_html] = render_to_string(partial: "shared/marker")
        else
          step[:marker_html] = render_to_string(partial: "shared/markerarrive")
        end
      end
    else
      @steps = JSON.parse(@run.route.steps_as_json)
    end
  end

  def end_run
    @run = Run.find(params[:id])
    @run.ending_time = Time.now
    @run.save
    # redirect_to edit_run_path(@run)
    redirect_to summary_path(@run)
  end

  def summary
    @run = Run.find(params[:id])
    @route = @run.route
    @bookmark = Bookmark.find_by(user: current_user, route: @run.route) || Bookmark.new
  end

  def update
  end
end
