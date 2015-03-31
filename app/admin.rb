module DBMS
  class AdminApp < DBMS::Base

    use Shield::Middleware, "/admin/sessions/login"

    configure do
      set :views, 'app/views/admin'
    end

    helpers do
      def current_user
        authenticated(User)
      end

      def require_sign_in
        ok = error(401) unless authenticated(User) || request.path_info == "/sessions/login"
      end

      def valid_password?(password)
        (/\d\w/.match(password).class == MatchData) && (password.length >= 10)
      end

      def generate_signature(token, timestamp)
        OpenSSL::HMAC.hexdigest(OpenSSL::Digest::Digest.new('sha256'), Setting.first.secret_token, '%s%s' % [timestamp, token])
      end
    end

    before { require_sign_in }

    get '/' do
      haml :dashboard
    end

    not_found do
      "not found admin, #{request.path_info}"
    end

    error do
      "error admin"
    end
  end
end
