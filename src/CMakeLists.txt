add_executable(intro main.cpp)

target_link_libraries(
  intro
  PRIVATE cpp_template_redux::cpp_template_redux_options
          cpp_template_redux::cpp_template_redux_warnings)

cpp_template_redux_configure_linker(intro)
