class Api::V1::BaseController < InheritedResources::Base
  doorkeeper_for :all

  protected

  def current_resource_ownwer
    @current_resource_owner ||= User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end
end