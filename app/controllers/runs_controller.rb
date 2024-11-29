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
    redirect_to route_run_running_path(@route, @run)
  end

  def running
    @run = Run.find(params[:run_id])
    @route = @run.route
  end

  def show
    @run = Run.find(params[:id])
    @step = @run.route.steps
  end

  def end_run
    @run = Run.find(params[:id])
    @run.ending_time = Time.now
    @run.save
    redirect_to edit_run_path(@run)
  end

  def edit
    @run = Run.find(params[:id])
    @route = @run.route
    @step = @route.steps
  end

  def update
  end
end
