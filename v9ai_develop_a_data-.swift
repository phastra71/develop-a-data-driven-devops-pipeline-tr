// v9ai_develop_a_data-.swift
// A data-driven DevOps pipeline tracker

import Foundation

// Define a struct to represent a pipeline stage
struct PipelineStage {
    let name: String
    let status: String
    let timestamp: Date
}

// Define a struct to represent a pipeline
struct Pipeline {
    let id: UUID
    let stages: [PipelineStage]
}

// Define a class to track pipeline data
class PipelineTracker {
    private var pipelines: [UUID: Pipeline] = [:]
    
    // Add a new pipeline
    func addPipeline(id: UUID, stages: [PipelineStage]) {
        pipelines[id] = Pipeline(id: id, stages: stages)
    }
    
    // Update a pipeline stage
    func updateStage(pipelineId: UUID, stageName: String, status: String) {
        guard let pipeline = pipelines[pipelineId] else { return }
        if let index = pipeline.stages.firstIndex(where: { $0.name == stageName }) {
            pipeline.stages[index].status = status
            pipeline.stages[index].timestamp = Date()
        }
    }
    
    // Get a pipeline by ID
    func getPipeline(id: UUID) -> Pipeline? {
        return pipelines[id]
    }
    
    // Get all pipelines
    func getAllPipelines() -> [Pipeline] {
        return Array(pipelines.values)
    }
}

// Example usage
let tracker = PipelineTracker()

let pipelineId = UUID()
let stage1 = PipelineStage(name: "Build", status: "Success", timestamp: Date())
let stage2 = PipelineStage(name: "Test", status: "Pending", timestamp: Date())
tracker.addPipeline(id: pipelineId, stages: [stage1, stage2])

tracker.updateStage(pipelineId: pipelineId, stageName: "Test", status: "Success")

if let pipeline = tracker.getPipeline(id: pipelineId) {
    print("Pipeline \(pipeline.id):")
    for stage in pipeline.stages {
        print("  \(stage.name): \(stage.status) at \(stage.timestamp)")
    }
}

let allPipelines = tracker.getAllPipelines()
for pipeline in allPipelines {
    print("Pipeline \(pipeline.id):")
    for stage in pipeline.stages {
        print("  \(stage.name): \(stage.status) at \(stage.timestamp)")
    }
}