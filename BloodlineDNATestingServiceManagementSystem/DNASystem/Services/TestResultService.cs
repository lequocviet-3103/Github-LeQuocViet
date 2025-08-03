using BusinessObjects;
using Repositories;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services
{
    public class TestResultService : ITestResultService
    {
        private readonly ITestResultRepository testResultRepository;
        public TestResultService()
        {
            testResultRepository = new TestResultRepository();
        }
        public List<TestResult> GetTestResults()
        {
            return testResultRepository.GetTestResults();
        }
        public TestResult GetTestResultById(string resultId)
        {
            return testResultRepository.GetTestResultById(resultId);
        }
        public void AddTestResult(TestResult testResult)
        {
            testResult.ResultId =  testResultRepository.GenerateNewTestResultId();
            testResultRepository.AddTestResult(testResult);
        }
        public void UpdateTestResult(TestResult testResult)
        {
            testResultRepository.UpdateTestResult(testResult);
        }
        public void DeleteTestResult(TestResult testResult)
        {
            testResultRepository.DeleteTestResult(testResult);
        }
       
    }
}
