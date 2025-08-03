using BusinessObjects;
using DataAccessLayer;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Repositories
{
    public class TestResultRepository : ITestResultRepository
    {
        private TestResultDAO testResultDAO = new TestResultDAO();
        public List<TestResult> GetTestResults()
        {
            return testResultDAO.GetTestResults();
        }
        public TestResult GetTestResultById(string resultId)
        {
            return testResultDAO.GetTestResultById(resultId);
        }

        public void AddTestResult(TestResult testResult)
        {
            testResultDAO.AddTestResult(testResult);
        }
        public void UpdateTestResult(TestResult testResult)
        {
            testResultDAO.UpdateTestResult(testResult);
        }
        public void DeleteTestResult(TestResult testResult)
        {
            testResultDAO.DeleteTestResult(testResult);
        }
        public string GenerateNewTestResultId()
        {
                       return testResultDAO.GenerateNewTestResultId();
        }
    }
}
