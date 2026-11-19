uint8 MODE_IDLE=0
uint8 MODE_EXTERNAL=1
uint8 MODE_JOYSTICK=2

uint8 BRAKE_UNKNOWN=0
uint8 BRAKE_RELEASED=1
uint8 BRAKE_ENGAGED=2

# Applied mode and confirmed brake state.
uint8 control_mode
uint8 brake_state

# Raw motor driver codes. Read each code only when its flag is true.
uint16 left_error_code
uint16 right_error_code
bool left_error_valid
bool right_error_valid
