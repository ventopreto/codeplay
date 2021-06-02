class Admin::AdminController < ActionController::Base
  add_flash_types :success, :fail
  layout 'admin'
  before_action :authenticate_user!
end