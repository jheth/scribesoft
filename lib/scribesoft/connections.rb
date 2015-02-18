module Scribesoft
  class Connections
    include Scribesoft::Actions

    def create(model)
      self.post(model)
    end

    def reset(connection_id)
      self.post_action("#{connection_id}/reset")
    end

    def test(connection_id, agent_id)
      self.post_action("#{connection_id}/test?agentId=#{agent_id}")
    end

    def status(command_id)
      self.get_action(id='', "test/#{command_id}")
    end

    def type
      'connections'
    end

  end
end
