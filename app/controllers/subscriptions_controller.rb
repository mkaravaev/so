class SubscriptionsController < InheritedResources::Base
  actions :create, :destroy
  before_action :authenticate_user!

  protected

  def subscription_params
    params.require(:subscription).permit(:subscriber_id, :resource_id)
  end
end
