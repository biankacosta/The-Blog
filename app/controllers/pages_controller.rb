class PagesController < ApplicationController
    def about
        @page_name = "ABOUT"
    end

    def projects
        @page_name = "PROJECTS"
    end
    
    def newsletter
        @page_name = "NEWSLETTER"
    end
end
