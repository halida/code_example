// simple.d - Copyright (C) 2003 Pat Thoyts <patthoyts@users.sf.net>
//
// Demonstrate linking to Tcl from the D programming language.
// See http://www.digitalmars.com/d/index.html for information
// about ``D''
//
// $Id: 6261,v 1.28 2006-11-20 19:00:16 jcw Exp $

import std.stream;
import std.string;
import std.compiler;

// ----------------------------------------------------------------------
// Define the bits we need for interfacing to Tcl API
//
extern (C) {
    alias void* ClientData;
    alias void * function (char* blockPtr) Tcl_FreeProc;
    alias void * function (ClientData clientData) Tcl_CmdDeleteProc;
    alias int  * function (ClientData clientData, Tcl_Interp* interp,
                             int argc, char* argv[]) Tcl_CmdProc;
    alias void* Tcl_Command;

    struct Tcl_Interp {
        char* result;
        Tcl_FreeProc blockPtr;
        int errorLine;
    }

    enum {
        TCL_OK       = 0,
        TCL_ERROR    = 1,
        TCL_RETURN   = 2,
        TCL_BREAK    = 3,
        TCL_CONTINUE = 4,
    }

    const Tcl_FreeProc TCL_VOLATILE = cast(Tcl_FreeProc)1;
    const Tcl_FreeProc TCL_STATIC   = cast(Tcl_FreeProc)0;
    const Tcl_FreeProc TCL_DYNAMIC  = cast(Tcl_FreeProc)3;

    Tcl_Interp* Tcl_CreateInterp();
    Tcl_Command Tcl_CreateCommand(Tcl_Interp* interp, char* cmdName,
                                  Tcl_CmdProc proc,
                                  ClientData clientData,
                                  Tcl_CmdDeleteProc deleteProc);
    int   Tcl_Eval           (Tcl_Interp* interp, char* string);
    int   Tcl_EvalFile       (Tcl_Interp* interp, char* fileName);
    char* Tcl_GetStringResult(Tcl_Interp* interp);
    void  Tcl_SetResult      (Tcl_Interp* interp, char* str,
                              Tcl_FreeProc freeProc);
}

// ----------------------------------------------------------------------
int main(char[][] args)
{
    Tcl_Interp* interp = Tcl_CreateInterp();

    // Tcl_CreateCommand(interp, "ddemo", &DDemoCmd,
    //                   null, null);

    int r;
    if( args.length < 2 )
        {
            r = Tcl_Eval(interp, "puts \"Tcl version: [info tcl]\"; ddemo");
        }
    else
        {
            r = Tcl_EvalFile(interp, args[1]);
        }
    printf(Tcl_GetStringResult(interp));
    return r;
}

// Add a new command to the Tcl interpreter.
// In this case: return some information about the D compiler.
extern (C):
int
DDemoCmd(ClientData clientData, Tcl_Interp *interp, int argc, char* argv[])
{
    MemoryStream stm = new MemoryStream;
    stm.printf(std.compiler.name);
    stm.printf(" %d.%d", std.compiler.version_major, std.compiler.version_minor);
    Tcl_SetResult(interp, toStringz(stm.toString()), TCL_STATIC);
    return TCL_OK;
}

// ----------------------------------------------------------------------
//
// Local variables:
//   mode: c
//   compile-command: "dmd simple.d tcl83.lib"
//   cygwin: "gdc simple.d -ltcl"
// End:
