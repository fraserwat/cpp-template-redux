add_executable(intro main.cpp)

target_link_libraries(
  intro
  PRIVATE myproject::myproject_options
          myproject::myproject_warnings)

myproject_configure_linker(intro)
