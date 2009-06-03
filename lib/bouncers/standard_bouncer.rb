module TmailBouncer
  class StandardBouncer < Base
    
    def self.recognize?(email)
      email.parts.detect do |part|
        part.content_type == "message/delivery-status"
      end
    end
    
  end
end