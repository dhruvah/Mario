cmake_minimum_required(VERSION 3.10)
project(MarioGame)

# Set C++11 standard
set(CMAKE_CXX_STANDARD 11)

# Set the path to the DevIL includes and libraries manually
include_directories(/usr/include)
link_directories(/usr/lib/x86_64-linux-gnu)

# Find packages
find_package(SDL2 REQUIRED)
find_package(OpenGL REQUIRED)
find_package(GLEW REQUIRED)  # If you use GLEW in your project
find_package(Boost REQUIRED COMPONENTS system filesystem)  # Specify needed Boost libraries

# Include directories for header files
include_directories(source)
include_directories(/usr/include/rapidxml)

# Add DevIL manually if CMake can't find it
set(IL_LIBRARIES IL ILU)

# Include directories
include_directories(
    ${SDL2_INCLUDE_DIRS}
    ${OPENGL_INCLUDE_DIRS}
    ${GLEW_INCLUDE_DIRS}
    ${Boost_INCLUDE_DIRS}
    ${IL_INCLUDE_DIRS}
)

# Automatically include all source files
file(GLOB_RECURSE SOURCES "source/*.cpp")

# Define the executable
add_executable(MarioGame ${SOURCES})

# Link libraries
find_package(SDL2 REQUIRED)
include_directories(${SDL2_INCLUDE_DIRS})
# Link libraries
target_link_libraries(MarioGame ${OPENGL_LIBRARIES}
 ${GLEW_LIBRARIES} ${Boost_LIBRARIES} ${IL_LIBRARIES} ${SDL2_LIBRARIES} -lSDL2_mixer)

find_package(Boost REQUIRED)
include_directories(${Boost_INCLUDE_DIRS})
target_link_libraries(MarioGame ${Boost_LIBRARIES})

# You would need to find or add other required libraries similarly
