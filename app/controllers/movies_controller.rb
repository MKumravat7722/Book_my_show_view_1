class MoviesController < ApplicationController
  skip_before_action :check_customer
  before_action :check_owner, except: [:index, :search_movie]
  before_action :set_value, only:[:update, :destroy, :show]

  def index
    # @movie = Movie.paginate(:page => params[:page], :per_page => 2)
    # render json: @movie
    @movies =Movie.all
  end

  def show
    render json: @movie
  end
  
  def create
    movie=Movie.new(movie_params)
    if movie.save
      render json: movie
    else
      movie.errors.full_messages
    end
  end
  
  def update
    if @movie.update(movie_params)
      render json: @movie
    else
      render json: @movie.errors.full_messages
    end
  end
  
  def destroy
    if @movie.destroy
      render json: {message: "movie delete succesfully"}
    end
  end
  
  def search_movie
    name = params[:name]
    if name.blank?
      return render json: { error: "Name field can't be blank" }, status: :bad_request
    end
    movies = Movie.where("name ILIKE ?", "%#{name}%")
    if movies.empty?
      return render json: { message: "Movie not found" }, status: :not_found
    end
    render json: movies
  end
  
  private
  
  def movie_params
    params.permit(:name, :poster)
  end
  
  def set_value
    @movie=Movie.find(params[:id])
  end
end

