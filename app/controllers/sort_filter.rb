require "uri"

module SortFilter
    
    def clear_sessions *extra
        session["key"] = nil
        session["query"] = nil
        session["sort"] = nil
        extra.each {|ex| session[ex] = nil}
    end
    
    def sort_filter_params default
        get_key default[:key]
        get_query default[:query]
        get_sort default[:sort]
    end
    
    def get_key default
        @key = params["key"] || session["key"] || default || ""
        session["key"] = @key
    end
    
    def get_query default
        @query_ = params["query"] || session["query"] || default || ""
        session["query"] = @query_
        @query = Regexp.new(Regexp.escape(URI.decode(@query_)), "i")
    end
    
    def get_sort default
        @sort = params["sort"] || session["sort"] || default || ""
        if params["sort"] == session["sort"] # click on the same link second time to disable sorting
            session["sort"] = (@sort = "")
        else
            session["sort"] = @sort
        end
    end
    
end