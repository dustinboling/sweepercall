require "spec_helper"

describe SweepMailer do
  describe "sweep_notification (with agent assignment)" do
    let(:user) { Factory(:user, :email => "agents_email@example.com") }
    let(:agent) { Factory(:agent, :user_id => user.id, :outgoing_email => user.email, :id => 999) }
    
    let(:person) { Factory(:person, :email => "test7@dustinboling.com", :agent_id => 999) }
    let(:mail) { SweepMailer.sweep_notification(person, agent) }

    it "sends a sweep notification" do
      mail.subject.should eq("SweeperCall Notification")
      mail.to.should include(person.email)
    end
    
    it "says it is coming from the agent's email when an agent is assigned" do
      mail.from.should include(User.find(agent.user_id).email) 
    end


    it "includes an agent message when an agent is assigned to the person" do
      # not doing this at the moment
    end

  end

  describe "sweep_notification (without agent assignment)" do
    let(:user) { Factory(:user) }
    let(:person) { Factory(:person, :user_id => user.id, :agent_id => 12, :email => "test7@dustinboling.com") }
    let(:agent) { Factory(:agent, :id => 12) }
    let(:mail) { SweepMailer.sweep_notification(person, agent) }

    it "sends a sweep notification" do
      mail.subject.should eq("SweeperCall Notification")
      mail.to.should include(person.email)
    end

    it "says it is coming from mailer@sweepercall.com when it is coming from us" do
      mail.from.should include("mailer@sweepercall.com")
    end

    it "does not include agent message when an agent is not assigned (agent_id = 12)" do
      # not doing this at the moment
    end
  end
end
