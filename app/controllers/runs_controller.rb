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
    @bookmark = Bookmark.new
  end

  def update
  end
end
