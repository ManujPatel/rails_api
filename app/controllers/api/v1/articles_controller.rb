module Api
    module V1
        class ArticlesController < ApplicationController
            before_action :set_article, only: [:show, :update, :destroy]
            def index 
                @articles = Article.order('created_at DESC')
                
                render json:@articles

            end

            def show
                render json:@article
            end       
            
            def create
                if @article.save
                    render json: {status: 'success', message:'saved article', data:@article},status: :ok
                else
                    render json: {status: 'Error', message:'article not saved', data:@article.errors},status: :unprocessable_entity
                end
            end

        
            def update
                if @article.update(article_params)
                    render json: {status: 'success', message:'updated article', data:@article},status: :ok
                else
                    render json: {status: 'Error', message:'article not updated', data:@article.errors},status: :unprocessable_entity
                end
            end


            def destroy
                
                @article.destroy
                render json: {status: 'success', message:'deleted article', data:@article},status: :ok
            end

            def search
                @article=Article.find_by(title: params[:title])
                if @article.blank?
                  render json: {message:'data not found with this title'}
                else
                  render json: @article
                end
            end

            private
                def set_article
                    @article = Article.find(params[:id])
                end

                def article_params
                    params.permit(:title, :body, :release_date)
                end

        end
    end
end