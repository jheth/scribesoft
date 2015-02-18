module Scribesoft
  class Solutions
    include Scribesoft::Actions

    def clone(source_solution_id, dest_org_id, dest_agent_id)
      self.post_action("#{source_solution_id}/clone?destOrgId=#{dest_org_id}&destAgentId=#{dest_agent_id}")
    end

    def prepare(solution_id)
      self.post_action("#{solution_id}/prepare")
    end

    def is_prepared?(solution_id, prepare_id)
      self.get_action(solution_id, "prepare/#{prepare_id}")
    end

    def schedule(solution_id)
      self.get_action("#{solution_id}/schedule")
    end

    def update_schedule(solution_id, data)
      self.post_action("#{solution_id}/schedule", data)
    end

    def start(solution_id)
      self.post_action("#{solution_id}/start")
    end

    def stop(solution_id)
      self.post_action("#{solution_id}/stop")
    end

    def type
      'solutions'
    end

  end
end
