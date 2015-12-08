module Adapters
  class HidefyConnection
    include HTTParty

    attr_reader :connection

    def initialize
      @connection = self.class
    end

    def query(end_path)
        results = connection.get('http://snatchthat-rails-api.herokuapp.com/api/' + end_path)
    end

  end
end
