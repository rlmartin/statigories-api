class ApiKey < ActiveRecord::Base
  belongs_to :partner
  validates_uniqueness_of :public

  before_save :generate_keys
  after_rollback :regenerate_keys_if_not_unique

  def generate_keys
    self.public = Util.generate_random_string(20, "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ".split(''))
    self.private = Util.generate_random_string(40, "0123456789abcedfghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ".split(''))
  end

  def regenerate_keys_if_not_unique
    unless self.errors[:public].nil?
      self.public = Util.generate_random_string(20, "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ".split(''))
      self.save
    end
  end
end
