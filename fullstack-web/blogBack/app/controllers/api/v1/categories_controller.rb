
module Api
  module V1
    class CategoriesController < ApplicationController
      before_action :set_category, only: [:show, :update, :destroy]

      def index
        categories = Category.order('created_at DESC');
        render json: {status: 'SUCCESS', message:'Categorias carregadas', data:categories},status: :ok
      end

      def show
        render json: {status: 'SUCCESS', message:'Categoria carregada', data:@category },status: :ok
      end

      def destroy
        @category.destroy
        render json: {status: 'SUCCESS', message:'Categoria deletada'}, status: :ok
      end

      def create
        @category = Category.new(category_params)
        if @category.save
          render json: {status: 'SUCCESS', message:'Categoria criada', data: @category}, status: :ok
        else
          render json: {status: :unprocessable_entity, message: 'Falha na criacao da catogoria', data: @category.errors},status: :unprocessable_entity
        end
      end

      def update
        if @category.update(category_params)
          render json: {status: 'SUCCESS', message:'Categoria atualizada', data: @category}, status: :ok
        else
          render json: {status: :unprocessable_entity, message: 'Falha na atualizacao da catogoria', data: @category.errors},status: :unprocessable_entity
        end
      end

      private

      def category_params
        params.require(:category).permit(:name, :description)
      end

      def set_category
        @category = Category.find(params[:id])
      end

    end
  end
end