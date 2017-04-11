module Obfuscate
  extend ActiveSupport::Concern

  # Inserted into the model file
  included do
    extend ::FriendlyId
    before_create :set_hash_id
    friendly_id :hash_id
  end

  # Sets unique hash id (obfuscate ID)
  def set_hash_id
    hash_id = nil
    loop do
      hash_id = SecureRandom.random_number(1000000000) + 1000
      break unless self.class.name.constantize.where(:hash_id => hash_id).exists?
    end
    self.hash_id = hash_id
  end

end
