! Copyright (C) 2014 man213
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
CONSTANT: GLFW_VERSION_MAJOR            3
CONSTANT: GLFW_VERSION_MINOR            0
CONSTANT: GLFW_VERSION_REVISION         4
CONSTANT: GLFW_RELEASE                  0
CONSTANT: GLFW_PRESS                    1
CONSTANT: GLFW_REPEAT                   2

! The unknown key
CONSTANT: GLFW_KEY_UNKNOWN              -1

! Printable keys
CONSTANT: GLFW_KEY_SPACE                32
CONSTANT: GLFW_KEY_APOSTROPHE           39 ! '


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

: glfw-create-window ( width height title  -- GLFWwindow )
    utf8 string>alien >c-ptr ! factor string to *char
    glfwGetPrimaryMonitor
    f glfwCreateWindow ;