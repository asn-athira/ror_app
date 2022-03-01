#derived from base controller
class UsersController < BaseController
  require 'time'

  def index
    @page_title = "Users | Home"
    get_collection
  end
  
  def books
    @users=User.all
  end

  def new
    new_book
    @page_title = "Users | New User"   
  end
  
  def show
    @user=User.find(params[:id])
  end
  
  def edit
    @user=User.find(params[:id])
    @page_title = "User | Update Users"     
  end
  
  def create
    @user=User.new(permitted_params)
    if @user.valid?
      @user.save
      set_notification(true, I18n.t('status.success'), I18n.t('success.created', item: "User"))
    else
      message = I18n.t('errors.failed_to_create', item: "Users")     
      set_notification(false, I18n.t('status.error'), message)
    end
  end

  def update
    @user=User.find(params[:id])
    @user.update(permitted_params)
    if @user.save
      set_notification(true, I18n.t('status.success'), I18n.t('success.updated', item: "User"))
    else
      message = I18n.t('errors.failed_to_create', item: "Users")     
      set_notification(false, I18n.t('status.error'), message)
    end
  end
  
  def destroy
    @user=User.find(params[:id])
    @user.destroy
    redirect_to @user
  end

  def data_actions
    value = params[:value]
    ids = params[:ids]
    ids.each do |id|
      @user=User.find(id)
      if value == "Enable"
        @user.status = true
        @user.save
        if @user.save
          set_notification(true, I18n.t('status.success'), I18n.t('success.updated', item: "User"))
        else
          message = I18n.t('errors.failed_to_create', item: "Users")     
          set_notification(false, I18n.t('status.error'), message)
        end
      elsif value == "Disable"
        @user.status = false
        @user.save
        if @user.save
          set_notification(true, I18n.t('status.success'), I18n.t('success.updated', item: "User"))
        else
          message = I18n.t('errors.failed_to_create', item: "Users")     
          set_notification(false, I18n.t('status.error'), message)
        end
      else  
        @user.destroy
        redirect_to root_path
      end
    end
  end

  def sort_user
    value = params[:value]
    if value == "Name"
      @users = User.order("name ASC")
      @relation = User.all
      @per_page = 10
      @users = @relation.order(@order_by).page(@current_page).per(@per_page)  
    else      
      @users = User.order("email ASC")  
      @relation = User.all
      @per_page = 10
      @users = @relation.order(@order_by).page(@current_page).per(@per_page)
    end      
    redirect_to root_path
  end
  
  def status
    @user = User.find(params[:id])
    value = @user.status
    if value == true
      @user.status = false
      @user.save
    else
      @user.status = true
      @user.save
    end
  end
    
  # --------------
  # Fetch Methods
  # --------------

  private

  def permitted_params
    params.require(:user).permit(:name, :address, :phone, :email)
  end

  def new_book
    @user = User.new
  end

  def existing_book
    @user = User.find_by_id(params[:id])
  end

  def get_collection
    @order_by = "created_at DESC" unless @order_by
    @relation = User.all
    @per_page = 10
    @users = @relation.order(@order_by).page(@current_page).per(@per_page)
  end
  
  def apply_filters
    @query = params[:q]
    @relation = @relation.search(@query) if @query && !@query.blank?  
  end

  def initialise_urls
    @wf_refresh_url = root_path
  end


end