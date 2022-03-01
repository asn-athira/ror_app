class ApplicationController < ActionController::Base

  include NotificationHelper
  include FlashHelper
  include General::FlashConcern

  before_action :configure_notification

end
