//
//  ViewModel.swift
//  Pace4You
//
//  Created by Marcelo Amaral Alves on 2024-06-14.
//

import SwiftUI
import Combine

class RunViewModel: ObservableObject {
    @Published var runs: [Run] = []
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        // Initialize with some mock data or fetch from a service
    }
    
    func startRun() {
        // Logic to start a run
    }
    
    func endRun() {
        // Logic to end a run and save data
    }
}

