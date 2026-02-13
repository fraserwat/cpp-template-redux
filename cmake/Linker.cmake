macro(newsround_cpp_configure_linker project_name)
  set(newsround_cpp_USER_LINKER_OPTION
    "DEFAULT"
      CACHE STRING "Linker to be used")
    set(newsround_cpp_USER_LINKER_OPTION_VALUES "DEFAULT" "SYSTEM" "LLD" "GOLD" "BFD" "MOLD" "SOLD" "APPLE_CLASSIC" "MSVC")
  set_property(CACHE newsround_cpp_USER_LINKER_OPTION PROPERTY STRINGS ${newsround_cpp_USER_LINKER_OPTION_VALUES})
  list(
    FIND
    newsround_cpp_USER_LINKER_OPTION_VALUES
    ${newsround_cpp_USER_LINKER_OPTION}
    newsround_cpp_USER_LINKER_OPTION_INDEX)

  if(${newsround_cpp_USER_LINKER_OPTION_INDEX} EQUAL -1)
    message(
      STATUS
        "Using custom linker: '${newsround_cpp_USER_LINKER_OPTION}', explicitly supported entries are ${newsround_cpp_USER_LINKER_OPTION_VALUES}")
  endif()

  set_target_properties(${project_name} PROPERTIES LINKER_TYPE "${newsround_cpp_USER_LINKER_OPTION}")
endmacro()
