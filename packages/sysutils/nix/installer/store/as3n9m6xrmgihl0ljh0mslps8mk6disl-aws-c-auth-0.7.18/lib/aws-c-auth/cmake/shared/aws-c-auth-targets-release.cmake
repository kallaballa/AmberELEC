#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "AWS::aws-c-auth" for configuration "Release"
set_property(TARGET AWS::aws-c-auth APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(AWS::aws-c-auth PROPERTIES
  IMPORTED_LOCATION_RELEASE "/nix/store/as3n9m6xrmgihl0ljh0mslps8mk6disl-aws-c-auth-0.7.18/lib/libaws-c-auth.so.1.0.0"
  IMPORTED_SONAME_RELEASE "libaws-c-auth.so.1.0.0"
  )

list(APPEND _cmake_import_check_targets AWS::aws-c-auth )
list(APPEND _cmake_import_check_files_for_AWS::aws-c-auth "/nix/store/as3n9m6xrmgihl0ljh0mslps8mk6disl-aws-c-auth-0.7.18/lib/libaws-c-auth.so.1.0.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
