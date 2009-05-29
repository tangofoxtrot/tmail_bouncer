module TmailBouncer
  class StandardBouncer < Base
    
    def self.recognize?(email)
      email.parts.detect do |part|
        part.content_type == "message/delivery-status"
      end
    end
    
    def determine_status_part
      self.status_part = @email.parts.detect { |part| part.content_type == "message/delivery-status" }
    end

    def determine_original_message_part
      self.original_message = @email.parts.detect do |part|
        part.content_type == "message/rfc822"
      end      
    end


    def parse_status_part
      statuses = self.status_part.body.gsub("\n ","").split(/\n/)
      self.status_info = statuses.inject({}) do |hash,line|
        key,value = line.split(/:/,2)
        hash[key] = value.strip rescue nil
        hash
      end  
    end

    def parse_original_message_part
      self.original_message = TMail::Mail.parse(self.original_message.body)
      self.original_message_id = self.original_message.message_id      
    end
    
    def parse_original_recipient
      self.original_recipient = self.status_info["Final-Recipient"].to_s.gsub("Final-Recipient: ","").gsub("rfc822;","").strip
    end

    def parse_original_sender
      self.original_sender = self.original_message.from.to_a.first
    end

    def parse_original_subject
      self.original_subject = self.original_message.subject
    end
    
  end
end