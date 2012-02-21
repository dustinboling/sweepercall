class RecordingsController < ApplicationController
  def new
    @agent = Agent.find_by_uuid(params[:uuid])
    
    respond_to do |format|
      format.xml # new.xml
    end
  end
  
  def create
    
  end

end
