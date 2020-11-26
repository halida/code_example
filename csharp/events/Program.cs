using System;

namespace events
{
    public class SampleEventArgs : EventArgs
    {
        public SampleEventArgs(string s) { Text = s; }
        public String Text { get; } // readonly
    }

    public class Publisher
    {
        public event EventHandler<SampleEventArgs> SampleEvent;

        public virtual void RaiseSampleEvent()
        {
            // Raise the event in a thread-safe manner using the ?. operator.
            SampleEvent?.Invoke(this, new SampleEventArgs("Hello"));
        }
    }

    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello World!");

            var pub = new Publisher();
            pub.SampleEvent += (t, e) => Console.WriteLine($"on event: {e.Text}");
            pub.RaiseSampleEvent();
        }
    }
}
