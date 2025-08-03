using BusinessObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services
{
    public interface ITestResultService
    {
        public List<TestResult> GetTestResults();
        public TestResult GetTestResultById(string resultId);

        public void AddTestResult(TestResult testResult);
        public void UpdateTestResult(TestResult testResult);
        public void DeleteTestResult(TestResult testResult);
    }
}
