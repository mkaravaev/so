class Api::V1::ProfilesController < Api::V1::BaseController
  respond_to :json

  def all
    respond_to collection
  end

  def me
    respond_with current_resource_owner
  end

end