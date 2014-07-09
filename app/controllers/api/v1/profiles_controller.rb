class Api::V1::ProfilesController < Api::V1::BaseController
  defaults resource_class: User
  respond_to :json

  def me
    respond_with current_resource_owner
  end

end