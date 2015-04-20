Wfmserver::Admin.controllers :pings do
  get :index do
    @title = "Pings"
    @pings = Ping.all
    render 'pings/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'ping')
    @ping = Ping.new
    render 'pings/new'
  end

  post :create do
    @ping = Ping.new(params[:ping])
    if @ping.save
      @title = pat(:create_title, :model => "ping #{@ping.id}")
      flash[:success] = pat(:create_success, :model => 'Ping')
      params[:save_and_continue] ? redirect(url(:pings, :index)) : redirect(url(:pings, :edit, :id => @ping.id))
    else
      @title = pat(:create_title, :model => 'ping')
      flash.now[:error] = pat(:create_error, :model => 'ping')
      render 'pings/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "ping #{params[:id]}")
    @ping = Ping.get(params[:id])
    if @ping
      render 'pings/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'ping', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "ping #{params[:id]}")
    @ping = Ping.get(params[:id])
    if @ping
      if @ping.update(params[:ping])
        flash[:success] = pat(:update_success, :model => 'Ping', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:pings, :index)) :
          redirect(url(:pings, :edit, :id => @ping.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'ping')
        render 'pings/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'ping', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Pings"
    ping = Ping.get(params[:id])
    if ping
      if ping.destroy
        flash[:success] = pat(:delete_success, :model => 'Ping', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'ping')
      end
      redirect url(:pings, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'ping', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Pings"
    unless params[:ping_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'ping')
      redirect(url(:pings, :index))
    end
    ids = params[:ping_ids].split(',').map(&:strip)
    pings = Ping.all(:id => ids)
    
    if pings.destroy
    
      flash[:success] = pat(:destroy_many_success, :model => 'Pings', :ids => "#{ids.to_sentence}")
    end
    redirect url(:pings, :index)
  end
end
