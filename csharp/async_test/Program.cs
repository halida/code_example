using System;
using System.Threading;
using System.Threading.Tasks;

namespace async_test
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello World!");
            RunTasks();
        }

        static void RunTasks()
        {
            Log($"thread: { Thread.GetCurrentProcessorId() }");
            var t1 = HotWater();
            var t2 = CookTea();
            var t3 = BakeBread();
            Task.WaitAll(new Task[] { t1, t2, t3 });
            Log("finished");
        }

        private static async Task BakeBread()
        {
            Log("bake bread");
            await Task.Delay(1000);
            Log("bake bread done");
        }

        private static async Task CookTea()
        {
            Log("cook tea");
            await Task.Delay(2000);
            Log("cook tea done");
        }

        private static async Task HotWater()
        {
            Log("hot water");
            await Task.Delay(3000);
            Log("hot water done");
        }

        public static void Log(string msg)
        {
            Console.WriteLine($"{ DateTime.Now.ToString("yyyy-M-dd-HH:mm:ss.fffffff") }\t#{Thread.GetCurrentProcessorId()}\t{msg}");
        }
    }
}
