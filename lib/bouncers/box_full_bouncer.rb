module TmailBouncer
  class BoxFullBouncer < Base
    
    def self.recognize?(email)
      if email.parts.size == 0
        email.body.split("\n")[0..3].detect {|line| line =~ /exceeding its mailbox quota/ }
      end
    end

    def original_recipient
      if @email.multipart?
        @original_recipient ||= self.status_info["Final-Recipient"].to_s.gsub(%r%Final-Recipient: %i,"").gsub(%r%rfc822;%i,"").strip
      else
        @original_recipient ||= self.original_message.body.split(' ').detect {|word| word.match(self.class.valid_email)}.to_s
      end
    end
    
    def status
      "Failure"
    end
    
  end
end