# encoding: utf-8

module DBMS
  class AdminApp

    get '/slaves' do
      @slaves = Slave.order(:database).paginate(page,PER_PAGE)
      haml :'slaves/index'
    end

    get '/slaves/new' do
      @slave = Slave.new
      haml :'slaves/new'
    end

    get '/slaves/:id' do
      @slave = Slave[params[:id]]
      haml :'slaves/show'
    end

    post '/slaves/create' do
      begin
        @slave = Slave.new params[:slave]
        @slave.save
        flash[:notice] = 'Slave creado con exito'
        redirect :'/admin/slaves'
      rescue Exception => e
        flash.now[:error] = e.to_s
        haml :'/slaves/new'
      end
    end

    delete '/slaves/:id' do
      begin
        slave = Slave[params[:id]]
        slave.destroy
        flash[:notice] = 'Slave eliminado con exito'
      rescue Exception => e
        flash[:error] = e.to_s
      end
      redirect :'/admin/slaves'
    end

  end
end
