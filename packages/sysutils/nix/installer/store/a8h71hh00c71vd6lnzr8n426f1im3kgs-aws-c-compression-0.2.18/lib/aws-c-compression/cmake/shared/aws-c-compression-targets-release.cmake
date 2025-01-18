#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "AWS::aws-c-compression" for configuration "Release"
set_property(TARGET AWS::aws-c-compression APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(AWS::aws-c-compression PROPERTIES
  IMPORTED_LOCATION_RELEASE "/nix/store/a8h71hh00c71vd6lnzr8n426f1im3kgs-aws-c-compression-0.2.18/lib/libaws-c-compression.so.1.0.0"
  IMPORTED_SONAME_RELEASE "libaws-c-compression.so.1.0.0"
  )

list(APPEND _cmake_import_check_targets AWS::aws-c-compression )
list(APPEND _cmake_import_check_files_for_AWS::aws-c-compression "/nix/store/a8h71hh00c71vd6lnzr8n426f1im3kgs-aws-c-compression-0.2.18/lib/libaws-c-compression.so.1.0.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
