# This controller allows the management of User records.
class UsersController < ApplicationController
  before_action :load_user, :except => [ :index, :create, :new ]
  before_action :authenticate_user!, :only => [ :edit, :update, :destroy, :role ]
  after_action :verify_authorized

  protected

  # Load a User record as an instance variable based on the identifier
  # provided as a request parameter.  This method is usually called as a
  # before_filter.
  def load_user
    @user = User.find(params[:id])
    authorize @user
    redirect_to(users_path) and return false unless @user
  end

  # This method is called by login_required to determine if the current
  # authenticated session is authorized to modify a User record.
  helper_method :authorized?
  def authorized?(user)
    user.id == @user.id or user.has_role?(Role.manager)
  end

  # This method is called by the login_required filter to generate a
  # response to an unauthorized request.
  def access_denied
    redirect_to welcome_path
  end

  public

  # Display a list of User records.
  def index
    @users = User.all
    authorize User

    respond_to do |format|
      format.html
      format.xml  { render :xml => @users.to_xml }
    end
  end

  # Display a single User record.
  def show
    respond_to do |format|
      format.html
      format.xml  { render :xml => @user.to_xml }
    end
  end

  # Display a form to allow data for a new User to be provided.
  def new
    return redirect_to(welcome_path) if user_signed_in?

    @user = User.new
  end

  # Display a form for editing a User record.
  def edit
  end

  # Create a new User.
  def create
    return redirect_to(welcome_path) if logged_in?

    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        flash[:notice] = t('user create success')

        format.html { redirect_to welcome_path }
        format.xml  { head :created, :location => user_path(@user) }
      else
        format.html { render :action => :new }
        format.xml  { render :xml => @user.errors.to_xml }
      end
    end
  end

  # Update an existing User.
  def update
    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = t('user update success')

        format.html { redirect_to user_path }
        format.xml  { head :ok }
      else
        format.html { render :action => :edit }
        format.xml  { render :xml => @user.errors.to_xml }
      end
    end
  end

  # Destroy a User.
  def destroy
    self.current_user = nil if current_user == @user

    @user.destroy

    flash[:notice] = t('user destroy success')

    respond_to do |format|
      format.html {
        if logged_in?
          redirect_to users_path
        else
          redirect_to welcome_path
        end
      }
      format.xml  { head :ok }
    end
  end

  # ATOM feed for UserComment records.
  def comments
  end

  # ATOM feed for UserLog records.
  def logs
  end

  # FOAF RDF representation of a User.
  def foaf
  end

  # Add or remove a Role relationship to or from a User.
  def role
    return redirect_to(user_path) unless current_user.has_role?(Role.manager)

    respond_to do |format|
      if @role = Role.find(params[:role])
        format.html { redirect_to user_path }
        format.xml  { head :ok }

        if @user.roles.find(params[:role])
          @user.roles.delete @role

          flash[:message] = t('user role delete success')
          format.js { @done = :delete }
        else
          @user.roles.push @role

          flash[:notice] = t('user role push success')
          format.js { @done = :push }
        end
      else
        flash[:warning] = t('user role update fail')

        format.html { redirect_to user_path }
        format.xml  { render :xml => flash.to_xml }
        format.js   { send_js 'role_form' }
      end
    end
  end

  # This action handles the case where a User has forgotten their password.
  def forgot
    @user.forgot_password if @user

    flash[:notice] = t('user forgot password')

    respond_to do |format|
      format.html { redirect_to user_path }
      format.xml  { head :ok }
    end
  end
end
