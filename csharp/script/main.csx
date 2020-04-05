#!/usr/bin/env dotnet-script
#nullable enable
#r "nuget: Newtonsoft.Json, 12.0.3"

using Newtonsoft.Json;

void Run()
{
    Console.WriteLine("Got arguments:");

    foreach (var arg in Args)
    {
        Console.WriteLine(arg);
    }
    Console.WriteLine("");

    var data = new { name = "me", score = 120, rate = 3.0 };
    string json = JsonConvert.SerializeObject(data);
    Console.WriteLine(json);
}


Run();