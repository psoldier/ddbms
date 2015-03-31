# encoding: utf-8

module DBMS
  class AdminApp
    get '/sessions/login' do
      haml :'sessions/login', :layout => :login_layout
    end

    post '/sessions/login' do
      if login(User, params[:username], params[:password])
        remember(authenticated(User)) if params[:remember]
        flash[:notice] = 'Bienvenido'
        redirect(params[:return] || '/admin/')
      else
        flash[:error] = 'Nombre de usuario y/o contraseña incorrectos'
        redirect(params[:return] || '/admin/')
      end
    end

    get '/sessions/logout' do
      logout(User)
      redirect '/admin/sessions/login'
    end
  end
end
