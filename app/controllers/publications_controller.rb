class PublicationsController < ApplicationController
  PER = 8
  before_action :authenticate_user!

  def index
    @publications = []
    @publication = Publication.new
    results_form_api if params[:title]
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @publication = Publication.new
  end

  def create
    @publication = Publication.find_or_initialize_by(isbn_code: params[:publication][:isbn_code])
    unless @publication.persisted?
      @publication = Publication.new(publication_params)
      @publication.save
    end

    redirect_to new_book_path(publication: @publication, title: @publication.title)
  end

  private

  def results_form_api
    set_search_word

    results = RakutenWebService::Books::Book.search(search_word)
    results.each do |result|
      @publications << read(result)
    end
    @publications = Kaminari.paginate_array(@publications, total_count: results.count).page(params[:page]).per(PER)
  end

  def set_search_word
    search_word = {}
    search_word[:title] = params[:title] if params[:title].present?
    search_word[:author] = params[:author] if params[:author].present?
  end

  def read(result)
    title = result['title']
    author = result['author']
    image = result['largeImageUrl'].gsub('?_ex=200x200', '')
    isbn_code = result['isbn']

    {
      title: title,
      author: author,
      image: image,
      isbn_code: isbn_code
    }
  end

  def publication_params
    params.require(:publication).permit(:title, :author, :isbn_code, :image)
  end
end
