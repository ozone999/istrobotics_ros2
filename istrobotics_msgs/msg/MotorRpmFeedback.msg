# Time when the RPM sample was taken.
std_msgs/Header header

# Measured motor-shaft RPM. Positive values mean forward wheel motion on both sides.
int16 left_rpm
int16 right_rpm
bool left_valid
bool right_valid
