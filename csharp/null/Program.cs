using System;

namespace Null
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello World!");
            Work(null);
        }

        static void Work(string? name)
        {
            if (name == null) { return; }
            Console.WriteLine(name.Length);
        }
    }
}
