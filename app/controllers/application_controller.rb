class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def create
    var = create_instance_variable(u_class, m_class.create(form_params(class_setables)))

    if var.valid?
      self.send("redirect_to", self.send("#{u_class}_path", var))
    else
      render :new
    end
  end

  def new
    create_instance_variable(u_class, m_class.new)

    render :new
  end

  def show
    create_instance_variable(u_class, m_class.find(params[:id]))
  end

  def edit
    create_instance_variable(u_class, m_class.find(params[:id]))

    render :edit
  end

  def update
    var = create_instance_variable(u_class, m_class.find(params[:id]))

    if var.update(form_params(class_setables))
      self.send("redirect_to", self.send("#{u_class}_path", var))
    else
      render :edit
    end
  end

  def index
    create_instance_variable(u_class.pluralize, m_class.all)

    render :index
  end

  def destroy
    m_class.find(params[:id]).destroy

    self.send("redirect_to", self.send("#{u_class.pluralize}_path"))
  end

  private

  def u_class
    self.class.to_s.underscore[0..-12].singularize
  end

  def m_class
    Kernel.const_get(u_class.classify)
  end

  def class_setables
    m_class.attribute_names.select {|name| name != 'id' && name != 'created_at' && name != 'updated_at'}.collect {|name| name.to_sym}
  end

  def create_instance_variable(name, value)
    self.instance_variable_set("@#{name}", value)
  end

  def form_params(*args)
    params.require(u_class.to_sym).permit(*args)
  end
end
