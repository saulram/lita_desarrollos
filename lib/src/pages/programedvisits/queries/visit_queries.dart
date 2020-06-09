
String addVisita = r'''
mutation($visitorsName: String, $type: VisitTypes, $vehicleModel: String $licensePlate: String, $scheduleAt: String, $untilDate: String) {
    addVisit(input: { visitorsName: $visitorsName, type: $type, vehicleModel: $vehicleModel, licensePlate: $licensePlate, scheduleAt: $scheduleAt, untilDate: $untilDate }) {
        departmentId {
            name
        }
        visitorsName
        type
        typeFormat
        vehicleModel
        licensePlate
        scheduleAtFormat
        untilDateFormat
        code
        codeUrl
    }
}
''';

String getVisitas = r'''
query {
    visits {
        departmentId {
            name
        }
        visitorsName
        type
        typeFormat
        vehicleModel
        licensePlate
        scheduleAtFormat
        untilDateFormat
        code
        codeUrl
        accessCode
    }
}
''';