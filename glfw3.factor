! Copyright (C) 2014 alex_zlov
! See http://factorcode.org/license.txt for BSD license.
USING: alien alien.c-types alien.libraries alien.parser alien.syntax 
       alien.strings system combinators io.encodings.utf8 ;

IN: glfw3

<< "glfw3" {
    { [ os windows? ] [ "glfw3.dll" ] }
    { [ os macosx?  ] [ "libglfw3.3.0.dylib" ] }
    { [ os unix?    ] [ "libflfw.so.3" ] }
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
CONSTANT: GLFW_KEY_ESCAPE          256
CONSTANT: GLFW_KEY_ENTER           257
CONSTANT: GLFW_KEY_TAB             258
CONSTANT: GLFW_KEY_BACKSPACE       259
CONSTANT: GLFW_KEY_INSERT          260
CONSTANT: GLFW_KEY_DELETE          261
CONSTANT: GLFW_KEY_RIGHT           262
CONSTANT: GLFW_KEY_LEFT            263
CONSTANT: GLFW_KEY_DOWN            264
CONSTANT: GLFW_KEY_UP              265
CONSTANT: GLFW_KEY_PAGE_UP         266
CONSTANT: GLFW_KEY_PAGE_DOWN       267
CONSTANT: GLFW_KEY_HOME            268
CONSTANT: GLFW_KEY_END             269
CONSTANT: GLFW_KEY_CAPS_LOCK       280
CONSTANT: GLFW_KEY_SCROLL_LOCK     281
CONSTANT: GLFW_KEY_NUM_LOCK        282
CONSTANT: GLFW_KEY_PRINT_SCREEN    283
CONSTANT: GLFW_KEY_PAUSE           284
CONSTANT: GLFW_KEY_F1              290
CONSTANT: GLFW_KEY_F2              291
CONSTANT: GLFW_KEY_F3              292
CONSTANT: GLFW_KEY_F4              293
CONSTANT: GLFW_KEY_F5              294 
CONSTANT: GLFW_KEY_F6              295
CONSTANT: GLFW_KEY_F7              296
CONSTANT: GLFW_KEY_F8              297
CONSTANT: GLFW_KEY_F9              298
CONSTANT: GLFW_KEY_F10             299
CONSTANT: GLFW_KEY_F11             300
CONSTANT: GLFW_KEY_F12             301
CONSTANT: GLFW_KEY_F13             302
CONSTANT: GLFW_KEY_F14             303
CONSTANT: GLFW_KEY_F15             304
CONSTANT: GLFW_KEY_F16             305
CONSTANT: GLFW_KEY_F17             306











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
