require 'piface'
require 'yaml'
require 'siri_objects'

class SiriProxy::Plugin::PiFace < SiriProxy::Plugin

############# Initialization

  def initialize(config = {})  
	@camUrl 	= Hash.new
	@camUrl 	= config["camurls"]
  end
  
######## PiFace IO

  begin
  	@@pfio = YAML.load(File.read(File.expand_path(File.dirname( __FILE__ ) + "/piface-ioconfig.yml")))
  rescue
  	puts "[Warning - Piface] Error reading piface-ioconfig.yml file."
  end
  
############# Commands

  listen_for (/(open|close) garage/i) do |command|
	command_garage command.downcase.strip
	request_completed
  end
  
  listen_for (/garage record/i) do 
	output_toggle("garage record")
	say "Recording garage camera."
	push_image("Garage Camera", @camUrl["garage"])
	request_completed
  end
  			
############# Actions

  def command_garage(command)
	push_image("Garage Camera", @camUrl["garage"])
	status = input_status("garage door")
	if (status == "closed" && command == "open")
		say "Opening your garage door."
		output_toggle("garage door")
	elsif (status == "open" && command == "close")
		response = ask "I would not want to cause injury or damage. Is the garage door clear?"
		if (response =~ /yes|yep|yeah|ok/i)
			say "Thank you. I am closing your garage door."
			output_toggle("garage door")
		else
			say "OK. I will not close your garage door."
		end
	else
		say "Your garage door is already #{status}, Cabrone."
  	end
  end
  
  def output_toggle(output)
	Piface.write @@pfio["outputs"][output], 1
	sleep 2
	Piface.write @@pfio["outputs"][output], 0
  end	

  def input_status(input)
  	state = Piface.read @@pfio["inputs"][input] 
	(state == 1) ? (status = "open") : (status = "closed")
	return status.downcase.strip
  end

  def push_image(title, image)
	object = SiriAddViews.new
	object.make_root(last_ref_id)
	answer = SiriAnswer.new(title, [SiriAnswerLine.new('logo', image)])
	object.views << SiriAnswerSnippet.new([answer])
	send_object object
  end		

 
end
