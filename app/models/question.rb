class Question < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :tags
  attr_accessible :question, :user_id
  has_many :documents, as: :documentable, :dependent => :destroy
  has_many :flags, as: :flagable, :dependent => :destroy
  has_many :answers
  validates_presence_of :question, :user_id
  validate :valid_user
  	def valid_user
  		if self.user_id.present?
	  		unless User.find_by_id(self.user_id).present?
	  			self.errors.add(:user_id, "not found!")
	  		end
	  	end
  	end
end