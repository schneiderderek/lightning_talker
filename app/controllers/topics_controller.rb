class TopicsController < ApplicationController
  respond_to :html, :json

  # GET /topics
  # GET /topics.json
  def index
    @topics = Topic.recent.decorate
    respond_with @topics
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
    @topic = Topic.find(params[:id])
    respond_with @topic
  end

  # GET /topics/new
  # GET /topics/new.json
  def new
    @topic = Topic.new
    respond_with @topic
  end

  # GET /topics/1/edit
  def edit
    @topic = Topic.find(params[:id])
  end

  # POST /topics
  # POST /topics.json
  def create
    @topic = Topic.new(params[:topic])
    @topic.save
    respond_with @topic
  end

  # PUT /topics/1
  # PUT /topics/1.json
  def update
    @topic = Topic.find(params[:id])
    @topic.update_attributes(params[:topic])
    respond_with @topic
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy
    respond_with @topic
  end
end