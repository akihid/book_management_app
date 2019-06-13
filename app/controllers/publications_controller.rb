class PublicationsController < ApplicationController

  def index
    @publications = []
    @publication = Publication.new
    
    get_results_form_api if params[:commit].eql?("検索")
  end


  private

  def get_results_form_api
    search_word = {}
    search_word[:title] = params[:title] if params[:title].present?
    search_word[:author] = params[:author] if params[:author].present?

    results = RakutenWebService::Books::Book.search(search_word)
    
    results.each do |result|
      @publications << read(result)
    end
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
end
