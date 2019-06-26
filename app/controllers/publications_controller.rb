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

    redirect_to new_user_book_path(current_user.id, publication: @publication, title: @publication.title)
  end

  private

  def results_form_api
    return unless check_length_hash?(set_search_word)
    
    results = RakutenWebService::Books::Book.search(set_search_word)
    results.each do |result|
      @publications << read(result)
    end
    @publications = Kaminari.paginate_array(@publications, total_count: results.count).page(params[:page]).per(PER)
    search_result_is_present?(@publications)
  end

  def set_search_word
    search_word = {}
    search_word[:title] = params[:title] if params[:title].present? 
    search_word[:author] = params[:author] if params[:author].present?
    search_word
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

  def check_length_hash?(hash)
    result = true
    return result unless hash.present?
    hash.each{|key, value|
      if value.length < 2 or value.length > 128
        flash.now[:danger] = "検索文字列には2文字以上、128文字以下を使用してください" 
        result = false
        break
      end
    }
    result
  end

  def publication_params
    params.require(:publication).permit(:title, :author, :isbn_code, :image)
  end
end
