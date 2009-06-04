module TmailBouncer
  class Base
    attr_accessor :status_info, :original_message_id, :original_sender, :original_recipient, :original_subject, :handling_server, :status_part, :original_message
    
    def initialize(email)
      @email = email  
    end

    def self.valid_email    
      /^[-^!$#%&\'*+\/=?`{|}~\w]                  # Valid starting character
      [-^!$#%&\'*+\/=?`{|}~.\w]*                  # Valid succeeding characters
      @
      [a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])*      # Domain
      (\.[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9]))*  # Subdomain
      (\.[a-zA-Z]([-a-zA-Z]?[a-zA-Z]))+$/x        # TLD (.com, .co.uk)
    end
    
    def self.available_bouncers
      @@bouncers ||= [TmailBouncer::StandardBouncer, TmailBouncer::BoxFullBouncer, TmailBouncer::OutOfOfficeBouncer]
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
    
    def determine_status_part
      @status_part = @email.parts.detect { |part| part.content_type == "message/delivery-status" }
      @status_part.nil? ? @email.header : parse_status_part
    end

    def parse_status_part
      statuses = @status_part.body.gsub("\n ","").split(/\n/)
      statuses.inject({}) do |hash,line|
        key,value = line.split(/:/,2)
        hash[key] = value.strip rescue nil
        hash
      end  
    end

    def determine_original_message_part
      @original_untouched =  @email.parts.detect do |part|
        part.content_type == "message/rfc822" || part.content_type == "text/rfc822-headers"
      end
      parse_original_message_part
    end

    def parse_original_message_part
      @email.multipart? ? TMail::Mail.parse(@original_untouched.body) : @email  
    end
    
    def original_message
      @original_message ||= determine_original_message_part
    end
    
    def original_message_id
      @original_message_id ||= self.original_message.message_id 
    end
    
    def original_subject
      @original_subject ||= self.original_message.subject
    end

    def original_sender
      @original_sender ||= @email.multipart? ? self.original_message.from.to_a.first : self.status_info['x-original-to'].body
    end

    def original_recipient
      @original_recipient ||= self.status_info["Final-Recipient"].to_s.gsub(%r%Final-Recipient: %i,"").gsub(%r%rfc822;%i,"").strip
    end

    def status_info
      @status_info ||= determine_status_part
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