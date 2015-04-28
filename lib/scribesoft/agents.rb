module Scribesoft
  class Agents
    include Scribesoft::Actions

    def provision_cloud_agent
      self.post_action(nil, 'provision_cloud_agent')
    end

    def provision_onpremise_agent
      self.post_action(nil, 'provision_onpremise_agent')
    end

    def type
      'agents'
    end

  end
end
