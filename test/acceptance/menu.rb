require_relative "../test_helper"

class SeghiniAppTest < AcceptanceTest

  describe 'App Menu' do
    it "shows a site" do
      visit '/'
      page.must_have_content 'Hola'
    end
  end

end
