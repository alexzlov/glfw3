! Copyright (C) 2014 alex_zlov
! See http://factorcode.org/license.txt for BSD license.
USING: alien alien.c-types alien.libraries alien.parser alien.syntax
       alien.strings system combinators io.encodings.utf8 ;

IN: glfw3

<< "glfw3" {
    { [ os windows? ] [ "glfw3.dll" ] }
    { [ os macosx?  ] [ "libglfw3.3.0.dylib" ] }
    { [ os unix?    ] [ "libglfw.so.3.0" ] }
} cond cdecl add-library >>

LIBRARY: glfw3

! ====================================================================================
!                                 GLFW API TOKENS
! ====================================================================================
CONSTANT: GLFW_VERSION_MAJOR        3
CONSTANT: GLFW_VERSION_MINOR        0
CONSTANT: GLFW_VERSION_REVISION     4
CONSTANT: GLFW_RELEASE              0
CONSTANT: GLFW_PRESS                1
CONSTANT: GLFW_REPEAT               2
! ------------------------------------------------------------------------------------
! The unknown key
CONSTANT: GLFW_KEY_UNKNOWN         -1
! ------------------------------------------------------------------------------------
! Printable keys
CONSTANT: GLFW_KEY_SPACE           32           CONSTANT: GLFW_KEY_E               69
CONSTANT: GLFW_KEY_APOSTROPHE      39           CONSTANT: GLFW_KEY_F               70
CONSTANT: GLFW_KEY_COMMA           44           CONSTANT: GLFW_KEY_H               72
CONSTANT: GLFW_KEY_MINUS           45           CONSTANT: GLFW_KEY_I               73
CONSTANT: GLFW_KEY_PERIOD          46           CONSTANT: GLFW_KEY_J               74
CONSTANT: GLFW_KEY_SLASH           47           CONSTANT: GLFW_KEY_K               75
CONSTANT: GLFW_KEY_0               48           CONSTANT: GLFW_KEY_L               76
CONSTANT: GLFW_KEY_1               49           CONSTANT: GLFW_KEY_M               77
CONSTANT: GLFW_KEY_2               50           CONSTANT: GLFW_KEY_N               78
CONSTANT: GLFW_KEY_3               51           CONSTANT: GLFW_KEY_O               79
CONSTANT: GLFW_KEY_4               52           CONSTANT: GLFW_KEY_P               80
CONSTANT: GLFW_KEY_5               53           CONSTANT: GLFW_KEY_Q               81
CONSTANT: GLFW_KEY_6               54           CONSTANT: GLFW_KEY_R               82
CONSTANT: GLFW_KEY_7               55           CONSTANT: GLFW_KEY_S               83
CONSTANT: GLFW_KEY_8               56           CONSTANT: GLFW_KEY_T               84
CONSTANT: GLFW_KEY_9               57           CONSTANT: GLFW_KEY_U               85
CONSTANT: GLFW_KEY_SEMICOLON       59           CONSTANT: GLFW_KEY_V               86
CONSTANT: GLFW_KEY_EQUAL           61           CONSTANT: GLFW_KEY_W               87
CONSTANT: GLFW_KEY_A               65           CONSTANT: GLFW_KEY_X               88
CONSTANT: GLFW_KEY_B               66           CONSTANT: GLFW_KEY_Y               89
CONSTANT: GLFW_KEY_C               67           CONSTANT: GLFW_KEY_Z               90
CONSTANT: GLFW_KEY_D               68

CONSTANT: GLFW_KEY_LEFT_BRACKET    91  ! [
CONSTANT: GLFW_KEY_BACKSLASH       92
CONSTANT: GLFW_KEY_RIGHT_BRACKET   93  ! ]
CONSTANT: GLFW_KEY_GRAVE_ACCENT    96  ! `
CONSTANT: GLFW_KEY_WORLD_1         161 ! non-US #1
CONSTANT: GLFW_KEY_WORLD_2         162 ! non-US #2
! ------------------------------------------------------------------------------------
! Function keys
CONSTANT: GLFW_KEY_ESCAPE          256          CONSTANT: GLFW_KEY_KP_3            323
CONSTANT: GLFW_KEY_ENTER           257          CONSTANT: GLFW_KEY_KP_4            324
CONSTANT: GLFW_KEY_TAB             258          CONSTANT: GLFW_KEY_KP_5            325
CONSTANT: GLFW_KEY_BACKSPACE       259          CONSTANT: GLFW_KEY_KP_6            326
CONSTANT: GLFW_KEY_INSERT          260          CONSTANT: GLFW_KEY_KP_7            327
CONSTANT: GLFW_KEY_DELETE          261          CONSTANT: GLFW_KEY_KP_8            328
CONSTANT: GLFW_KEY_RIGHT           262          CONSTANT: GLFW_KEY_KP_9            329
CONSTANT: GLFW_KEY_LEFT            263          CONSTANT: GLFW_KEY_KP_DECIMAL      330
CONSTANT: GLFW_KEY_DOWN            264          CONSTANT: GLFW_KEY_KP_DIVIDE       331
CONSTANT: GLFW_KEY_UP              265          CONSTANT: GLFW_KEY_KP_MULTIPLY     332
CONSTANT: GLFW_KEY_PAGE_UP         266          CONSTANT: GLFW_KEY_KP_SUBSTRACT    333
CONSTANT: GLFW_KEY_PAGE_DOWN       267          CONSTANT: GLFW_KEY_KP_ADD          334
CONSTANT: GLFW_KEY_HOME            268          CONSTANT: GLFW_KEY_KP_ENTER        335
CONSTANT: GLFW_KEY_END             269          CONSTANT: GLFW_KEY_KP_EQUAL        336
CONSTANT: GLFW_KEY_CAPS_LOCK       280          CONSTANT: GLFW_KEY_LEFT_SHIFT      340
CONSTANT: GLFW_KEY_SCROLL_LOCK     281          CONSTANT: GLFW_KEY_LEFT_CONTROL    341
CONSTANT: GLFW_KEY_NUM_LOCK        282          CONSTANT: GLFW_KEY_LEFT_ALT        342
CONSTANT: GLFW_KEY_PRINT_SCREEN    283          CONSTANT: GLFW_KEY_LEFT_SUPER      343
CONSTANT: GLFW_KEY_PAUSE           284          CONSTANT: GLFW_KEY_RIGHT_SHIFT     344
CONSTANT: GLFW_KEY_F1              290          CONSTANT: GLFW_KEY_RIGHT_CONTROL   345
CONSTANT: GLFW_KEY_F2              291          CONSTANT: GLFW_KEY_RIGHT_ALT       346
CONSTANT: GLFW_KEY_F3              292          CONSTANT: GLFW_KEY_RIGHT_SUPER     347
CONSTANT: GLFW_KEY_F4              293          CONSTANT: GLFW_KEY_MENU            348
CONSTANT: GLFW_KEY_F5              294          CONSTANT: GLFW_KEY_LAST            GLFW_KEY_MENU
CONSTANT: GLFW_KEY_F6              295          CONSTANT: GLFW_MOD_SHIFT           0x0001
CONSTANT: GLFW_KEY_F7              296          CONSTANT: GLFW_MOD_CONTROL         0x0002
CONSTANT: GLFW_KEY_F8              297          CONSTANT: GLFW_MOD_ALT             0x0004
CONSTANT: GLFW_KEY_F9              298          CONSTANT: GLFW_MOD_SUPER           0x0008
CONSTANT: GLFW_KEY_F10             299          CONSTANT: GLFW_MOUSE_BUTTON_1      0
CONSTANT: GLFW_KEY_F11             300          CONSTANT: GLFW_MOUSE_BUTTON_2      1
CONSTANT: GLFW_KEY_F12             301          CONSTANT: GLFW_MOUSE_BUTTON_3      2
CONSTANT: GLFW_KEY_F13             302          CONSTANT: GLFW_MOUSE_BUTTON_4      3
CONSTANT: GLFW_KEY_F14             303          CONSTANT: GLFW_MOUSE_BUTTON_5      4
CONSTANT: GLFW_KEY_F15             304          CONSTANT: GLFW_MOUSE_BUTTON_6      5
CONSTANT: GLFW_KEY_F16             305          CONSTANT: GLFW_MOUSE_BUTTON_7      6
CONSTANT: GLFW_KEY_F17             306          CONSTANT: GLFW_MOUSE_BUTTON_8      7
CONSTANT: GLFW_KEY_F18             307          CONSTANT: GLFW_MOUSE_BUTTON_LAST   GLFW_MOUSE_BUTTON_8
CONSTANT: GLFW_KEY_F19             308          CONSTANT: GLFW_MOUSE_BUTTON_LEFT   GLFW_MOUSE_BUTTON_1
CONSTANT: GLFW_KEY_F20             309          CONSTANT: GLFW_MOUSE_BUTTON_RIGHT  GLFW_MOUSE_BUTTON_2
CONSTANT: GLFW_KEY_F21             310          CONSTANT: GLFW_MOUSE_BUTTON_MIDDLE GLFW_MOUSE_BUTTON_3
CONSTANT: GLFW_KEY_F22             311
CONSTANT: GLFW_KEY_F23             312
CONSTANT: GLFW_KEY_F24             313
CONSTANT: GLFW_KEY_F25             314
CONSTANT: GLFW_KEY_KP_0            320
CONSTANT: GLFW_KEY_KP_1            321
CONSTANT: GLFW_KEY_KP_2            322

CONSTANT: GLFW_JOYSTICK_1           0
CONSTANT: GLFW_JOYSTICK_2           1
CONSTANT: GLFW_JOYSTICK_3           2
CONSTANT: GLFW_JOYSTICK_4           3
CONSTANT: GLFW_JOYSTICK_5           4
CONSTANT: GLFW_JOYSTICK_6           5
CONSTANT: GLFW_JOYSTICK_7           6
CONSTANT: GLFW_JOYSTICK_8           7
CONSTANT: GLFW_JOYSTICK_9           8
CONSTANT: GLFW_JOYSTICK_10          9
CONSTANT: GLFW_JOYSTICK_11          10
CONSTANT: GLFW_JOYSTICK_12          11
CONSTANT: GLFW_JOYSTICK_13          12
CONSTANT: GLFW_JOYSTICK_14          13
CONSTANT: GLFW_JOYSTICK_15          14
CONSTANT: GLFW_JOYSTICK_16          15
CONSTANT: GLFW_JOYSTICK_LAST        GLFW_JOYSTICK_16
! ------------------------------------------------------------------------------------
! Misc
CONSTANT: GLFW_NOT_INITIALIZED        0x00010001
CONSTANT: GLFW_NO_CURRENT_CONTEXT     0x00010002
CONSTANT: GLFW_INVALID_ENUM           0x00010003
CONSTANT: GLFW_INVALID_VALUE          0x00010004
CONSTANT: GLFW_OUT_OF_MEMORY          0x00010005
CONSTANT: GLFW_API_UNAVAILABLE        0x00010006
CONSTANT: GLFW_VERSION_UNAVAILABLE    0x00010007
CONSTANT: GLFW_PLATFORM_ERROR         0x00010008
CONSTANT: GLFW_FORMAT_UNAVAILABLE     0x00010009

CONSTANT: GLFW_FOCUSED                0x00020001
CONSTANT: GLFW_ICONIFIED              0x00020002
CONSTANT: GLFW_RESIZABLE              0x00020003
CONSTANT: GLFW_VISIBLE                0x00020004
CONSTANT: GLFW_DECORATED              0x00020005

CONSTANT: GLFW_RED_BITS               0x00021001
CONSTANT: GLFW_GREEN_BITS             0x00021002
CONSTANT: GLFW_BLUE_BITS              0x00021003
CONSTANT: GLFW_ALPHA_BITS             0x00021004
CONSTANT: GLFW_DEPTH_BITS             0x00021005
CONSTANT: GLFW_STENCIL_BITS           0x00021006
CONSTANT: GLFW_ACCUM_RED_BITS         0x00021007
CONSTANT: GLFW_ACCUM_GREEN_BITS       0x00021008
CONSTANT: GLFW_ACCUM_BLUE_BITS        0x00021009
CONSTANT: GLFW_ACCUM_ALPHA_BITS       0x0002100A
CONSTANT: GLFW_AUX_BUFFERS            0x0002100B
CONSTANT: GLFW_STEREO                 0x0002100C
CONSTANT: GLFW_SAMPLES                0x0002100D
CONSTANT: GLFW_SRGB_CAPABLE           0x0002100E
CONSTANT: GLFW_REFRESH_RATE           0x0002100F

CONSTANT: GLFW_CLIENT_API             0x00022001
CONSTANT: GLFW_CONTEXT_VERSION_MAJOR  0x00022002
CONSTANT: GLFW_CONTEXT_VERSION_MINOR  0x00022003
CONSTANT: GLFW_CONTEXT_REVISION       0x00022004
CONSTANT: GLFW_CONTEXT_ROBUSTNESS     0x00022005
CONSTANT: GLFW_OPENGL_FORWARD_COMPAT  0x00022006
CONSTANT: GLFW_OPENGL_DEBUG_CONTEXT   0x00022007
CONSTANT: GLFW_OPENGL_PROFILE         0x00022008

CONSTANT: GLFW_OPENGL_API             0x00030001
CONSTANT: GLFW_OPENGL_ES_API          0x00030002

CONSTANT: GLFW_NO_ROBUSTNESS                   0
CONSTANT: GLFW_NO_RESET_NOTIFICATION  0x00031001
CONSTANT: GLFW_LOSE_CONTEXT_ON_RESET  0x00031002

CONSTANT: GLFW_OPENGL_ANY_PROFILE              0
CONSTANT: GLFW_OPENGL_CORE_PROFILE    0x00032001
CONSTANT: GLFW_OPENGL_COMPAT_PROFILE  0x00032002

CONSTANT: GLFW_CURSOR                 0x00033001
CONSTANT: GLFW_STICKY_KEYS            0x00033002
CONSTANT: GLFW_STICKY_MOUSE_BUTTONS   0x00033003

CONSTANT: GLFW_CURSOR_NORMAL          0x00034001
CONSTANT: GLFW_CURSOR_HIDDEN          0x00034002
CONSTANT: GLFW_CURSOR_DISABLED        0x00034003

CONSTANT: GLFW_CONNECTED              0x00040001
CONSTANT: GLFW_DISCONNECTED           0x00040002
! ------------------------------------------------------------------------------------
C-TYPE: GLFWmonitor
C-TYPE: GLFWwindow

TYPEDEF:    GLFWmonitor*     GLFWmonitor
TYPEDEF:    GLFWwindow*      GLFWwindow

FUNCTION:   int              glfwInit ( ) ;
FUNCTION:   GLFWmonitor      glfwGetPrimaryMonitor ( ) ;
FUNCTION:   GLFWwindow       glfwCreateWindow ( int width,
                                                int height,
                                                char* title,
                                                GLFWmonitor* monitor,
                                                GLFWwindow* share ) ;

<PRIVATE
: string>char* ( string -- char* ) utf8 string>alien >c-ptr ;
PRIVATE>

! Creates window with specified size
: glfw-create-window ( width height title  -- GLFWwindow* )
    string>char*              ! factor string to *char
    f                         ! use glfwGetPrimaryMonitor for fullscreen mode
    f glfwCreateWindow ;

! Creates fullscreen window with specified resolution
: glfw-create-window-fullscreen ( width height title -- GLFWwindow* )
    string>char*
    glfwGetPrimaryMonitor
    f glfwCreateWindow ;
