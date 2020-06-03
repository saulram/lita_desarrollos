String getResidentes = r'''
query {
    usersDirectory {
        completeName
        phone
        departmentId {
            _id
            name
        }
    }
}
''';
String getPersonal = r''' 
query {
    personalDirectory {
        _id
        completeName
        phone
        jobTitle
        description
        fullFile
        personalSchedule
    }
}
''';

String getGeneral = r'''
query($category: String) {
    directories(category: $category) {
        _id
        title
        phone
        category
        description
        isActive
        updatedAtFormat
    }
}
    ''';