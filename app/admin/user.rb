ActiveAdmin.register User do
  permit_params :admin, :email, :password, :password_confirmation

  controller do
    def update
      @user = User.find params[:id]
      params[:user].delete :password if params[:user][:password].blank?
      @user.update_without_password permitted_params[:user]
      respond_with :admin, @user
    end
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs 'User Details' do
      f.input :admin
      f.input :email
      f.input :password
    end

    f.actions
  end

  index do
    selectable_column
    id_column

    column :admin
    column :email
    column :current_sign_in_at
    column :sign_in_count

    column :updated do |user|
      "#{ time_ago_in_words user.updated_at } ago"
    end

    column '(un)lock' do |user|
      if user.locked?
        link_to 'Unlock', [:unlock, :admin, user], class: 'member_link', method: 'put' if can? :unlock, user
      else
        link_to 'Lock', [:lock, :admin, user], class: 'member_link', method: 'put' if can? :lock, user
      end
    end

    actions
  end

  member_action :lock, :method => :put do
    resource.lock_access!
    redirect_to resource_path, notice: "You have locked #{ resource.email }."
  end

  member_action :unlock, :method => :put do
    resource.unlock_access!
    redirect_to resource_path, notice: "You have unlocked #{ resource.email }."
  end

  action_item :only => :show, if: ->{ user.unlocked? and can? :lock, user } do
    link_to 'Lock User', [:lock, :admin, user]
  end

  action_item :only => :show, if: ->{ user.locked? and can? :unlock, user } do
    link_to 'Unlock User', [:unlock, :admin, user]
  end

  scope :all, default: true
  scope :admin
  scope 'Locked', :access_locked
end
