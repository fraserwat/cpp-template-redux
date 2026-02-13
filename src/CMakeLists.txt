add_executable(intro main.cpp)

target_link_libraries(
  intro
  PRIVATE newsround_cpp::newsround_cpp_options
          newsround_cpp::newsround_cpp_warnings)

newsround_cpp_configure_linker(intro)
