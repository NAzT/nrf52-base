# JLink functions
# Adds targets for JLink programmers and emulators

# Configure flasher script for the project
set(BINARY ${TARGET}.bin)

configure_file(${CMAKE_CURRENT_LIST_DIR}/flash.in ${CMAKE_CURRENT_BINARY_DIR}/flash.jlink)
configure_file(${CMAKE_CURRENT_LIST_DIR}/flash-softdevice.in ${CMAKE_CURRENT_BINARY_DIR}/flash-softdevice.jlink)

#Add JLink commands
add_custom_target(debug 
	COMMAND ${DEBUGGER} -tui -command ${CMAKE_CURRENT_LIST_DIR}/remote.gdbconf ${CMAKE_CURRENT_BINARY_DIR}/${TARGET} 
	DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/${TARGET}
	)

add_custom_target(debug-server 
	COMMAND JLinkGDBServer -device ${DEVICE} -speed 4000 -if SWD
	DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/${TARGET}.bin
	)

add_custom_target(flash 
	COMMAND JLinkExe -device ${DEVICE} -speed 4000 -if SWD -CommanderScript ${CMAKE_CURRENT_BINARY_DIR}/flash.jlink 
	DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/${TARGET}.bin
	)

add_custom_target(flash-softdevice 
	COMMAND JLinkExe -device ${DEVICE} -speed 4000 -if SWD -CommanderScript ${CMAKE_CURRENT_BINARY_DIR}/flash-softdevice.jlink 
	DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/${TARGET}.bin
	)

add_custom_target(erase 
	COMMAND JLinkExe -device ${DEVICE} -speed 4000 -if SWD -CommanderScript ${CMAKE_CURRENT_LIST_DIR}/erase.jlink 
	)

add_custom_target(reset 
	COMMAND JLinkExe -device ${DEVICE} -speed 4000 -if SWD -CommanderScript ${CMAKE_CURRENT_LIST_DIR}/reset.jlink 
	)
