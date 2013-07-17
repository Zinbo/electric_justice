class RegistrationsController < Devise::RegistrationsController
   def new
     @character = Character.new
     build_resource({})
     respond_with self.resource
   end
  
  def create
    build_resource(sign_up_params)

    @character = Character.new(params[:character])
    @character.user = resource
    @character.primary = true

    if @character.save
      if resource.save
        if resource.active_for_authentication?
          set_flash_message :notice, :signed_up if is_navigational_format?
          sign_up(resource_name, resource)
          respond_with resource, :location => after_sign_up_path_for(resource)
        else
          set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
          expire_session_data_after_sign_in!
          respond_with resource, :location => after_inactive_sign_up_path_for(resource)
        end
      else
        @character.destroy
        clean_up_passwords resource
        respond_with resource
      end
    else
      render 'new'
    end
  end
end