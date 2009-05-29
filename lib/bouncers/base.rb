module TmailBouncer
  class Base
    attr_accessor :status_info, :original_message_id, :original_sender, :original_recipient, :original_subject, :handling_server, :status_part, :original_message

    
    def initialize(email)
      @email = email
      determine_status_part
      determine_original_message_part
      parse_status_part
      parse_original_message_part    
      parse_original_recipient
      parse_original_sender 
      parse_original_subject     
    end
    
    def self.available_bouncers
      @@bouncers ||= [TmailBouncer::StandardBouncer]
    end 


    def self.determine_bouncer(email)
      if klass = available_bouncers.find {|bouncer| bouncer.recognize? email}
        klass.new(email)
      else
        TmailBouncer::NoBouncer.new
      end
    end 
 
    def self.from_email(email)
      bounce = determine_bouncer(email)
      # lets start by trying to extract the message/delivery-status part
      
      bounce
    end

    def status
      case status_info['Status']
      when /^5/
        'Failure'
      when /^4/
        'Temporary Failure'
      when /^2/
        'Success'
      end
    end


    # def determine_status_part
    # end
    # 
    # def determine_original_message_part
    # end
    # 
    # def parse_status_part
    # end
    # 
    # def parse_original_message_part
    #  
    # end

    
  end
      
  def undeliverable_info
    TmailBouncer::Base.from_email(self)
  end
  
end