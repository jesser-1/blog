module Api
  class ArticlesController < ApplicationController
  
    def index
      articles = Article.all
      render json: articles, status: :ok
    end

    def show
      article = Article.find_by(id: params[:id])
      if article
        render json: article, status: :ok
      else
        render json: {
          error: "Article not found"
        }
      end
    end
    
  
    
    def create
      article = Article.new(article_params)
      
      if article.save
          render json: article, status: :ok
      else
        render json: {
        error: "Error creating.."
        }
      end
    end
    
    
    
    def update
      article = Article.find(params[:id])
      if article
        article.update(article_params) 
        render json: article, status: :ok
      else
        render json: {
          error: "Article not found"
          }
      end
    end
    
    def destroy
      @article = Article.find(params[:id])
  
      if @article.destroy
          head(:ok)
      else
          head(:unprocessable_entity)
      end
    end
    
    private

    def article_params
      params.require(:article).permit(:title, :body, :status)
    end
  end  
end
  