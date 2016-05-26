module Spree
  module Admin
    class SizesController < ResourceController
      include Spree::Admin::BaseHelper
      rescue_from ActiveRecord::RecordNotFound, with: :render_404

      before_action :load_size, only: [:edit, :destroy]

      def index
        respond_with(@collection)
      end

      def create
        @size = Spree::Size.new(size_params)
        if @size.save
          flash.now[:success] = flash_message_for(@size, :successfully_created)
          render :edit
        else
          render :new
        end
      end

      def destroy
        if @size.destroy
          flash[:success] = Spree.t('notice_messages.size_deleted')
        else
          flash[:error] = Spree.t('notice_messages.size_not_deleted')
        end

        respond_with(@size) do |format|
          format.html { redirect_to admin_ranges_path }
          format.js  { render_js_for_destroy }
        end
      end

      private

      def size_params
        params.fetch(:size, {}).permit(*permitted_attributes)
      end

      def permitted_attributes
        [
          :name,
          :description
        ]
      end

      def load_size
        @size = Spree::Size.find(params[:id])
      end

      def collection
        return @collection if @collection.present?
        # params[:q] can be blank upon pagination
        params[:q] ||= {}

        @search = Spree::Size.ransack(params[:q])
        @collection = @search.result.
              page(params[:page]).
              per(Spree::Config[:properties_per_page])
      end

    end
  end
end