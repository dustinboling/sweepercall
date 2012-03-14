class User < ActiveRecord::Base
  
  authenticates_with_sorcery!
  
  attr_accessible :username, :password, :password_confirmation, :email, :roles_mask, :roles, :person_attributes, :agent_attributes, :agent_id
  
  validates_presence_of :password, :on => :create
  validates_confirmation_of :password
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_format_of :email, :with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/
  
  has_one :agent
  accepts_nested_attributes_for :agent, :allow_destroy => true
  
  has_one :person
  accepts_nested_attributes_for :person, :allow_destroy => true
  
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
  
end