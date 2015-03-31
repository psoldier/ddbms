# encoding: utf-8

module DBMS
  class AdminApp

    get '/users' do
      @users = User.order(:username).paginate(page,PER_PAGE)
      haml :'users/index'
    end

    get '/users/new' do
      @user = User.new
      haml :'users/new'
    end

    get '/users/:id' do
      @user = User[params[:id]]
      haml :'users/show'
    end

    get '/users/:id/edit' do
      @user = User[params[:id]]
      haml :'users/edit'
    end

    post '/users/create' do
      begin
        @user = User.new params[:user]
        @user.save
        flash[:notice] = 'Usuario creado con exito'
        redirect :'/admin/users'
      rescue Exception => e
        flash.now[:error] = e.to_s
        haml :'/users/new'
      end
    end

    put '/users/:id' do
      begin
        params[:user].tap{ |s| s.delete('password') } unless ! params[:user][:password].blank?
        @user = User[params[:id]]
        @user.update params[:user]
        @user.save
        flash[:notice] = 'Usuario actualizado con exito'
        redirect :"/admin/users/#{params[:id]}"
      rescue Exception => e
        flash.now[:error] = e.to_s
        haml :'users/edit'
      end
    end

    delete '/users/:id' do
      begin
        user = User[params[:id]]
        user.delete
        flash[:notice] = 'Usuario eliminado con exito'
      rescue Exception => e
        flash[:error] = e.to_s
      end
      redirect :'/admin/users'
    end

  end
end
