#!/usr/bin/rdmd

import std.stdio;
import std.string;
import std.process;

struct S{
    string server;
    uint port;
}

void main(string[] args) {
    S[string] si;
    si["ls"] = S("guru@10.77.77.200", 2222);
    si["lf"] = S("10.77.77.105", 22);
    si["gd"] = S("railsdeploy@gurudigger.com", 2222);
    si["cr"] = S("crawler@counter.gurudigger.com", 2222);
    si["lj"] = S("linjunhalida.com", 2222);
    si["pr"] = S("webuser@pythonvsruby.org", 22);

    if (args.length <= 1) {
        writeln("need server info.");
        return;
    }

    auto keyword = args[1];

    if ((keyword in si) is null) {
            writefln("cannot find server info: %s", keyword);
            return;
    }

    S d = si[keyword];
    string cmd = format("mosh %s --ssh='ssh -p %d'", d.server, d.port);
    std.process.system(cmd);
}
