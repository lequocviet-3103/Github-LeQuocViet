﻿public class UpdateLabTestDTO
{
    public string RequestID { get; set; }
//    public string TreatmentPlantID { get; set; } tách riêng với booking khám điều trị
    public string TestName { get; set; }
    public string TestType { get; set; }
    public string ResultValue { get; set; }
    public int? CD4Initial { get; set; }
    public int? ViralLoadInitial { get; set; }
    public string Status { get; set; }
    public string Description { get; set; }
}