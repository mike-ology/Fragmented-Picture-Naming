#
# Note: This experiment uses the new survey function introduced
# in Presentation 21.0. The experiment will not run on earlier
# versions. Picture stimuli are from the Snodgrass dataset.

# HEADER #

scenario = "Fragmented Pictures 2019";
active_buttons = 1;
response_logging = log_active;
no_logfile = true; # default logfile not created
response_matching = simple_matching;
default_background_color = 0, 0, 0;
default_font = "Arial";
default_font_size = 36;
default_text_color = 255, 255, 255;
default_formatted_text = true;

begin;

$stimulus_interval = 500;
$font_h = default_font_size;

picture {
	text {
		caption = "+";
	};
	x = 0; y = 0;
}pic_fixation;

trial {
	trial_duration = $stimulus_interval;
	trial_type = specific_response;
	terminator_button = 1;
	all_responses = false;

	stimulus_event {
		picture {} trial_pic;
		duration = next_picture;
		response_active = true;
		code = "SET CODE";
#		target_button = 1;
	}trial_event;
}trial1;

trial {
	trial_duration = stimuli_length;
	trial_type = specific_response;
	terminator_button = 1;
	all_responses = false;

	stimulus_event {
		picture {
			text {
				caption = "+";
			};
			x = 0; y = 0;
		};
		time = 0;
		duration = next_picture;
		response_active = false;
	}fixation;
	
	stimulus_event {
		picture { description = "7"; } level7;
		delta_time = '$stimulus_interval';
		duration = next_picture;
		response_active = true;
		code = "7";
#		target_button = 1;
	};

	stimulus_event {
		picture { description = "6"; } level6;
		delta_time = '$stimulus_interval';
		duration = next_picture;
		response_active = true;
		code = "6";
#		target_button = 1;
	};

	stimulus_event {
		picture { description = "5"; } level5;
		delta_time = '$stimulus_interval';
		duration = next_picture;
		response_active = true;
		code = "5";
#		target_button = 1;
	};

	stimulus_event {
		picture { description = "4"; } level4;
		delta_time = '$stimulus_interval';
		duration = next_picture;
		response_active = true;
		code = "4";
#		target_button = 1;
	};

	stimulus_event {
		picture { description = "3"; } level3;
		delta_time = '$stimulus_interval';
		duration = next_picture;
		response_active = true;
		code = "3";
#		target_button = 1;
	};

	stimulus_event {
		picture { description = "2"; } level2;
		delta_time = '$stimulus_interval';
		duration = next_picture;
		response_active = true;
		code = "2";
#		target_button = 1;
	};

	stimulus_event {
		picture { description = "1"; } level1;
		delta_time = '$stimulus_interval';
		duration = next_picture;
		response_active = true;
		code = "1";
#		target_button = 1;
	};

	stimulus_event {
		picture { description = "0"; } level0;
		delta_time = '$stimulus_interval';
		duration = next_picture;
		response_active = true;
		code = "0";
#		target_button = 1;
	};

	stimulus_event {
		picture {} ;
		delta_time = '$stimulus_interval';
		duration = $stimulus_interval;
		response_active = false;
	};
	
}main_trial;

survey {
	color_scheme = dark_mode;
	margin_percentage = 10.0;
	prompt_align = align_center;
	prompt_position =  0, 400;
	response_align = align_center;
	response_position = 0, -100;
	response_font_color = 255, 255, 0;

	text_box {
		code = "Participant Answer";
		prompt = "Please enter your response now";
		submit_caption = "Click here or press ENTER to submit your answer";
	} trial_answer;
	
}surv;

picture {
	text {
		caption = "TIME UP!";
		font_color = 255, 0, 0;
	};
	x = 0; y = 0;
}pic_timeup;

begin_pcl;

#XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
# User Setup

# User parameters for screen dimension
# Enter desired screen dimensions. Screens not set to these dimensions may be scaled
double req_screen_x = 1920.0;
double req_screen_y = 1080.0;
bool attempt_scaling_procedure = true;

# User parameters for logfile generation
# If filename already exists, a new file is created with an appended number
# Logfile may be optionally created on local disk (when running from network location)
string local_path = "C:/Presentation Output/Fragmented Picture 2019/";
string filename_prefix = "FP - Participant ";
string use_local_save = parameter_manager.get_string( "Use Local Save", "NO" );

#######################

# Load PCL code and subroutines from other files
include "sub_generate_prompt.pcl";
include "sub_screen_scaling.pcl";
include "sub_logfile_saving.pcl";

# Run start-up subroutines
if attempt_scaling_procedure == false then screen_check() else end;
create_logfile();


# Setup complete
#XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX


# ! setup logfile
# Logfile Header	
log.print("Fragmented Picture Naming Task\n");
log.print("Participant ");
log.print( participant );
log.print("\n");
log.print( date_time() );
log.print("\n");
log.print( "Scale factor: " + string( scale_factor ) );
log.print("\n");
log.print( "Exposure time: " + string( parameter_manager.get_int( "Trial Duration", 1000 ) ) );
log.print("\n\n");

# Logfile Table
log.print("Block\t");
log.print("Trial\t");
log.print("Obj\t" ); 
log.print("Level\t"); 
log.print("Rspns.\t");
log.print("Crrct.\t" );
log.print("\n");

array <string> stimulus_array [15][10] = { 
{"Clock",	"Anchor",	"Eye",		"Desk",		"Pear",		"Frog",		"Arrow",		"Snake",		"Pelican",	"Headphones"},
{"Chain",	"Can",		"Bowl",		"Banana",	"Couch",		"Snail",		"Airplane",	"Bird",		"Ladle",		"Barrel"		},
{"Knife",	"Horseshoe","Ruler",		"Refrigerator","Pig",	"Flag",		"Candle",	"Truck",		"Rhinoceros","Camera" 	},
{"Swing",	"Axe",		"Bear",		"Seahorse",	"Penguin",	"Tree",		"Clothes",	"Bicycle",	"Helicopter","TrafficLight" 	},
{"Barn",		"Door",		"Drum",		"Arm",		"Peanut",	"Lamp",		"Wolf",		"Window",	"Balloon",	"Plug" 		},
{"Sheep",	"Scissors",	"Bat",		"Coat",		"Pen",		"Bus",		"Lizard",	"Telescope","Platypus",	"Wrench" 	},
{"Monkey",	"Cloud",		"Sock",		"Leaf",		"Owl",		"Worm",		"Thumb",		"Feather",	"Whistle",	"Foot" 		},
{"Chicken",	"Bow",		"Beetle",	"Pencil",	"Shark",		"Swan",		"Tiger",		"Doorknob",	"Stool",		"Turtle" 	},
{"Eagle",	"Bench",		"Duck",		"Baseball",	"Safe",		"Dog",		"Jar",		"Lion",		"Spoon",		"Fishbowl" 	},
{"Motorcycle","Fish",	"Lemon",		"Fence",		"Toothbrush","WateringCan","Apple",	"Glove",		"Car",		"Piano" 		},
{"Screwdriver","Glass",	"Peas",		"Peacock",	"Key",		"Rabbit",	"Bottle",	"Whale",		"Palmtree",	"Igloo" 		},
{"Finger",	"Binoculars","Hanger",	"Bee",		"Fryingpan","Octopus",	"Basket",	"Train",		"Ironingboard","Glasses"},
{"Mushroom","Screw",		"Hat",		"WashingMachine","Flower","Boot",	"Book",		"Avocado",	"Belt",		"Vase" 		},
{"Button",	"Elephant",	"Comb",		"Bell",		"Pineapple","Table",		"Koala",		"Skeleton",	"Crab",		"Pyramid"},
{"Rope",		"Cup",		"Starfish",	"Hamburger","Lightbulb","Chair",		"Strawberry","Leg",		"Cow",		"TennisRaquet" 	}
};

array <bitmap> trial_array [10][8];

loop
	int block = 1
until
	block > stimulus_array.count()
begin

	# First loop - load images and store fragment images for block in trial_array
	
	loop
		int object = 1
	until
		object > stimulus_array[block].count()
	begin
		
		# ! insert loading screen
		
		loop
			int fragment = 1
		until
			fragment > 8
		begin
			trial_array[object][fragment] = (new bitmap( stimulus_array[block][object] + string( fragment-1 ) + ".bmp" ) );
			trial_array[object][fragment].set_load_size( 0, 0, scale_factor );
			trial_array[object][fragment].load();
			
			fragment = fragment + 1;
		end;
			
		object = object + 1;
	end;
	
	# Second loop - present images from trial_array
	
	loop
		int object = 1
	until
		object > stimulus_array[block].count()
	begin

		loop
			int fragment = 1
		until
			fragment > trial_array[object].count()
		begin
			trial_pic.clear();
			trial_pic.add_part( trial_array[object][abs(fragment-9)], 0, 0 );
			trial_event.set_event_code( string( abs(fragment-8) ));
			trial1.present();
			
			stimulus_data last_stimulus = stimulus_manager.last_stimulus_data();

			if last_stimulus.button() == 0 then
				# no response made
			else
				# present survey
				break
			end;
			
			fragment = fragment + 1;
		end;
			
		stimulus_data last_stimulus = stimulus_manager.last_stimulus_data();
		term.print_line("Active stim count:" + string(stimulus_manager.stimulus_count() ) );
		term.print_line("Level pressed:" + last_stimulus.event_code() );
		term.print_line("Button pressed:" + string(last_stimulus.button()) );
		term.print_line("Reaction Time:" + string(last_stimulus.reaction_time()) );
		term.print_line("Stimulus Type:" + last_stimulus.stimulus_type() );

		string trial_response;
 
		if last_stimulus.button() == 0 then
			# no response made
			trial_response = "NONE";
			pic_timeup.present();
			wait_interval( 1000 );
		else
			# present survey
			surv.run();
			survey_data last_survey = survey_data( stimulus_manager.last_stimulus_data() );
			trial_response = last_survey.text_box_response();
				
		end;

		string is_correct;
		if trial_response == stimulus_array[block][object] then
			is_correct = "YES"
		elseif trial_response == "NONE" then
			is_correct = "TIMEUP"
		else
			is_correct = "CHECK"
		end;

		log.print(block); log.print("\t");
		log.print(object);  log.print("\t");
		log.print(stimulus_array[block][object]);  log.print("\t");
		log.print(last_stimulus.event_code());  log.print("\t");
		log.print(trial_response); log.print("\t");
		log.print(is_correct); log.print("\n");
		
		create_new_prompt(1);
		prompt_message.set_caption( "The correct answer was: " + stimulus_array[block][object], true);
		prompt_pic.add_part( trial_array[object][1], 0, 200 );
		prompt_pic.set_part_y( 1, -100.0 );
		mid_button_text.set_caption( "Press " + response_manager.button_name( 1, false, true ) + " to start the next trial", true );

		prompt_trial.present();
			
		object = object + 1;
	end;
	
	# Third loop - unload images from memory
	
	
	loop
		int object = 1
	until
		object > stimulus_array[block].count()
	begin
		
		loop
			int fragment = 1
		until
			fragment > 8
		begin
			trial_array[object][fragment].unload();
			fragment = fragment + 1;
		end;
			
		object = object + 1;
	end;
	
	# ! insert end of block message
	
	block = block + 1;
end;

#########################################################
# Subroutine to copy logfile back to the default location
# Requires the strings associated with:
#	[1] the local file path
#	[2] the file name
#	[3] if save operation is to be performed ("YES"/"NO") 

bool copy_success = sub_save_to_network( local_path, filename, use_local_save );	

if copy_success == true then
	prompt_message.set_caption( "End of experiment! Thank you!\n\nPlease notify the experimenter.\n\n<font color = '0,255,0'>LOGFILE WAS SAVED TO DEFAULT LOCATION</font>", true )
elseif copy_success == false then
	prompt_message.set_caption( "End of experiment! Thank you!\n\nPlease notify the experimenter.\n\n<font color = '255,0,0'>LOGFILE WAS SAVED TO:\n</font>" + local_path, true );
else
end;

#########################################################
create_new_prompt( 1 );

if parameter_manager.configuration_name() == "Mobile / Touchscreen" then
	mid_button_text.set_caption( "CLOSE PROGRAM", true );
	prompt_trial.set_terminator_buttons( { 3, 4, 5 } );
else
	mid_button_text.set_caption( "CLOSE PROGRAM [" + response_manager.button_name( 1, false, true ) + "]", true );
	prompt_trial.set_terminator_button( 1 );
end;

prompt_trial.present();
