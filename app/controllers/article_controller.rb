class ArticleController < ApplicationController
    skip_before_action :verify_authenticity_token

    # get
    def index

        # find by id
        if params[:id]
            render json: Article.find(params[:id])
        
        # find by category
        elsif params[:category]
            render json: Article.where(category: params[:category])
        
        # find by author
        elsif params[:author]
            render json: Article.where(author: params[:author])
        
        # find by partial title 
        elsif params[:title]
            render json: Article.where('title LIKE ?',"%#{params[:title]}%")

        # find between specific dates
        elsif params[:start_date] && params[:end_date]
            render json: Article.where(:date_published => params[:start_date]..params[:end_date])

        # find all
        else 
            render json: Article.all()
        end
    end

    # post
    def create
        res = Article.create(title: params[:title], author: params[:author], body: params[:body], category: params[:category],date_published: params[:date_published]);
        render json: res;
    end

    # put
    def update
        article = Article.find(params[:id])
        if params[:author]
            article.author = params[:author]
        end
        if params[:title]
            article.title = params[:title]
        end
        if params[:date_published]
            article.date_published = params[:date_published]
        end
        if params[:category]
            article.category = params[:category]
        end
        if params[:body]
            article.body = params[:body]
        end
        article.save
        render json: article

    end

    # delete
    def delete 
        article = Article.find(params[:id])
        article.destroy;
        render json: article
    end

     # pagination
     def article_page
        size = params[:page_size] ? params[:page_size].to_i : 0;
        ind = params[:page_index] ? (params[:page_index].to_i - 1)*size : 0;
        res = Article.limit(size).offset(ind);
        render json: res;
    end
end
