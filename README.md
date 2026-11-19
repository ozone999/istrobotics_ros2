# IST Robotics ROS 2

ROS 2 Humble용 구동 베이스 패키지입니다. 이 저장소 하나에 구동 패키지와 외부 제어기 연동에 필요한 메시지 정의가 들어 있습니다.

> **개발 단계** · 현재는 패키지 골격과 인터페이스 정의 단계입니다. 주행·브레이크·조이스틱을 처리하는 드라이버 노드는 구현 예정입니다.

## 빠른 시작

Ubuntu 22.04에 ROS 2 Humble과 `colcon`이 설치된 환경에서 실행합니다.

```bash
git clone https://github.com/ozone999/istrobotics_ros2.git
cd istrobotics_ros2
source /opt/ros/humble/setup.bash
colcon build
source install/setup.bash
```

빌드한 메시지를 확인합니다.

```bash
ros2 interface show istrobotics_msgs/msg/DriveStatus
ros2 interface show istrobotics_msgs/msg/MotorRpmFeedback
```

## 공개 토픽

| 토픽 | 메시지 타입 | 발행 | 구독 | 용도 |
| --- | --- | --- | --- | --- |
| `/istrobotics/cmd_vel` | `geometry_msgs/msg/Twist` | sub controller | istrobotics | 전후진·회전 속도 명령 |
| `/istrobotics/cmd_joy_mode` | `std_msgs/msg/Bool` | sub controller | istrobotics | 내장 조이스틱(`true`) 또는 외부 속도 입력(`false`) 선택 |
| `/istrobotics/status` | [`istrobotics_msgs/msg/DriveStatus`](istrobotics_msgs/msg/DriveStatus.msg) | istrobotics | sub controller | 적용 모드, 실제 브레이크 상태, 좌우 모터 오류 |
| `/istrobotics/cmd_brake` | `std_msgs/msg/Bool` | sub controller | istrobotics | 체결(`true`) 또는 해제(`false`) 요청 |
| `/istrobotics/rpm_feedback` | [`istrobotics_msgs/msg/MotorRpmFeedback`](istrobotics_msgs/msg/MotorRpmFeedback.msg) | istrobotics | sub controller | 좌우 모터축의 실측 RPM과 유효 여부 |
| `/istrobotics/joy` | `sensor_msgs/msg/Joy` | istrobotics | sub controller | Axis 1·2는 `axes[0]`·`axes[1]`, Button 3~6은 `buttons[2]`~`buttons[5]` |

## 명령 예제

드라이버 구현 후 로봇에서 드라이버가 실행 중일 때 사용할 예제입니다. 외부 속도 입력을 요청한 다음 상태에서 `control_mode`가 `MODE_EXTERNAL`(`1`)인지 확인합니다.

```bash
ros2 topic pub --once /istrobotics/cmd_joy_mode std_msgs/msg/Bool '{data: false}'
ros2 topic echo /istrobotics/status --once
```

`cmd_vel`의 `linear.x`는 전후진 속도(m/s), `angular.z`는 회전 속도(rad/s)입니다. 다음은 두 값을 0으로 보내는 정지 요청입니다.

```bash
ros2 topic pub --once /istrobotics/cmd_vel geometry_msgs/msg/Twist '{linear: {x: 0.0}, angular: {z: 0.0}}'
ros2 topic echo /istrobotics/rpm_feedback --once
```

## 패키지 구성

| 폴더 | 역할 |
| --- | --- |
| [`istrobotics_base/`](istrobotics_base) | 구동 드라이버를 추가할 ROS 2 패키지 |
| [`istrobotics_msgs/`](istrobotics_msgs) | 구동 상태와 RPM 피드백 메시지 정의 |
