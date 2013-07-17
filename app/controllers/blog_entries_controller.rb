class BlogEntriesController < ApplicationController
  
    def overview
      @news = BlogEntry.order("updated_at DESC")
  end
  
end
