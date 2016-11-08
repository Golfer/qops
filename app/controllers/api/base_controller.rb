module Api
  class BaseController < ApplicationController
    include Api::BaseModule
    protect_from_forgery with: :null_session

    before_action :set_resource, only: %w(show update destroy)

    # TODO Need thik how to secure API and change this logic
    # http_basic_authenticate_with name: 'api_admin', password: '<7\fXJ%g[\xE6((x'
    # before_action :destroy_session

    def destroy_session
      request.session_options[:skip] = true
    end

    def resource_name
      @resource_name ||= controller_name.singularize
    end

    def resource_class
      @resource_class ||= resource_name.classify.constantize
    end

    def get_resource
      instance_variable_get("@#{resource_name}")
    end

    def resource_params
      @resource_params ||= self.send("#{resource_name}_params")
    end

    private

    def set_resource
      instance_variable_set "@#{resource_name}", resource_class.find(params[:id])
    end
  end
end
