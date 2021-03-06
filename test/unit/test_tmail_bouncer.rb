require 'test_helper'

class TmailBouncerTest < Test::Unit::TestCase

  context "Yahoo Bounce" do    
    setup do
      @email = read_email('yahoo.eml')
    end
    
    should "be a tmail object" do
      assert @email.is_a?(TMail::Mail), "Whoops Im a #{@email.class}"
    end

    should "return StandardBouncer" do
      assert @email.undeliverable_info.is_a?(TmailBouncer::StandardBouncer) , "Whoops Im a #{@email.class}"
    end
    
    should "detect bounced" do
      assert_equal @email.undeliverable_info.status, "Failure"
    end
    
    should "detect original sender" do
      assert_equal @email.undeliverable_info.original_sender, "joe@example.com"      
    end
    
    should "detect original recipient" do
      assert_equal @email.undeliverable_info.original_recipient, "fred@somewhere.com"      
    end

    should "detect original subject" do
      assert_equal @email.undeliverable_info.original_subject, "I like turtles"            
    end    

    should "detect original_message_id" do
      assert_equal @email.undeliverable_info.original_message_id, "<1234.1212@example.com>"
    end
    
    should "return status of failure" do
      assert_equal "Failure",  @email.undeliverable_info.status
    end           
  end

  context "Yahoo Legit Email" do
  
    setup do
      @email = read_email('yahoo_legit.eml')
    end  
    

    should "be a tmail object" do
      assert @email.is_a?(TMail::Mail), "Whoops Im a #{@email.class}"
    end

    should "return NoBounce" do
      assert @email.undeliverable_info.is_a?(TmailBouncer::NoBouncer) , "Whoops Im a #{@email.class}"
    end

    should "return status of Success" do
      assert_equal "Success",  @email.undeliverable_info.status
    end 
                    
  end


  context "AOL Bounce" do    
    setup do
      @email = read_email('aol.eml')
    end
    
    should "be a tmail object" do
      assert @email.is_a?(TMail::Mail), "Whoops Im a #{@email.class}"
    end

    should "return StandardBouncer" do
      assert @email.undeliverable_info.is_a?(TmailBouncer::StandardBouncer) , "Whoops Im a #{@email.class}"
    end
    
    should "detect bounced" do
      assert_equal @email.undeliverable_info.status, "Failure"
    end
    
    should "detect original sender" do
      assert_equal @email.undeliverable_info.original_sender, "joe@example.com"      
    end
    
    should "detect original recipient" do
      assert_equal @email.undeliverable_info.original_recipient, "fred@aol.com"      
    end
    
    should "detect original subject" do
      assert_equal @email.undeliverable_info.original_subject, "I like turtles"            
    end    
    
    should "detect original_message_id" do
      assert_equal @email.undeliverable_info.original_message_id, "<1234.1212@example.com>"
    end
    
    should "return status of failure" do
      assert_equal "Failure",  @email.undeliverable_info.status
    end           
  end
  
  context "Box Full Bounce" do    
    setup do
      @email = read_email('box_full.eml')
    end
    
    should "be a tmail object" do
      assert @email.is_a?(TMail::Mail), "Whoops Im a #{@email.class}"
    end

    should "return BoxFullBouncer" do
      assert @email.undeliverable_info.is_a?(TmailBouncer::BoxFullBouncer) , "Whoops Im a #{@email.class}"
    end
    
    should "detect bounced" do
      assert_equal @email.undeliverable_info.status, "Failure"
    end
    
    should "detect original sender" do
      assert_equal @email.undeliverable_info.original_sender, "joe@example.com"      
    end
    
    should "detect original recipient" do
      assert_equal @email.undeliverable_info.original_recipient, "fred@example.com"      
    end
    
    should "detect original subject" do
      assert_equal @email.undeliverable_info.original_subject, "I like turtles"            
    end    
    
    should "detect original_message_id" do
      assert_equal @email.undeliverable_info.original_message_id, "<1234.1212@example.com>"
    end
    
    should "return status of failure" do
      assert_equal "Failure",  @email.undeliverable_info.status
    end           
  end

  context "Out of Office Bounce" do    
    setup do
      @email = read_email('out_of_office.eml')
    end
    
    should "be a tmail object" do
      assert @email.is_a?(TMail::Mail), "Whoops Im a #{@email.class}"
    end

    should "return OutOfOfficeBouncer" do
      assert @email.undeliverable_info.is_a?(TmailBouncer::OutOfOfficeBouncer) , "Whoops Im a #{@email.class}"
    end
    
    should "detect bounced" do
      assert_equal @email.undeliverable_info.status, "Failure"
    end
    
    should "detect original sender" do
      assert_equal @email.undeliverable_info.original_sender, "joe@example.com"      
    end
    
    should "detect original recipient" do
      assert_equal @email.undeliverable_info.original_recipient, "fred@example.com"      
    end
    
    should "detect original subject" do
      assert_equal @email.undeliverable_info.original_subject, "Out of Office: I like turtles"            
    end    
    
    should "detect original_message_id" do
      assert_equal @email.undeliverable_info.original_message_id, "<1234.1212@example.com>"
    end
    
    should "return status of failure" do
      assert_equal "Failure",  @email.undeliverable_info.status
    end          
  end

  context "Legit Email with quota words" do
  
    setup do
      @email = read_email('legit_with_quota.eml')
    end  
    

    should "be a tmail object" do
      assert @email.is_a?(TMail::Mail), "Whoops Im a #{@email.class}"
    end

    should "return NoBounce" do
      assert @email.undeliverable_info.is_a?(TmailBouncer::NoBouncer) , "Whoops Im a #{@email.class}"
    end

    should "return status of Success" do
      assert_equal "Success",  @email.undeliverable_info.status
    end 
                    
  end


  context "Legit Multipart Email" do
  
    setup do
      @email = read_email('legit_multipart.eml')
    end  

    should "be a tmail object" do
      assert @email.is_a?(TMail::Mail), "Whoops Im a #{@email.class}"
    end

    should "return NoBounce" do
      assert @email.undeliverable_info.is_a?(TmailBouncer::NoBouncer) , "Whoops Im a #{@email.class}"
    end

    should "return status of Success" do
      assert_equal "Success",  @email.undeliverable_info.status
    end 
                    
  end

  context "Verizon Bounce" do    
    setup do
      @email = read_email('verizon.eml')
    end
    
    should "be a tmail object" do
      assert @email.is_a?(TMail::Mail), "Whoops Im a #{@email.class}"
    end

    should "return StandardBouncer" do
      assert @email.undeliverable_info.is_a?(TmailBouncer::StandardBouncer) , "Whoops Im a #{@email.class}"
    end
    
    should "detect bounced" do
      assert_equal @email.undeliverable_info.status, "Failure"
    end
    
    should "detect original sender" do
      assert_equal @email.undeliverable_info.original_sender, "joe@example.com"      
    end
    
    should "detect original recipient" do
      assert_equal @email.undeliverable_info.original_recipient, "fred@somewhere.com"      
    end

    should "detect original subject" do
      assert_equal @email.undeliverable_info.original_subject, "I like turtles"            
    end    

    should "detect original_message_id" do
      assert_equal @email.undeliverable_info.original_message_id, "<1234.1212@example.com>"
    end
    
    should "return status of failure" do
      assert_equal "Failure",  @email.undeliverable_info.status
    end           
  end


protected

  def read_email(name)
    TMail::Mail.parse(File.read('test/fixtures/' + name))
  end
end
