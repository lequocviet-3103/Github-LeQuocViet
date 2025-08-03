using BusinessObjects;
using DataAccessLayer;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Repositories
{
    public interface ITestResultRepository
    {
        public List<TestResult> GetTestResults();
        public TestResult GetTestResultById(string resultId);

        public void AddTestResult(TestResult testResult);
        public void UpdateTestResult(TestResult testResult);
        public void DeleteTestResult(TestResult testResult);

        public string GenerateNewTestResultId();
    }
}
