using System;
using System.Collections.Generic; 

namespace HelloWorld
{
    class Program
    {
        static void Main(string[] args)
        {
            var list = new List<int>(){1,2,3};
            foreach(var i in list){
                Console.Write(i);
                Console.Write(",");
            }

            Console.WriteLine("Hello World!");
        }
    }
}
