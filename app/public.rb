module DBMS
  class PublicApp < DBMS::Base

    configure do
      set :views, 'app/views/public'
    end

    helpers do
      def current_user
        authenticated(User)
      end
    end

    get '/' do
      haml :dashboard
    end

    not_found do
      "not found Public"
    end

    error do
      "Error Public"
    end
  end
end
