using BusinessObjects;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessLayer
{
    public class TestResultDAO
    {
        public List<TestResult> GetTestResults()
        {
            using var context = new DnasystemContext();
            return context.TestResults.Include(x => x.Booking)
                           .Include(x => x.Customer)
                           .Include(x => x.Staff)
                           .Include(x => x.Service)
                           .ToList();
        }

        public TestResult GetTestResultById(string resultId)
        {
            using var context = new DnasystemContext();
            return context.TestResults.FirstOrDefault(x => x.ResultId == resultId);
        }

        public void AddTestResult(TestResult testResult)
        {
            using var context = new DnasystemContext();
            context.TestResults.Add(testResult);
            context.SaveChanges();
        }
        public void UpdateTestResult(TestResult testResult)
        {
            using var context = new DnasystemContext();
            context.TestResults.Update(testResult);
            context.SaveChanges();
        }
        public void DeleteTestResult(TestResult testResult)
        {
            using var context = new DnasystemContext();
            context.TestResults.Remove(testResult);
            context.SaveChanges();
        }

        public string GenerateNewTestResultId()
        {
            using var context = new DnasystemContext();

            var lastTestResult = context.TestResults
                .Where(t => t.ResultId.StartsWith("TR"))
                .OrderByDescending(s => s.ResultId)
                .FirstOrDefault();

            if (lastTestResult == null)
            {
                return "TR001";
            }

            // Tách phần số và tăng lên
            var numberPart = int.Parse(lastTestResult.ResultId.Substring(2));
            return "TR" + (numberPart + 1).ToString("D3");
        }

    }
}
