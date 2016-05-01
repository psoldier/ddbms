module DBMS
  class Base < Sinatra::Base
    # directory structure
    configure do
      set :root, Dir.pwd
      set :views, "app/views/"
      set :public_folder, File.dirname(__FILE__) + '/public'
    end

    # logging
    file = File.new("log/#{ENV['RACK_ENV']}.log", 'a+')
    file.sync = true
    use Rack::CommonLogger, file

    #partial
    configure do
      register Sinatra::Partial
      set :partial_template_engine, :haml
      enable :partial_underscores
    end

    #session
    configure do
      use Rack::Session::Cookie, :secret => SecureRandom.hex(64)
    end

    # view statics & flash & paginate
    configure do
      use Rack::Static, urls: ['/css', '/js', '/fonts', '/imgs'], root: 'public'
      use Rack::Flash, :accessorize => [:notice, :error]
    end

    # method override
    use Rack::MethodOverride

    # sequel
    environment = ENV['RACK_ENV'] || 'development'
    hash = YAML.load_file(root + '/config/database.yml')[environment]
    DB = Sequel.connect("mysql2://#{hash['username']}:#{hash['password']}@#{hash['host']}/#{hash['database']}", servers:{})
    DB.extension :pagination

    configure :development do
      register Sinatra::Reloader
      also_reload 'app/models/*.rb'
      also_reload 'app/routes/**/*.rb'
      use BetterErrors::Middleware
      BetterErrors.application_root = File.expand_path('..', __FILE__)
    end

    # These will be available for all Base subclasses
    helpers Sinatra::ContentFor
    helpers Shield::Helpers
    helpers Sinatra::Cookies

    helpers do
      # used to display a certain class in the menu buttons
      def is_in_current_path(real_path_info, spected_path_info)
        result = real_path_info =~ /#{spected_path_info}/
        !result.nil?
      end

      def current_path(options = {})
        if request.path_info.size > 3
          url = request.path_info.gsub(" ","+")
          "/#{options[:lang]}#{url}"
        else
          "/#{options[:lang]}"
        end
      end

      def link_to(text, url=nil, options={}, &block)
        url, text = text, capture_haml(&block) if url.nil?
        url = URI.encode(url)
        url = request.base_url + url unless URI(url).scheme
        capture_haml do
          haml_tag :a, text, options.merge(:href => url)
        end
      end

      def page
        if (params[:page]==0 || params[:page].blank? )
          page = 1
        else
          page = params[:page].to_i
        end
      end

      def display_paginate instances, url_index
        if instances.page_range.size > 1
          capture_haml do
            haml_tag :div, :class => "row" do
              haml_tag :div, :class => "col-md-2 col-lg-2"
              haml_tag :div, :class=> "col-md-8 col-lg-8" do
                haml_tag :ul, :class=> "pager" do
                  haml_tag :li, :class=> "previous #{ 'disabled' if instances.first_page? }" do
                    haml_tag :a, "&larr; Anterior", href: !instances.first_page? ? "#{url_index}?page=#{instances.prev_page}" : ""
                  end
                  haml_tag :li, :class=> "next #{ 'disabled' if instances.last_page? }" do
                    haml_tag :a, "Siguiente &rarr;", href: !instances.last_page? ? "#{url_index}?page=#{instances.next_page}" : ""
                  end
                end
              end
              haml_tag :div, :class=> "col-md-2 col-lg-2"
            end
          end
        end
      end
    end

    #FIXME: make a view
    not_found do
      "Not Found Base"
    end

    #FIXME: make a view
    error do
      "Error Base"
    end
  end
end
