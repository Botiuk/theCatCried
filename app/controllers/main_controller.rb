class MainController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    $total_amount = Operation.total_amount(current_user.id) if user_signed_in?
  end

end
