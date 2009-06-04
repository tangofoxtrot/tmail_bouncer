module TmailBouncer
  class OutOfOfficeBouncer < Base
    
    def self.recognize?(email)
      if email.parts.size == 0
        email.subject =~ /Out of Office/
      end
    end

    def original_recipient
      @original_recipient ||= self.original_message.from.to_s
    end
    
    def status
      "Failure"
    end
    
  end
end