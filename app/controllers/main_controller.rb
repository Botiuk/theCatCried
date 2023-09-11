class MainController < ApplicationController

  def index
    $total_amount = Operation.total_amount
    Date.today.year == 2023 ? $copyright_year = "2023" : $copyright_year = "2023-#{Date.today.year.to_s}"
  end
  
end
