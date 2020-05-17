//
//  ContentView.swift
//  Karaktero
//
//  Created by Andreas Madsen on 02/05/2020.
//  Copyright © 2020 Madsen. All rights reserved.
//

import SwiftUI


struct WelcomeView: View {
    var body: some View {
        GradeListView().environmentObject(AnyViewModel(GradeListViewModel(cdmanager: CoreDataManager())))
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
