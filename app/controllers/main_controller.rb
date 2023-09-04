class MainController < ApplicationController
  def index
    $total_amount = Operation.total_amount
  end
end
