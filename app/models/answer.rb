class Answer < ActiveRecord::Base
  # attr_accessible :title, :body
	belongs_to :question, counter_cache: true
	belongs_to :user
	has_many :documents, as: :documentable
	has_many :flags, as: :flagable, :dependent => :destroy
	has_many :comments, :dependent => :destroy
	attr_accessible :answer, :user_id, :question_id
	validates :answer, :presence => true
	validates_presence_of :user_id
  	validates_presence_of :question_id
  	validate :valid_user, :valid_question

  	def valid_user
		if self.user_id.present?
			unless User.find_by_id(self.user_id).present?
				self.errors.add(:user_id, "not found!")
			end
		end
	end

	def valid_question
		if self.question_id.present?
			unless Question.find_by_id(self.question_id).present?
				self.errors.add(:question_id, "not found!")
			end
		end
	end
end
