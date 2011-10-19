module ActionDispatch
  class Request
    def api_asset
      self.path.gsub(/^\//, '').gsub(/\/$/, '')
    end

    def non_path_parameters
      self.query_parameters.merge(self.request_parameters)
    end
  end
end