using System;
using System.Collections.Generic;
using System.IO;
using System.Text.RegularExpressions;

class Program
{
    static void Main()
    {
        DateTime starttime = DateTime.Now;

        // Switch between inputs
        bool test = false;
        string inputfile;
        if (test)
        {
            inputfile = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "exampleinput.txt");
        }
        else
        {
            inputfile = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "input.txt");
        }

        List<int> left = new List<int>();
        List<int> right = new List<int>();
        int count = 0;

        // Read the file and process each line with regex
        string pattern = @"^\s*(?<left>\d+)\s+(?<right>\d+)\s*$";
        Regex regex = new Regex(pattern);

        foreach (string line in File.ReadLines(inputfile))
        {
            Match match = regex.Match(line);
            if (match.Success)
            {
                left.Add(int.Parse(match.Groups["left"].Value));
                right.Add(int.Parse(match.Groups["right"].Value));
                count++;
            }
        }

        right.Sort();
        left.Sort();
        int sum = 0;
        for (int i = 0; i < count; i++)
        {
            sum += Math.Abs(right[i] - left[i]);
        }

        DateTime endtime = DateTime.Now;
        TimeSpan duration = endtime - starttime;
        if (duration.TotalSeconds < 1)
        {
            Console.WriteLine($"Duration: {duration.TotalMilliseconds} milliseconds");
        }
        else
        {
            Console.WriteLine($"Duration: {duration.TotalSeconds} seconds");
        }
        Console.WriteLine(sum);
    }
}