cmake_minimum_required(VERSION 3.15...3.23)

project(CmakeConfigPackageTests 
  VERSION ${PROJECT_VERSION}
  LANGUAGES CXX)

# ---- Test as standalone project the exported config package ----

if(PROJECT_IS_TOP_LEVEL OR TEST_INSTALLED_VERSION)
  enable_testing()

  find_package(newsround_cpp CONFIG REQUIRED) # for intro, project_options, ...

  if(NOT TARGET newsround_cpp_options)
    message(FATAL_ERROR "Required config package not found!")
    return() # be strictly paranoid for Template Janitor github action! CK
  endif()
endif()

# ---- Dependencies ----

# GoogleTest
include(FetchContent)
FetchContent_Declare(
  googletest
  URL https://github.com/google/googletest/archive/03597a01ee50ed33e9dfd640b249b4be3799d395.zip
)
# For Windows: Prevent overriding the parent project's compiler/linker settings
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
FetchContent_MakeAvailable(googletest)

# Disable static analysis on GoogleTest targets
set_target_properties(gtest gtest_main gmock gmock_main
  PROPERTIES
    CXX_CLANG_TIDY ""
    C_CLANG_TIDY ""
)

include(GoogleTest)

add_executable(tests tests.cpp)
target_link_libraries(
  tests
  PRIVATE newsround_cpp::newsround_cpp_warnings
          newsround_cpp::newsround_cpp_options
          GTest::gtest_main
)

gtest_discover_tests(tests)

newsround_cpp_configure_linker(tests)

if(WIN32 AND BUILD_SHARED_LIBS)
  add_custom_command(
    TARGET tests
    PRE_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_RUNTIME_DLLS:tests> $<TARGET_FILE_DIR:tests>
    COMMAND_EXPAND_LISTS)
endif()
