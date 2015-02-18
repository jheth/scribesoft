module Scribesoft
  class Client
    include Scribesoft::Actions

    def agents
      self.get_all('agents')
    end

    def connections
      self.get_all('connections')
    end

    def connectors
      self.get_all('connectors')
    end

    def managedconnectors
      self.get_all('managedconnectors')
    end

    def organizations
      self.get_all('organizations')
    end

    def solutions
      self.get_all('solutions')
    end

    def subscriptions
      self.get_all('subscriptions')
    end

  end
end
