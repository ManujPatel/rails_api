module Api
    module V1
        class ArticlesController < ApplicationController
            def index 
                @articles = Article.order('created_at DESC')
                render json: {status: 'success', message:'loaded articles', data:@articles},status: :ok
            end

            def show
                @article = Article.find(params[:id])
                render json:@article
            end       
            
            def create
                @article = Article.new(article_params)
                if @article.save
                    render json: {status: 'success', message:'saved article', data:@article},status: :ok
                else
                    render json: {status: 'Error', message:'article not saved', data:@article.errors},status: :unprocessable_entity
                end
            end


            def destroy
                @article = Article.find(params[:id])
                @article.destroy
                render json: {status: 'success', message:'deleted article', data:@article},status: :ok
            end

            private

                def article_params
                    params.permit(:title, :body, :release_date)
                end

        end
    end
end