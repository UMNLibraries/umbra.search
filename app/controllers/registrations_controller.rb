class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    super
  end

  def update
    super
  end

  # GET /resource/edit
  def edit
    render :edit
  end

  # # By default we want to require a password checks on update.
  # # You can overwrite this method in your own RegistrationsController.
  # def update_resource(resource, params)
  #   if params['password'] || params['email']
  #     resource.update_with_password(params) if params['password']
  #   else
  #     resource.update_without_password(params.except('current_password')) unless params['password']
  #   end
  # end
end