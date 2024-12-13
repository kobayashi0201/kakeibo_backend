class ApplicationController < ActionController::API
  def options
    response.headers["Access-Control-Allow-Origin"] = "http://localhost:4000"
    response.headers["Access-Control-Allow-Methods"] = "GET, POST, PUT, PATCH, DELETE, OPTIONS"
    response.headers["Access-Control-Allow-Headers"] = "Content-Type, Authorization"
    head :ok
  end
end
