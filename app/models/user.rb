class User < ActiveRecord::Base
  
  authenticates_with_sorcery!
  
  has_one :person
  
  attr_accessible :username, :password, :password_confirmation, :email, :roles_mask, :roles
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :username
  validates_uniqueness_of :username
  validates_uniqueness_of :email
  
  has_one :agent
  accepts_nested_attributes_for :agent, :allow_destroy => true
  
  scope :with_role, lambda { |role| {:conditions => "roles_mask & #{2**ROLES.index(role.to_s)} > 0 "} }

  ROLES = %w[agent subscriber admin]

  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  def roles
    ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }
  end

  def role?(role)
    roles.include? role.to_s
  end
  
  # make an agent on create user
  def make_agent!
    @agent = Agent.new(:first_name => params[:first_name], 
              :last_name => params[:last_name], 
              :email => params[:email], 
              :agent_id => params[:id])
    @agent.save
  end
  
end
