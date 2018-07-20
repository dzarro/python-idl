#!/bin/csh -f 

# Mac OS fix for IDL-Python bridge using Anaconda/Python 2.7 and IDL 8.5.
# Make sure to define or hardwire $TOP and $IDL_DIR beforehand to your local setup.
# Run as "sudo csh pyidl_mac_fix.csh"
# I have no idea how this works, but I cribbed it from extensive Google searching.

# Zarro (ADNET) 10-13-17 

set CWD = `pwd` 
onintr catch

setenv TOP /Users/zarro/anaconda2
setenv IDL_DIR /Users/zarro//idl85

setenv PATH $TOP/bin:${PATH} 
setenv PYTHONHOME $TOP
setenv PYTHONPATH $IDL_DIR/bin/bin.darwin.x86_64:$IDL_DIR/lib/bridges 

cd $IDL_DIR/bin/bin.darwin.x86_64 

install_name_tool -change libpython2.7.dylib $TOP/lib/libpython2.7.dylib idl_python27.so 
otool -L idl_python27.so
install_name_tool -change libidl_ips.8.5.dylib @loader_path/libidl_ips.8.5.dylib pythonidl27.so 
install_name_tool -change libpython2.7.dylib $TOP/lib/libpython2.7.dylib pythonidl27.so 
install_name_tool -change libMesaGL6_2.dylib @loader_path/libMesaGL6_2.dylib libidl.8.5.dylib 
install_name_tool -change libMesaGLU6_2.dylib @loader_path/libMesaGLU6_2.dylib libidl.8.5.dylib 
install_name_tool -change libOSMesa6_2.dylib @loader_path/libOSMesa6_2.dylib libidl.8.5.dylib 
install_name_tool -change libXm.3.0.2.dylib @loader_path/libXm.3.0.2.dylib libidl.8.5.dylib 
install_name_tool -change libMesaGL6_2.dylib @loader_path/libMesaGL6_2.dylib libMesaGLU6_2.dylib 
install_name_tool -change libMesaGL6_2.dylib @loader_path/libMesaGL6_2.dylib libOSMesa6_2.dylib 
install_name_tool -change libidl.8.5.dylib @loader_path/libidl.8.5.dylib libidl_ips.8.5.dylib 

catch: 
if ($?CWD) then  
 cd $CWD 
endif
